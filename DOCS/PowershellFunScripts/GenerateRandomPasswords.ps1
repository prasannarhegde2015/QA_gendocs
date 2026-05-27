$arrayprefix = @(
    'Incredible', 'Amazing', 'Fantastic', 'Wonderful', 'Marvelous', 'Interstellar', 'Spectacular', 'Phenomenal', 'Astounding', 'Breathtaking',
    'Radiant', 'Mighty', 'Electric', 'Vivid', 'Celestial', 'Epic', 'Brilliant', 'Thunder', 'Solar', 'Luminous',
    'Mystic', 'Majestic', 'Infinite', 'Dynamic', 'Vortex', 'Galactic', 'Serene', 'Sonic', 'Pristine', 'Quantum',
    'Imperial', 'Nimble', 'Velvet', 'Titan', 'Aurora', 'Noble', 'Pulsar', 'Legendary', 'Orbit', 'Nova',
    'Cosmic', 'Elite', 'Surreal', 'Stealth', 'Crystal', 'Wild', 'Swift', 'Guardian', 'Phoenix', 'Apex'
)
$arraysuffix = @(
    'Meadow', 'Voyager', 'Fighter', 'Explorer', 'Adventurer', 'Pioneer', 'Trailblazer', 'Champion', 'Conqueror', 'Hero',
    'Sentinel', 'Oracle', 'Nomad', 'Ranger', 'Navigator', 'Sailor', 'Seeker', 'Jubilee', 'Maverick', 'Pathfinder',
    'Crusader', 'Voyage', 'Falcon', 'Sparrow', 'Voyageur', 'Mercenary', 'Rider', 'Wizard', 'Gladiator', 'Warrior',
    'Protector', 'Trailmaster', 'Anchor', 'Harbinger', 'Scout', 'Architect', 'Voyant', 'Starlight', 'Emissary', 'Luminary',
    'Warden', 'Vanguard', 'Seafarer', 'Skylark', 'Arrow', 'Beacon', 'Everest', 'Eclipse', 'Horizon', 'Legacy'
)

for ($i = 1; $i -le 10; $i++) {
    $randomNumber = Get-Random -Minimum 1000 -Maximum 9999
    $prefix = Get-Random -InputObject $arrayprefix
    $suffix = Get-Random -InputObject $arraysuffix
    $password = "$prefix $suffix-$randomNumber"
    Write-Output "Generated Password: $password"
}