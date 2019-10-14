import React, { useState } from "react";
import ReactDOM from "react-dom";
import dagre from "cytoscape-dagre";
import CytoscapeComponent from "react-cytoscapejs";
import Cytoscape from "cytoscape";
import Modal from "react-modal";
import EditNodeModal from "./GameEditor/EditNodeModal";

require("dagre");

Cytoscape.use(dagre);

class GameEditor extends React.Component {
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
    this.closeModal = this.closeModal.bind(this);
    this.save = this.save.bind(this);

    this.state.elements.forEach(element => {
      this.state.questions[element.data.id] = {
        content: element.data.content,
        answers: []
      };
    });
  }

  openModal(e) {
    e.preventDefault();
    this.setState({ modalIsOpen: true, editingNodeId: e.target.data("id") });
  }

  closeModal(e) {
    e.preventDefault();
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
    const [_empty, _game, id, _edit] = window.location.pathname.split("/");

    fetch(`/games/${id}`, {
      method: "PUT",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        ...this.state,
        ...this.props,
        cyOptions: this.myCyRef.json()
      })
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
      <button onClick={this.addNode}>Addnode</button>,
      <CytoscapeComponent
        elements={this.state.elements}
        className="game-editor"
        layout={this.props.touched ? null : { name: "dagre" }}
        cy={cy => (this.myCyRef = cy)}
        stylesheet={stylesheet}
        {...this.props.cyOptions}
      />,
      <pre>{JSON.stringify(this.state.elements, null, 2)}</pre>,
      <EditNodeModal
        isOpen={this.state.modalIsOpen}
        onRequestClose={this.closeModal}
        closeModal={this.closeModal}
        question={this.state.questions[this.state.editingNodeId]}
        onSave={this.onSaveModal}
      />
    ];
  }
}

document.addEventListener("DOMContentLoaded", () => {
  Modal.setAppElement("#editor");

  const editor = document.getElementById("editor");
  const elements = JSON.parse(editor.dataset.elements);
  const beginningId = editor.dataset.beginningId;
  const cyOptions = JSON.parse(editor.dataset.cyOptions);
  const touched = JSON.parse(editor.dataset.touched);

  ReactDOM.render(
    <GameEditor
      elements={elements}
      beginningId={beginningId}
      cyOptions={cyOptions}
      touched={touched}
    />,
    editor
  );
});
