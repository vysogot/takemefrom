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
      modalIsOpen: false
    };
    this.openModal = this.openModal.bind(this);
    this.afterOpenModal = this.afterOpenModal.bind(this);
    this.closeModal = this.closeModal.bind(this);
    this.save = this.save.bind(this);
  }

  openModal() {
    this.setState({ modalIsOpen: true });
  }

  afterOpenModal() {
    // references are now sync'd and can be accessed.
    this.subtitle.style.color = "#f00";
  }

  closeModal() {
    this.setState({ modalIsOpen: false });
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
          <textarea />

          {/* <button onClick={this.addQuestion()}> */}
        </form>
      </Modal>,
      <CytoscapeComponent
        elements={this.props.elements}
        className="game-editor"
        layout={{ name: "dagre" }}
        cy={cy => (this.myCyRef = cy)}
        stylesheet={stylesheet}
      />,
      <pre>{JSON.stringify(this.props.elements, null, 2)}</pre>
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
