cd C:\github_code\NameGame\scripts
while($true){
    #Run test
    write-host "`n`nnum_players: random"
    python.exe web_scrape_test.py 0 --headless

    #cleanup orphaned chromes
    #get-process | where-object -Property processname -Like 'chrome*' | Stop-Process -Force -ErrorAction SilentlyContinue

    #clean up localappdata temp
    #Remove-Item -Force -Recurse -Path "C:\Users\antip\AppData\Local\Temp\scoped_dir*" -ErrorAction SilentlyContinue
}
