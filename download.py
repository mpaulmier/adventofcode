#!/usr/bin/env python3
import datetime

import urllib.request
urllib.request.HTTPHandler(debuglevel=1)


if __name__ == '__main__':
    today = datetime.date.today
    max_year = today.year
    for year in range(2015, max_year):
        for i in range(1, 26):
            opener = urllib.request.build_opener()
            with open('session-cookie.txt') as f:
                for line in f:
                    opener.addheaders = [('Cookie', line.strip())]
            urllib.request.install_opener(opener)
            open(f'{year}/inputs/{i}', 'w')
            url = 'https://adventofcode.com/'
            urllib.request.urlretrieve(url, f'{year}/inputs/{i}')
