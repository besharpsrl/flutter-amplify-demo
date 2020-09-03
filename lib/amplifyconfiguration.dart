const amplifyconfig = ''' {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "analytics": {
        "plugins": {
            "awsPinpointAnalyticsPlugin": {
                "pinpointAnalytics": {
                    "appId": "e1b1662b191546f2b43efd6349e85628",
                    "region": "eu-west-1"
                },
                "pinpointTargeting": {
                    "region": "eu-west-1"
                }
            }
        }
    },
    "auth": {
        "plugins": {
            "awsCognitoAuthPlugin": {
                "UserAgent": "aws-amplify-cli/0.1.0",
                "Version": "0.1.0",
                "IdentityManager": {
                    "Default": {}
                },
                "CredentialsProvider": {
                    "CognitoIdentity": {
                        "Default": {
                            "PoolId": "eu-west-1:1cbb91c5-f34f-42b2-85f6-ab44fa21bc0e",
                            "Region": "eu-west-1"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "eu-west-1_iIeAJiu3g",
                        "AppClientId": "13ea3tjn8fiovpvuromb30v0t6",
                        "AppClientSecret": "1c1t5ai6vshaksj3rvn8oaafevj9o75qb1446ufth4vm5kfq468n",
                        "Region": "eu-west-1"
                    }
                },
                "Auth": {
                    "Default": {
                        "authenticationFlowType": "USER_SRP_AUTH"
                    }
                },
                "PinpointAnalytics": {
                    "Default": {
                        "AppId": "e1b1662b191546f2b43efd6349e85628",
                        "Region": "eu-west-1"
                    }
                },
                "PinpointTargeting": {
                    "Default": {
                        "Region": "eu-west-1"
                    }
                },
                "S3TransferUtility": {
                    "Default": {
                        "Bucket": "flutteramplifyapp624c6192eeae40fdb4448fa9495030183949-dev",
                        "Region": "eu-west-1"
                    }
                }
            }
        }
    },
    "storage": {
        "plugins": {
            "awsS3StoragePlugin": {
                "bucket": "flutteramplifyapp624c6192eeae40fdb4448fa9495030183949-dev",
                "region": "eu-west-1",
                "defaultAccessLevel": "guest"
            }
        }
    }
}''';