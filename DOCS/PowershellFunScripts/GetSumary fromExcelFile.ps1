
<#
.SYNOPSIS
  Scan first worksheet of multiple Excel files, find row by known text,
  read Nth column value, compute Average/Max/Min, and output a summary.

.REQUIREMENTS
  - Windows + Excel installed (COM automation).
  - Works with .xlsx and .xls.

.PARAMETERS
  -Folder          : Root folder containing Excel files.
  -Pattern         : File pattern(s) (e.g., *.xlsx, *.xls).
  -MarkerText      : The known text to search in a row.
  -ValueColumn     : Nth column (1-based) to read from the matching row.
  -SearchColumn    : If >0, search only this column (1-based). If 0, search entire row.
  -Contains        : Use substring match (default is exact match).
  -CaseSensitive   : Use case-sensitive match (default is case-insensitive).
  -OutCsv          : Optional CSV to save per-file values for auditing.

.EXAMPLE
  .\ScanExcel.ps1 -Folder "C:\share\excels" -Pattern "*.xlsx" -MarkerText "Total Time" -ValueColumn 5 -SearchColumn 0 -Contains -OutCsv "C:\share\results.csv"
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$Folder,

    [string]$Pattern = "*.xlsx",
	[string]$FileNameFilter="Final",

    [Parameter(Mandatory=$true)]
    [string]$MarkerText,

    [Parameter(Mandatory=$true)]
    [int]$ValueColumn,

    [int]$SearchColumn = 0,   # 0 = search any column in the row; >0 = only this column
    [switch]$Contains,        # if set, substring match; else exact match
    [switch]$CaseSensitive,   # if set, case-sensitive; else case-insensitive
    [string]$OutCsv           # optional CSV output path
)

function Convert-TimeToSeconds {
    <#
    .SYNOPSIS
      Convert a time value in string (hh:mm:ss or mm:ss) or Excel numeric OADate to total seconds.

    .DESCRIPTION
      - Accepts strings like "01:23:45", "23:45", optionally with milliseconds "01:23:45.678".
      - Accepts numeric Excel time values (OLE Automation Date) such as:
          * 0.5       => 12 hours (fraction of a day)
          * 45237.25  => a date+time; only time part is converted
      Returns [double] total seconds.
    #>
    param(
        [Parameter(Mandatory=$true)]
        [object]$InputValue
    )

    # If it's already numeric (Excel OADate or fraction), handle via DateTime conversion
    if ($InputValue -is [double] -or $InputValue -is [float] -or $InputValue -is [int]) {
        # Excel stores time as fraction of a day; full OADate might include date portion
        try {
            $dt = [datetime]::FromOADate([double]$InputValue)
            $seconds = ($dt.TimeOfDay.TotalSeconds)
            return [math]::Round($seconds, 3)
        } catch {
            throw "Invalid numeric OADate/time value: $InputValue"
        }
    }

    # Treat as string
    $s = ($InputValue | Out-String).Trim()
    if ([string]::IsNullOrWhiteSpace($s)) {
        throw "Empty time string."
    }

    # Accept hh:mm:ss(.fff) or mm:ss(.fff)
    # Split by ":" then parse; handle optional milliseconds using '.'.
    $parts = $s.Split(':')

    if ($parts.Count -lt 2 -or $parts.Count -gt 3) {
        throw "Time format not recognized: '$s'. Expected mm:ss or hh:mm:ss."
    }

    # Parse seconds (and optional .fff)
    $secPart = $parts[-1]
    $secWhole = $secPart
    $ms = 0
    if ($secPart -like '*.*') {
        $secWhole, $msPart = $secPart.Split('.', 2)
        if (-not [int]::TryParse($msPart, [ref]$msTmp)) {
            throw "Invalid milliseconds in '$s'."
        }
        # Normalize milliseconds to fraction
        # If "678" => 0.678 seconds
        $ms = [double]("0." + $msPart)
    }

    # Parse minutes
	$m=0
	    $minPart = $parts[-2]
    if (-not [int]::TryParse($minPart, [ref]$m)) {
        throw "Invalid minutes in '$s'."
    }

    # Parse hours if present
    $h = 0
	   $hourPart = $parts[-3]
    if ($parts.Count -eq 3) {
        if (-not [int]::TryParse( $hourPart, [ref]$h)) {
            throw "Invalid hours in '$s'."
        }
        if (-not [int]::TryParse(   $minPart, [ref]$m)) {
            throw "Invalid minutes in '$s'."
        }
    }

    # Seconds whole part
    if (-not [int]::TryParse($secWhole, [ref]$secWhole)) {
        throw "Invalid seconds in '$s'."
    }

    $total = ($h * 3600) + ($m * 60) + $secWhole + $ms
    return [math]::Round($total, 3)
}


# Helper: normalize cell to string
function Get-CellString {
    param([object]$CellVal)
    if ($null -eq $CellVal) { return "" }
    return [string]$CellVal
}

# Helper: string match per options
function Matches-Text {
    param(
        [string]$Candidate,
        [string]$Target,
        [switch]$Contains,
        [switch]$CaseSensitive
    )
    if (-not $CaseSensitive) {
        $Candidate = $Candidate.ToLowerInvariant()
        $Target    = $Target.ToLowerInvariant()
    }
    if ($Contains) {
        return ($Candidate -like "*$Target*")
    } else {
        return ($Candidate -eq $Target)
    }
}



# Collect files
$files = Get-ChildItem -Path $Folder -File -Include $Pattern -Recurse
if (-not $files) {
    Write-Error "No files matching '$Pattern' found under '$Folder'."
    return
}

# Prepare Excel COM
$excel = $null
try {
    $excel = New-Object -ComObject Excel.Application
    $excel.Visible = $false
    $excel.DisplayAlerts = $false
} catch {
    Write-Error "Failed to create Excel COM object. Ensure Microsoft Excel is installed." 
    return
}

$values     = New-Object System.Collections.Generic.List[double]
$perFile    = New-Object System.Collections.Generic.List[object]
$notFound   = @()
$nonNumeric = @()
$count=1
try {
    foreach ($file in $files) {
		if( $file.FullName -NotMatch $FileNameFilter)
		{
			continue
		}
		Write-Host "Procesing the File # $count and File Name: $($file.Name) "
        $wb = $null
        try {
            $wb = $excel.Workbooks.Open($file.FullName, $false, $true) # Open read-only
            $ws = $wb.Worksheets.Item(1)
            $used = $ws.UsedRange
            $rowCount = $used.Rows.Count
            $colCount = $used.Columns.Count

            $matchRow = 0

            for ($r = 1; $r -le $rowCount -and $matchRow -eq 0; $r++) {
                if ($SearchColumn -gt 0) {
                    $cellText = Get-CellString $ws.Cells.Item($r, $SearchColumn).Value2
                    if (Matches-Text -Candidate $cellText -Target $MarkerText -Contains:$Contains -CaseSensitive:$CaseSensitive) {
                        $matchRow = $r
                        break
                    }
                } else {
                    for ($c = 1; $c -le $colCount; $c++) {
                        $cellText = Get-CellString $ws.Cells.Item($r, $c).Value2
                        if (Matches-Text -Candidate $cellText -Target $MarkerText -Contains:$Contains -CaseSensitive:$CaseSensitive) {
                            $matchRow = $r
                            break
                        }
                    }
                }
            }

            if ($matchRow -eq 0) {
                $notFound += $file.FullName
                $perFile.Add([PSCustomObject]@{
                    File       = $file.FullName
                    Status     = "Marker not found"
                    Value      = $null
                    MatchRow   = $null
                    ValueCol   = $ValueColumn
                })
                continue
            }

            if ($ValueColumn -gt $colCount) {
                $perFile.Add([PSCustomObject]@{
                    File       = $file.FullName
                    Status     = "Value column out of range (cols=$colCount)"
                    Value      = $null
                    MatchRow   = $matchRow
                    ValueCol   = $ValueColumn
                })
                continue
            }

            $rawVal = $ws.Cells.Item($matchRow, $ValueColumn).Value2
            $valStr = Get-CellString $rawVal
            # Clean and parse numeric (remove commas, trim)
            $valStrClean = ($valStr -replace ',', '').Trim()
            $parsed = $null
			$valStrCleanSecs = Convert-TimeToSeconds -InputValue $valStrClean
            $ok = [double]::TryParse($valStrCleanSecs , [ref]$parsed)

            if (-not $ok) {
                $nonNumeric += $file.FullName
                $perFile.Add([PSCustomObject]@{
                    File       = $file.FullName
                    Status     = "Non-numeric"
                    Value      = $valStr
                    MatchRow   = $matchRow
                    ValueCol   = $ValueColumn
                })
                continue
            }

            $values.Add([double]$parsed)
            $perFile.Add([PSCustomObject]@{
                File       = $file.FullName
                Status     = "OK"
                Value      = [double]$parsed
                MatchRow   = $matchRow
                ValueCol   = $ValueColumn
            })
        } catch {
            Write-Warning "Failed to process: $($file.FullName). Error: $($_.Exception.Message)"
            $perFile.Add([PSCustomObject]@{
                File       = $file.FullName
                Status     = "Error: $($_.Exception.Message)"
                Value      = $null
                MatchRow   = $null
                ValueCol   = $ValueColumn
            })
        } finally {
            if ($wb) { $wb.Close($false) | Out-Null }
        }
		$count++
    }
} finally {
    if ($excel) { $excel.Quit() | Out-Null }
    # Release COM to prevent orphaned Excel
    [System.GC]::Collect()
    [System.GC]::WaitForPendingFinalizers()
}

# Compute stats
if ($values.Count -gt 0) {
    $stats = $values | Measure-Object -Average -Maximum -Minimum
    $avg = [math]::Round($stats.Average, 4)
    $max = $stats.Maximum
    $min = $stats.Minimum

    Write-Host "`nResults (from $($values.Count) files with numeric values):" -ForegroundColor Cyan
    Write-Host ("Average: {0}" -f $avg)
    Write-Host ("Max    : {0}" -f $max)
    Write-Host ("Min    : {0}" -f $min)
} else {
    Write-Warning "No numeric values collected. Check marker text, column index, and data types."
}

# Show per-file summary
Write-Host "`nPer-file summary:" -ForegroundColor Yellow
$perFile | Sort-Object File | Format-Table -AutoSize

# Optional CSV output
if ($OutCsv) {
    try {
        $perFile | Export-Csv -Path $OutCsv -NoTypeInformation -Encoding UTF8
        Write-Host "CSV written to: $OutCsv" -ForegroundColor Green
    } catch {
        Write-Warning "Failed to write CSV: $($_.Exception.Message)"
    }
}

# Diagnostics
if ($notFound.Count -gt 0) {
    Write-Warning ("Marker not found in {0} files." -f $notFound.Count)
}
if ($nonNumeric.Count -gt 0) {
    Write-Warning ("Non-numeric values in {0} files." -f $nonNumeric.Count)
}
