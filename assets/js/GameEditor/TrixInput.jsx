import React from "react";
import Trix from "trix";
import "trix/dist/trix.css";
import S3 from "./lib/S3.ts";

export default class TrixInput extends React.Component {
  constructor(props) {
    super(props);
    this.trixInput = React.createRef();
  }

  uploadAttachment = attachment => {
    const file = attachment.file;
    const fileName = file.name;
    const photoKey = fileName;

    const upload = S3.managedUpload({
      Key: photoKey,
      Body: file
    });

    upload.on("httpUploadProgress", event => {
      const progress = (event.loaded / event.total) * 100;
      return attachment.setUploadProgress(progress);
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
