
def hello(event, context):
    message = 'Hello {}!'.format(event['name'])
    print(message)
    return {
        "message": message,
    }


if __name__ == '__main__':
    print(hello({'name': 'Lambda'}, {}))
