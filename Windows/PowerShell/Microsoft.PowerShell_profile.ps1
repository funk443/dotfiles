# Stop cursor blink.
Write-Host -NoNewline "`e[?12l"

Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -PredictionSource None

$ENV:EDITOR = "nvim"
