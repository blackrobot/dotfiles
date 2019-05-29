#!/usr/bin/env python3

import datetime as dt
import time

import click


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
number_format = '0>2'  # Format as two digits with leading zero


def render(hours, mins, secs):
    if hours + mins == 0 and secs <= 30 and secs % 2 == 0:
        if secs <= 10:
            style = hl_style
        else:
            style = alt_style
    else:
        style = reg_style

    return render.template.format(hours, mins, secs, style=style)


render.template = (
    '  {i}  {{style}}'
    # Hour : Minute : Second
    '{{:{nf}}}' '{s}' '{{:{nf}}}' '{s}' '{{:{nf}}}'
    ' \t{reset}'
).format(i=icon, reset=RESET, nf=number_format, s=':')


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

    print()


def parse_time_text(text):
    parts = [int(x) for x in text.split(":")]
    hours, minutes, seconds = 0, 0, 0

    if len(parts) > 3:
        raise ValueError(f'The text "{text}" is not in the correct format.')
    elif len(parts) == 1:
        seconds = parts.pop()
    elif len(parts) == 2:
        minutes, seconds = parts
    else:
        hours, minutes, seconds = parts

    hours *= 60 * 60
    minutes *= 60

    return dt.timedelta(seconds=hours + minutes + seconds)


@click.command("countdown")
@click.argument("time", metavar="[hours:][minutes:]seconds")
def main(time: str):
    """Shows a timer counting down to the specified time."""
    delta = parse_time_text(time)
    print()
    countdown(dt.datetime.now() + delta)


if __name__ == '__main__':
    main()
