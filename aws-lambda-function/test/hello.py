
def hello(event, context):
    message = 'Hello {}!'.format(event['name'])
    print(message)
    return {
        "message": message,
        "log_group_name": context.log_group_name,
        "log_stream_name": context.log_stream_name,
        "aws_request_id": context.aws_request_id
    }


if __name__ == '__main__':
    print(hello({'name': 'ryan'}, {}))
