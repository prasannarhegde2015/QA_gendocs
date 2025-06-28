# Random Numbers cmdlet built in from Power Shell
function Roll-Dice {
    param([int]$Sides = 6, [int]$Rolls = 1)
    for ($i = 1; $i -le $Rolls; $i++) {
        $result = Get-Random -Minimum 1 -Maximum ($Sides + 1)
        Write-Host "Roll ${i}: 🎲 $result"
    }
}

Roll-Dice -Sides 20 -Rolls 20
----------------------------------------------------------------------------------------------------
#Beep on the Console
for ($i = 5; $i -ge 1; $i--) {
    Write-Host "$i..."
    [console]::Beep(1000, 300)
    Start-Sleep -Milliseconds 600
}
Write-Host "🎉 Boom!"
----------------------------------------------------------------------------------------------------

  
  for ($i = 1; $i -le 5; $i++) {
    Write-Host ('*' * $i)
}
  ----------------------------------------------------------------------------------------------------
  # Chat bot for Fun
   while ($true) {
    $input = Read-Host "Talk to me"
    if ($input -eq 'bye') { Write-Host "Goodbye! 🤖"; break }
    elseif ($input -match 'hi|hello') { Write-Host "Hey there!" }
	elseif ($input -match 'time|time now') { Write-Host ([datetime]::Now.ToString("d MMM yyyy dddd hh:mm:ss tt")) }
    else { Write-Host "I'm just a humble script. Supported Commands : 'hi' 'time now' exit with  'bye'." }
    
}
---------------------------------------------------------------------------------------------------------------------
#Scarble Anwser
$answers = @(
    "It is certain", "Ask again later", "Don't count on it",
    "Yes, definitely", "Very doubtful", "Signs point to yes"
)
$question = Read-Host "Ask the Magic 8-Ball a yes/no question"
$response = Get-Random -InputObject $answers
Write-Host "🔮 $response"
-----------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------

$facts = @{
    1 = "Bananas are berries, but strawberries aren't.";
    2 = "Octopuses have three hearts.";
    3 = "A day on Venus is longer than its year.";
    4 = "The Eiffel Tower can grow taller in the summer.";
    5 = "Honey never spoils—archaeologists found edible jars in tombs!"
}
$day = (Get-Date).Day % $facts.Count + 1
"📚 Fun fact: $($facts[$day])"
-------------------------------------------------------------------------------------------------------------------------------------

$chars = 'a'..'z' + 'A'..'Z' + 0..9 + '!@#$%&*'
$password = -join (1..12 | ForEach-Object { $chars | Get-Random })
"🔐 Your random password: $password"
