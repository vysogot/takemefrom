import * as React from "react";
import * as Modal from "react-modal";
import TrixInput from "./TrixInput.jsx";

interface EditElementModalProps {
  content: string;
  onApplyContent?: any;
  closeModal?: any;
  isOpen?: boolean;
  onAfterOpen?: any;
  onRequestClose?: any;
}

interface EditElementModalState {
  content: string;
}

export default class EditElementModal extends React.Component<
  EditElementModalProps,
  EditElementModalState
> {
  constructor(props) {
    super(props);

    this.state = { content: props.content || "" };
  }

  handleQuestionChange = (content: string) => {
    this.setState({ content });
  };

  componentWillReceiveProps = (newProps: EditElementModalProps) => {
    this.setState({
      content: newProps.content
    });
  };

  handleApplyContent = (e: React.MouseEvent<HTMLButtonElement>) => {
    e.preventDefault();

    this.props.onApplyContent(this.state.content);
    this.props.closeModal(e);
  };

  render() {
    const customStyles = {
      content: {
        // top: "50%",
        // left: "50%",
        // right: "auto",
        // bottom: "auto",
        // marginRight: "-50%",
        // transform: "translate(-50%, -50%)"
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
          <TrixInput
            value={this.state.content}
            onChange={this.handleQuestionChange}
          />

          <button onClick={this.handleApplyContent}>Apply content</button>
        </form>
      </Modal>
    );
  }
}
