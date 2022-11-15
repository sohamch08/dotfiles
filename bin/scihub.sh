url="$1"
doi=grep -Po '\w\K/\w+[^?]+' <<<$url
brave 'https://sci-hub.se${doi}'
