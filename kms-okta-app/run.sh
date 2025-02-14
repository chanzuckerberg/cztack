#!/bin/sh

# need to install python-jose instead of jose: https://stackoverflow.com/a/65103147
pip install boto3 cryptography python-jose  2>&1  > /dev/null
python3 $1/get_jwks_for_okta.py $2 $3 $4 $5