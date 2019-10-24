import * as AWS from "aws-sdk";

const S3 = {
  managedUpload: (options: any = {}) => {
    const albumBucketName = "takemefrom-dev";
    const bucketRegion = "eu-central-1";
    const identityPoolId = "eu-central-1:62d5c74d-2ab4-4224-81a0-7d6dc7a42dc8";
  
    AWS.config.update({
      region: bucketRegion,
      credentials: new AWS.CognitoIdentityCredentials({
        IdentityPoolId: identityPoolId
      })
    });

    return new AWS.S3.ManagedUpload({
      params: {
        Bucket: albumBucketName,
        ACL: "public-read",
        ...options
      }
    });
  }
}

export default S3;