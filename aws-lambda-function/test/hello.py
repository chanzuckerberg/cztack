def hello(event, context):
    print("event %s" % event)
    print("context %s" % context)
    message = 'Hello {}!'.format(event['name'])
    return message


if __name__ == '__main__':
    print(hello({'name': 'ryan'}, {}))
