import React, { useState } from "react";
import Modal from "react-modal";

export default class EditNodeModal extends React.Component {
  constructor(props) {
    super(props);

    this.state = { content: props.content || "" };
    this.handleQuestionChange = this.handleQuestionChange.bind(this);
    this.handleApplyContent = this.handleApplyContent.bind(this);
  }

  handleQuestionChange(e) {
    this.setState({
      content: e.target.value
    });
  }

  componentWillReceiveProps(newProps) {
    this.setState({ content: newProps.content });
  }

  handleApplyContent(e) {
    e.preventDefault();

    this.props.onApplyContent(this.state.content);
    this.props.closeModal(e);
  }

  render() {
    const customStyles = {
      content: {
        top: "50%",
        left: "50%",
        right: "auto",
        bottom: "auto",
        marginRight: "-50%",
        transform: "translate(-50%, -50%)"
      }
    };
    return (
      <Modal
        isOpen={this.props.isOpen}
        onAfterOpen={this.props.onAfterOpen}
        onRequestClose={this.props.onRequestClose}
        style={customStyles}
        contentLabel="Example Modal"
      >
        <h2>Question</h2>
        <button onClick={this.props.closeModal}>x</button>
        <form>
          <textarea
            value={this.state.content}
            onChange={this.handleQuestionChange}
          />

          <button onClick={this.handleApplyContent}>Apply content</button>
        </form>
      </Modal>
    );
  }
}
