import boto3, json
from cryptography.hazmat.primitives.serialization import load_der_public_key
from jose import jwk, constants
import sys

aws_account_id = sys.argv[1]
kms_key_id = sys.argv[2]
region = sys.argv[3]

sts_client = boto3.client("sts", region_name=region)
assume_role_client = sts_client.assume_role(RoleArn=f"arn:aws:iam::{aws_account_id}:role/tfe-si", RoleSessionName='FetchKMSInformation')
credentials = assume_role_client["Credentials"]
kms_session = boto3.Session(
    aws_access_key_id=credentials["AccessKeyId"],
    aws_secret_access_key= credentials["SecretAccessKey"],
    aws_session_token= credentials["SessionToken"],
    region_name=region,
)
kms_client = kms_session.client("kms", region_name=region)

# try to get the public key in bytes
output = kms_client.get_public_key(
    KeyId=kms_key_id,
)
assert output.get("PublicKey") is not None
public_key = load_der_public_key(output["PublicKey"])
jwks_vals = jwk.RSAKey(algorithm=constants.Algorithms.RS256, key=public_key).to_dict()
print(json.dumps(jwks_vals))
