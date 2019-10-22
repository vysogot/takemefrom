import React from "react";
import Trix from "trix";
import "trix/dist/trix.css";

export default class TrixInput extends React.Component {
  constructor(props) {
    super(props);
    this.trixInput = React.createRef();
  }

  componentDidMount() {
    this.trixInput.current.addEventListener("trix-change", event => {
      console.log("trix change event fired");
      this.props.onChange(event.target.innerHTML);
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
