rm docs/*.png
forfiles.exe /M *.scad /C "cmd /c openscad.exe -o docs/@fname.png  @file"
"# openscad preview " | Out-File README.md
forfiles.exe /S /M *.png /C "cmd /c echo ## ![@fname](@relpath) @fname" | Out-File README.md -Append
forfiles.exe /S /M *.gif /C "cmd /c echo ## ![@fname](@relpath) @fname" | Out-File README.md -Append

# replace \ with /
(Get-Content .\README.md) -Replace '\\', '/' | Set-Content .\README.md
(Get-Content .\README.md) -Replace '"', '' | Set-Content .\README.md


git add .
git cam "update docs"
git pu
