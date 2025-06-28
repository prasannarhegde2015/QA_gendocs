$target = Get-Random -Minimum 1 -Maximum 100
$attempt = 0
$exitgame = $false
$playmode = $false
$holidaydestianmtions = @("Hongkong", "Singapore", "Thailand", "Australia", "NewZaeland", "Switzerland", "Bhutan", "Japan")
do {
  
    if ( $playmode -eq $false) {
        try {
            $guess = [int](Read-Host "Guess a number between 1 and 100..
     If you guess within 8 Atttempts you Win a change for Holiday ✈️✈️
     To Quit Game Press 0") 
        }
        catch {
            $guess = 0
            Write-Host "❌ That's not a number.Please Enter  a Number "
            $exitgame = $true
        }
    }
    else {
        $guess = [int](Read-Host "Enter Number: Attempt# $attempt")
    }

    if ($guess -eq 0) { 
        $exitgame = $true
        break
    }
    if ($guess -as [int]) {
        if ( $guess -gt 0 -and $guess -lt 101) {
            $playmode = $true
            $attempt++
            Write-Host "✅ Valid Input That's a number!"
        }
        else {
            Write-Host "🛑 Number no accepted as not in range!"
        }
    }
    else {
        Write-Host "❌ That's not a number.Please Enter  a Number "
        continue
    }

    if ($guess -lt $target) { "Too low! 👇" }
    elseif ($guess -gt $target) { "Too high 👆!" }
 
} until ($guess -eq $target)
if ($exitgame -eq $false) {
    Write-Host "🎉 You got it! The number was $target."
    if ($attempt -lt 8) {
        $dest = Get-Random -InputObject $holidaydestianmtions
        Write-Host "Congratulations 🎉🎉🎉 [Number of attempts taken:  $attempt] You have Won the Game You win a Holiday Pacakge of 3 day and 4 nights in . $dest"
    }
    else {
        Write-Host "Good Attempt : Number of attempts taken $attempt You can come back and play Next Time 🤞🤞 "
    }
}
else {
    Write-Host "Exited out of game due to Quit command or Invlaid Input"
}
