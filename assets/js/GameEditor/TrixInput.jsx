import React from "react";
import Trix from "trix";
import "trix/dist/trix.css";
import AWS from "aws-sdk";

export default class TrixInput extends React.Component {
  constructor(props) {
    super(props);
    this.trixInput = React.createRef();
  }

  uploadAttachment = attachment => {
    const albumBucketName = "takemefrom-dev";
    const bucketRegion = "eu-central-1";
    const IdentityPoolId = "eu-central-1:62d5c74d-2ab4-4224-81a0-7d6dc7a42dc8";

    AWS.config.update({
      region: bucketRegion,
      credentials: new AWS.CognitoIdentityCredentials({
        IdentityPoolId: IdentityPoolId
      })
    });

    const s3 = new AWS.S3({
      apiVersion: "2006-03-01",
      params: { Bucket: albumBucketName }
    });

    const albumName = "content";
    const file = attachment.file;
    const fileName = file.name;
    const albumPhotosKey = encodeURIComponent(albumName) + "//";

    const photoKey = fileName;

    const upload = new AWS.S3.ManagedUpload({
      params: {
        Bucket: albumBucketName,
        Key: photoKey,
        Body: file,
        ACL: "public-read"
      }
    });

    const promise = upload.promise();

    promise.then(
      function(data) {
        attachment.setAttributes({
          url: data.Location,
          href: data.Location
        });
      },
      function(err) {
        console.log("There was an error uploading your photo: ", err.message);
      }
    );
  };

  componentDidMount() {
    Trix.config.attachments.preview.caption = {
      name: false,
      size: false
    };

    this.trixInput.current.addEventListener("trix-change", event => {
      this.props.onChange(event.target.innerHTML);
    });

    this.trixInput.current.addEventListener("trix-attachment-add", event => {
      const attachment = event.attachment;
      if (attachment.file) {
        return this.uploadAttachment(attachment);
      }
    });
  }

  render() {
    return (
      <div>
        <input type="hidden" id="trix" value={this.props.value} />
        <trix-editor ref={this.trixInput} input="trix" />
      </div>
    );
  }
}
