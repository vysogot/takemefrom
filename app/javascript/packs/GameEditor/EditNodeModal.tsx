import * as React from "react";
import * as Modal from "react-modal";

interface EditNodeModalProps {
  content: string;
  onApplyContent?: any;
  closeModal?: any;
  isOpen?: boolean;
  onAfterOpen?: any;
  onRequestClose?: any;
}

interface EditNodeModalState {
  content: string;
}

export default class EditNodeModal extends React.Component<
  EditNodeModalProps,
  EditNodeModalState
> {
  constructor(props) {
    super(props);

    this.state = { content: props.content || "" };
  }

  handleQuestionChange = (e: React.ChangeEvent<HTMLTextAreaElement>) => {
    this.setState({
      content: e.target.value
    });
  };

  componentWillReceiveProps = (newProps: EditNodeModalProps) => {
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
