$num_players = 1
while($true){
    write-host '`n`n$num_players'
    python.exe web_scrape_test_headless.py 1
    $num_players ++
}