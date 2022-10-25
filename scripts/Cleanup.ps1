#cleanup orphaned chromes
get-process | where-object -Property processname -Like 'chrome*' | Stop-Process -Force -ErrorAction SilentlyContinue

#clean up localappdata temp
Remove-Item -Force -Recurse -Path "C:\Users\antip\AppData\Local\Temp\scoped_dir*" -ErrorAction SilentlyContinue