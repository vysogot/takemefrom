import React from "react";
import ReactDOM from "react-dom";
import dagre from "cytoscape-dagre";
import CytoscapeComponent from "react-cytoscapejs";
import Cytoscape from "cytoscape";
import Modal from "react-modal";

require("dagre");

Cytoscape.use(dagre);

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

class MyApp extends React.Component {
  constructor(props) {
    super(props);
    this.myCyRef = React.createRef();

    this.state = {
      modalIsOpen: false,
      elements: props.elements,
      questions: {},
      editingNodeId: props.elements[0].data.id
    };
    this.openModal = this.openModal.bind(this);
    this.afterOpenModal = this.afterOpenModal.bind(this);
    this.closeModal = this.closeModal.bind(this);
    this.save = this.save.bind(this);
    this.handleQuestionChange = this.handleQuestionChange.bind(this);
    this.handleAnswerChange = this.handleAnswerChange.bind(this);
    this.addAnswer = this.addAnswer.bind(this);
    this.addNode = this.addNode.bind(this);

    this.state.elements.forEach(element => {
      this.state.questions[element.data.id] = {
        content: element.data.content,
        answers: []
      };
    });
  }

  openModal(e) {
    this.setState({ modalIsOpen: true, editingNodeId: e.target.data("id") });
  }

  afterOpenModal() {
    // references are now sync'd and can be accessed.
    this.subtitle.style.color = "#f00";
  }

  closeModal() {
    this.setState({ modalIsOpen: false, editingNodeId: null });
  }

  addNode() {
    this.setState({
      elements: [
        ...this.state.elements,
        { data: { id: Math.floor(Math.random() * 100) } }
      ]
    });
  }

  componentDidMount() {
    this.myCyRef
      .style()
      .selector("node#" + this.props.beginningId)
      .style("background-color", "darkorange")
      .update();

    this.myCyRef.on("vclick", "node", this.openModal);
  }

  save() {
    fetch("update_react.json", {
      method: "PUT",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({ ...this.state, ...this.props })
    });
  }

  addAnswer(e) {
    e.preventDefault();
    const q = this.state.questions[this.state.editingNodeId];
    this.setState({
      questions: {
        ...this.state.questions,
        [this.state.editingNodeId]: {
          ...q,
          answers: [...q.answers, ""]
        }
      }
    });
  }

  handleQuestionChange(e) {
    this.setState({
      questions: {
        ...this.state.questions,
        [this.state.editingNodeId]: { content: e.target.value }
      }
    });
  }

  handleAnswerChange(id) {
    return event => {
      const question = this.state.questions[this.state.editingNodeId];
      question.answers[id] = event.target.value;
      this.setState({
        questions: {
          ...this.state.questions,
          [this.state.editingNodeId]: question
        }
      });
    };
  }

  render() {
    const stylesheet = [
      {
        selector: "node",
        style: {
          "text-opacity": 0.5,
          "text-valign": "center",
          "text-halign": "right",
          "background-color": "#11479e"
        }
      },
      {
        selector: "edge",
        style: {
          width: 4,
          "target-arrow-shape": "triangle",
          "line-color": "#9dbaea",
          "target-arrow-color": "#9dbaea",
          "curve-style": "bezier"
        }
      }
    ];

    return [
      <button onClick={this.save}>Save</button>,
      <button onClick={this.addNode}>Addnode</button>,
      <Modal
        isOpen={this.state.modalIsOpen}
        onAfterOpen={this.afterOpenModal}
        onRequestClose={this.closeModal}
        style={customStyles}
        contentLabel="Example Modal"
      >
        <h2 ref={subtitle => (this.subtitle = subtitle)}>Question</h2>
        <button onClick={this.closeModal}>x</button>
        <form>
          <textarea
            value={this.state.questions[this.state.editingNodeId].content}
            onChange={this.handleQuestionChange}
          />

          {this.state.questions[this.state.editingNodeId].answers.map(
            (e, id) => (
              <textarea
                key={id}
                value={e}
                onChange={this.handleAnswerChange(e.id)}
              />
            )
          )}

          <button onClick={this.addAnswer}>Add answer</button>
        </form>
      </Modal>,
      <CytoscapeComponent
        elements={this.state.elements}
        className="game-editor"
        layout={{ name: "dagre" }}
        cy={cy => (this.myCyRef = cy)}
        stylesheet={stylesheet}
      />,
      <pre>{JSON.stringify(this.state.elements, null, 2)}</pre>
    ];
  }
}

document.addEventListener("DOMContentLoaded", () => {
  Modal.setAppElement("#editor");

  const editor = document.getElementById("editor");
  const elements = JSON.parse(editor.dataset.elements);
  const beginningId = editor.dataset.beginningId;

  ReactDOM.render(
    <MyApp elements={elements} beginningId={beginningId} />,
    editor
  );
});
