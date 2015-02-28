# -*- coding: utf-8 -*-

from datetime import datetime
import json
import sys

from anydo.api import AnyDoAPI, AnyDoAPIError
from requests import ConnectionError


def convert_epoch_timestamp(ts, milliseconds=True):
    """
    Returning datetime object.
    Division by 1000 is necessary because the filename contains timestamp in
    milliseconds, but python expects timestamp in seconds.
    Keeping the option to send as seconds just as a precausion.
    """
    if milliseconds:
        return datetime.fromtimestamp(float(ts)/1000.0)
    else:
        return datetime.fromtimestamp(float(ts))


def run(username, password):
    if username is None or password is None:
        return 'Empty username or password'

    try:
        api = AnyDoAPI(username=username, password=password)
    except ConnectionError:
        return 'Check internet connection'

    try:
        tasks = api.get_all_tasks()
    except AnyDoAPIError:
        return 'AnyDo API error.<br>Check username and password'

    for task in tasks:
        try:
            task['dueDate'] = convert_epoch_timestamp(task['dueDate'])\
                .strftime('%c')
        except KeyError:
            pass
        try:
            if task['alert']['type'] == 'OFFSET':
                task['alert']['repeatStartsOn'] = convert_epoch_timestamp(
                    task['alert']['repeatStartsOn']).strftime('%c')
        except KeyError:
            pass

    return json.dumps(tasks)

if __name__ == '__main__':
    try:
        username = sys.argv[1]
        password = sys.argv[2]
    except IndexError:
        username = None
        password = None

    print run(username, password)
