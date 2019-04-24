#!/usr/bin/env python3

"""
datetool - help calculating dates

    until [[YYYY-]MM-DD]                     return a list of dates from now until then
    between [[YYYY-]MM-DD] [[YYYY-]MM-DD]    return a list of dates from now until then

    --biz  | -b                              only count business days
    --help | -h                              show this help text
"""

import datetime as dt
import itertools
import sys
from typing import List, Iterator


DateIterator = Iterator[dt.date]


def walk_days(start_date: dt.date) -> DateIterator:
    """ An iterator that keeps yielding the next day. """
    cur = start_date
    while True:
        yield cur
        cur += dt.timedelta(days=1)


def is_business_day(day: dt.date) -> bool:
    return day.weekday() < 5


def walk_business_days(start_date: dt.date) -> DateIterator:
    yield from filter(is_business_day, walk_days(start_date))


def business_days_until(end_date: dt.date, start_date: dt.date = None) -> DateIterator:
    if start_date is None:
        start_date = dt.date.today()

    if end_date < start_date:
        raise ValueError("end_date must be less than start_date")

    for day in walk_business_days(start_date):
        yield day

        if day >= end_date:
            break


def business_days_from(start_date: dt.date, count: int) -> DateIterator:
    for count, day in enumerate(walk_business_days(start_date)):
        yield day

        if count >= count:
            break


def business_days_between(start_date: dt.date, end_date: dt.date) -> DateIterator:  # noqa
    yield from business_days_until(end_date, start_date=start_date)


def parse_date(text):
    day_parts = [x for x in map(int, text.split("-"))]
    if len(day_parts) < 3:
        day_parts = [dt.date.today().year, *day_parts]
    return dt.date(*day_parts)


def show_results(results, date_fmt="%F | %A"):
    today = dt.date.today()

    if not date_fmt:
        date_fmt = "%F"

    for result in results:
        text = result.strftime(date_fmt)
        if result == today:
            text = f"\x1b[1m{text}\x1b[0m"
        print(text)


if __name__ == "__main__":
    args = sys.argv[1:]

    if args:
        command = args[0].lower()
    else:
        command = ""

    if len(args) > 3:
        command = ""

    if command == "until":
        day = parse_date(args[1])
        show_results(business_days_until(day))

    elif command == "between":
        start_day = parse_date(args[1])
        end_day = parse_date(args[2])
        show_results(business_days_between(start_day, end_day))

    elif any(x.lower() in ("-h", "--help") for x in args):
        print(__doc__)

    else:
        print(__doc__)
        sys.exit(1)

    sys.exit()
