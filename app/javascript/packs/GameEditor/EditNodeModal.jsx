import React, { useState } from "react";
import Modal from "react-modal";

export default ({
  isOpen,
  onAfterOpen,
  onRequestClose,
  closeModal,
  question,
  onSave
}) => {
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

  const [state, setState] = useState(question || { content: "", answers: [] });

  const handleQuestionChange = e => {
    setState({ ...state, content: e.target.value });
  };

  const handleAnswerChange = id => e => {
    setState({
      ...state,
      answers: state.answers.map((answer, i) => {
        if (i === id) {
          return e.target.value;
        }
        return answer;
      })
    });
  };

  const addAnswer = e => {
    e.preventDefault();
    setState({ ...state, answers: [...state.answers, ""] });
  };

  return (
    <Modal
      isOpen={isOpen}
      onAfterOpen={onAfterOpen}
      onRequestClose={onRequestClose}
      style={customStyles}
      contentLabel="Example Modal"
    >
      <h2>Question</h2>
      <button onClick={closeModal}>x</button>
      <form>
        <textarea value={state.content} onChange={handleQuestionChange} />

        {state.answers.map((e, id) => (
          <textarea key={id} value={e} onChange={handleAnswerChange(id)} />
        ))}

        <button onClick={addAnswer}>Add answer</button>
      </form>
    </Modal>
  );
};
