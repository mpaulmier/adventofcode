#!/usr/bin/env python3
import datetime
import logging

import urllib.request
urllib.request.HTTPHandler(debuglevel=1)

URL = 'https://adventofcode.com'
logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)


def download_one(year, day):
    logger.info(f'Downloading day {day} of year {year}... ')
    year_url = f'{URL}/{year}'
    day_url = f'{year_url}/day/{day}/input'
    input_file = open(f'{year}/inputs/day{day}.txt', 'w')
    urllib.request.urlretrieve(day_url, f'{year}/inputs/day{day}.txt')
    input_file.close()
    logger.info('done')


def download_all():
    today = datetime.date.today()
    max_year = today.year
    if today.month < 12:
        max_year -= 1
    opener = urllib.request.build_opener()
    with open('session-cookie.txt') as cookie_file:
        for line in cookie_file:
            opener.addheaders = [('Cookie', f'session={line.strip()}')]
    urllib.request.install_opener(opener)
    for year in range(2015, max_year + 1):
        max_day = 25
        if year == today.year:
            max_day = min(25, today.day)
        for day in range(1, max_day + 1):
            download_one(year, day)


if __name__ == '__main__':
    download_all()
