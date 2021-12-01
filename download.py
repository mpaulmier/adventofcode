#!/usr/bin/env python3

import urllib.request


if __name__ == '__main__':
    for year in range(2020, 2021):
        for i in range(1, 26):
            opener = urllib.request.build_opener()
            with open('session-cookie.txt') as f:
                for line in f:
                    opener.addheaders = [('Cookie', line.strip())]
            urllib.request.install_opener(opener)
            open(str(year) + '/inputs/' + str(i), 'w')
            url = 'https://adventofcode.com/' + str(year) + '/day/' + str(i) + '/input'
            urllib.request.urlretrieve(url, str(year) + '/inputs/' + str(i))
