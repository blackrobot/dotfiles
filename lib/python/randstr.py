#!/usr/bin/env python3

from random import SystemRandom
import string
import sys


CHARS = string.ascii_letters + string.punctuation + string.digits
random = SystemRandom()


def generate(length, choices=CHARS):
    return (random.choice(choices) for _ in range(length))


def help():
    print("{} [-c <chars>] length")
    sys.exit(1)


if __name__ == '__main__':
    args = sys.argv[1:]
    arg_len = len(args)

    is_invalid = (
        arg_len < 1 or
        arg_len > 3 or
        not args[-1].isdigit() or
        (arg_len > 1 and not args[0].startswith('-c'))
    )

    if is_invalid:
        help()

    if arg_len > 2 :
        chars = args[1]
    elif arg_len > 1:
        chars = args[0].lstrip('-c=')
    else:
        chars = CHARS

    output = generate(int(args[-1]), choices=chars)
    print(''.join(output))
