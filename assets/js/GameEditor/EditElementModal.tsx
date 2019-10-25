import * as React from "react";
import TrixInput from "./TrixInput.jsx";
import Modal from "react-responsive-modal";

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
    return (
      <Modal open={this.props.isOpen} onClose={this.props.closeModal}>
        <h2>Question</h2>
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
