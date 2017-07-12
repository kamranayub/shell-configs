$WeatherApiKey = $null
$ContribDir = "C:\Development\Contrib"
$JunkDir = "C:\Development\Junk"

# REQUIRED: Install globally via Install-Module posh-git
Import-Module posh-git

# REQUIRED: Install globally via Install-Module OpenWeatherMap
Import-Module OpenWeatherMap

Function Write-LocalWeatherCurrent([switch]$Inline) {
    # Replace city and API key
    Write-WeatherCurrent -City Minneapolis -ApiKey $WeatherApiKey -Inline:$Inline
}

Function Write-LocalWeatherForecast($Days = 1) {
    # Replace city and API key
    Write-WeatherForecast -City Minneapolis -ApiKey $WeatherApiKey -Days $Days
}

Write-Host "Weather: " -NoNewline -ForegroundColor Yellow
Write-LocalWeatherCurrent

# Type `weather` in the prompt to see current weather
Set-Alias weather Write-LocalWeatherCurrent
# Type `forecast` or `forecast -d 2` to get the current forecast
Set-Alias forecast Write-LocalWeatherForecast

# Customize prompt
function Prompt() {
    # Print working dir
    Write-Host ($PWD) -NoNewline -foregroundcolor Red
    # Write inline weather
    Write-LocalWeatherCurrent -Inline
    Write-VcsStatus #Disable VCS for perf right now
    Write-Host ""
    Write-Host "›" -NoNewline -ForegroundColor Gray    

    return " "
}

function Contrib() {
    cd $ContribDir
}

function Junk() {
    cd $JunkDir
}

# Aliases
Set-Alias which Get-Command
Set-Alias gcr Get-Credential
Set-Alias of Out-File