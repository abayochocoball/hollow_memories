###
# streamlink-auth.ps1
# 
# Script to access members only streams with streamlink and cookies file generated from cookies.txt browser plugin.
# Plugins: firefox(https://addons.mozilla.org/en-US/firefox/addon/cookies-txt/) chrome(https://chrome.google.com/webstore/detail/get-cookiestxt/bgaddhkoddajcdgocldbbfleckgcbcid)
#
# Usage: streamlink-auth PATH_TO_COOKIES_TXT STREAM_LINK_ARGUMENTS
# Example: streamlink-auth.ps1 C:\anon\cookies.txt https://www.youtube.com/watch?v=Rpl2x8c5ZoU best -r stream.mp4 --player mpv
###

# Help
if (("help", "/h", "/help", "--help", "-h") -contains $args[0])
{
    $help_string = 
    "Usage:    streamlink-auth.ps1 PATH_TO_COOKIES_TXT STREAM_LINK_ARGUMENTS`nExamples: streamlink-auth.ps1 C:\anon\cookies.txt https://www.youtube.com/watch?v=Rpl2x8c5ZoU best`nFor help with streamlink: https://streamlink.github.io/cli.html"
    Write-Host $help_string

    return
}

# Error checking
if ($args.Count -lt 2)
{
    throw "Error: Invalid number of parameters provided. See streamlink-auth.ps1 --help for usage info."
}

$cookiesFilePath = $args[0]

if (-Not $(Test-Path -Path $cookiesFilePath))
{
    throw "Error: Cannot find path '" + $cookiesFilePath + "' because it does not exist."
}

$userArgs = $args[1..$($args.Count - 1)] -join " "

Write-Host "cookies file path: " $cookiesFilePath
Write-Host "streamlink args: " $userArgs

# Cookie Extraction
$__Secure_3PSID =  (Select-String -Path $cookiesFilePath -Pattern "\.youtube\.com\s.*__Secure-3PSID\s").Line
if ($__Secure_3PSID -eq $null)
{
    throw "Error: Cannot find cookie with name: __Secure-3PSID for youtube.com. Try getting a new cookie.txt."
}

$__Secure_3PSID     = $__Secure_3PSID.Split("`t")[-1]

# streamlink command
$cookiesArgs = [string]::Format("--http-cookie __Secure-3PSID={0}", $__Secure_3PSID)
$expression = [string]::Format("streamlink {0} {1}", $cookiesArgs, $userArgs)

Invoke-Expression $expression