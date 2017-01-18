#!/usr/bin/env python3

import datetime as dt
import sys
import time


ESC = '\x1b[%sm'

WHITE_FG = '37'
YELLOW_FG = '33'
RED_FG = '31'

NOT_BOLD = '0'
BOLD = '1'

RESET = ESC % ''


reg_style = ESC % ';'.join((BOLD, WHITE_FG))
alt_style = ESC % ';'.join((BOLD, YELLOW_FG))
hl_style = ESC % ';'.join((BOLD, RED_FG))


icon = '⏳'
prefix = '  ' + icon + '  '


def render(hours, mins, secs):
    if hours + mins == 0 and secs <= 30 and secs % 2 == 0:
        if secs <= 10:
            style = hl_style
        else:
            style = alt_style
    else:
        style = reg_style

    return '{prefix}{style}{:0>2}{sep}{:0>2}{sep}{:0>2} \t{reset}'.format(
        hours,
        mins,
        secs,

        prefix=prefix,
        time=time,
        reset=RESET,
        style=style,
        sep=':',
    )


def get_time_tuple(time_remaining):
    secs = int(time_remaining.total_seconds())

    hours = int(secs / (60 * 60))
    if hours > 0:
        secs -= hours * 60 * 60

    mins = int(secs / 60)
    if mins > 0:
        secs -= mins * 60

    return hours, mins, secs


def countdown(then, tick=0.1):
    now = dt.datetime.now()

    while now <= then:
        hours, mins, secs = get_time_tuple(then - now)
        print(render(hours, mins, secs), end='\r')

        time.sleep(tick)
        now = dt.datetime.now()

    print('')


def help():
    print("{} [hours:][minutes:]seconds".format(sys.argv[0]))
    sys.exit(1)


if __name__ == '__main__':
    args = sys.argv[1:]

    if len(args) != 1:
        help()

    bits = [int(x) for x in args[0].split(':')]
    if len(bits) > 3:
        help()
    elif len(bits) == 1:
        delta = dt.timedelta(seconds=bits[0])
    elif len(bits) == 2:
        delta = dt.timedelta(seconds=(bits[0] * 60) + bits[1])
    else:
        delta = dt.timedelta(
            seconds=(bits[0] * 60 * 60) + (bits[1] * 60) + bits[2]
        )

    print("\n  Timer set for {:,} seconds from now".format(
        int(delta.total_seconds())),
    )
    print('')

    countdown(dt.datetime.now() + delta)
    print('')
