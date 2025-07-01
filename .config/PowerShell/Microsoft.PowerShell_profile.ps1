# Stop cursor blink.
echo "`e[?12l"

Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -PredictionSource None

$ENV:EDITOR = "nvim"
