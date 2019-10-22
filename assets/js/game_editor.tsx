import * as React from "react";
import * as ReactDOM from "react-dom";
import dagre from "cytoscape-dagre";
import CytoscapeComponent from "react-cytoscapejs";
import Cytoscape from "cytoscape";
import Modal from "react-modal";
import EditElementModal from "./GameEditor/EditElementModal";

require("phoenix_html")
require("../css/app.css")

declare function require(path: string): any; // move it somewhere else .d.ts I guess
require("dagre");

Cytoscape.use(dagre);

const Colors = {
  skyblue: "#9dbaea",
  blue: "#11479e",
  red: "#ff5e5b",
  orange: "darkorange"
};

interface GameEditorProps {
  elements: any[];
  beginningId: string;
  cyOptions: any;
  touched: boolean;
  maxElementCounter: number;
}

interface GameEditorState {
  nextId: number;
  modalIsOpen: boolean;
  elements: any[];
  editingNode: any;
  connectionMode: boolean;
  connectingNodeId?: string;
  deletionMode?: boolean;
}

class GameEditor extends React.Component<GameEditorProps, GameEditorState> {
  myCyRef: any;

  constructor(props) {
    super(props);
    this.myCyRef = React.createRef();

    this.state = {
      nextId: props.maxElementCounter + 1,
      modalIsOpen: false,
      elements: props.elements,
      editingNode: props.elements[0],
      connectionMode: false,
      deletionMode: false
    };
  }

  openModal = e => {
    e.preventDefault();
    this.setState({
      modalIsOpen: true,
      editingNode: this.state.elements.find(
        elem => elem.data.id === e.target.data("id")
      )
    });
  };

  closeModal = e => {
    e.preventDefault();
    this.setState({ modalIsOpen: false });
  };

  deleteElement = e => {
    e.preventDefault();
    this.setState({
      elements: this.state.elements.filter(function(element) {
        return (
          element.data.id !== e.target.data("id") &&
          element.data.source !== e.target.data("id") &&
          element.data.target !== e.target.data("id")
        );
      })
    });
  };

  addNode = () => {
    this.setState({
      nextId: this.state.nextId + 1,
      elements: [
        ...this.state.elements,
        { data: { id: `node#${this.state.nextId}` } }
      ],
      connectionMode: false,
      deletionMode: false
    });
  };

  addEdge = targetId => {
    this.setState({
      nextId: this.state.nextId + 1,
      elements: [
        ...this.state.elements,
        {
          data: {
            id: `edge#${this.state.nextId}`,
            source: this.state.connectingNodeId,
            target: targetId,
            content: "Edit me"
          }
        }
      ]
    });

    this.setState({ connectingNodeId: null });
  };

  toggleConnectionMode = e => {
    this.setState({
      connectionMode: !this.state.connectionMode,
      connectingNodeId: null,
      deletionMode: false
    });
  };

  toggleDeletionMode = e => {
    this.setState({
      deletionMode: !this.state.deletionMode,
      connectionMode: false
    });
  };

  colorizeNode = (nodeId, color) => {
    this.myCyRef
      .style()
      .selector("node#" + nodeId)
      .style("background-color", color)
      .update();

    this.myCyRef
      .style()
      .selector("node#" + this.props.beginningId)
      .style("background-color", Colors.orange)
      .update();
  };

  colorizeBeginning = () => {
    this.colorizeNode(this.props.beginningId, Colors.orange);
  };

  componentDidUpdate() {
    this.colorizeBeginning();
  }

  componentDidMount() {
    this.colorizeBeginning();

    this.myCyRef.on(
      "vclick",
      "node, edge",
      (e => {
        if (this.state.connectionMode && e.target.isNode()) {
          if (this.state.connectingNodeId) {
            this.addEdge(e.target.data("id"));
            this.colorizeNode(e.target.data("id"), Colors.blue);
          } else {
            this.setState({ connectingNodeId: e.target.data("id") });
            this.colorizeNode(e.target.data("id"), Colors.red);
          }
        } else if (this.state.deletionMode) {
          this.deleteElement(e);
        } else {
          this.openModal(e);
        }
      }).bind(this)
    );
  }

  save = () => {
    const [_empty, _game, id, _edit] = window.location.pathname.split("/");

    fetch(`/api/games/${id}`, {
      method: "PUT",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        maxElementCounter: this.state.nextId,
        cy: this.myCyRef.json()
      })
    });
  };

  handleApplyContent = content => {
    this.setState({
      elements: this.state.elements.map(e => {
        if (e.data.id == this.state.editingNode.data.id) {
          const editedNode = { ...this.state.editingNode };
          editedNode.data.content = content;
          return editedNode;
        } else {
          return e;
        }
      })
    });
  };

  render() {
    const stylesheet = [
      {
        selector: "node",
        style: {
          "text-opacity": 0.5,
          "text-valign": "center",
          "text-halign": "right",
          "background-color": Colors.blue
        }
      },
      {
        selector: "edge",
        style: {
          width: 4,
          "target-arrow-shape": "triangle",
          "line-color": Colors.skyblue,
          "target-arrow-color": Colors.skyblue,
          "curve-style": "bezier"
        }
      }
    ];

    return [
      <button onClick={this.save}>Save</button>,
      <button onClick={this.addNode}>Addnode</button>,
      <button onClick={this.toggleConnectionMode}>Connection mode</button>,
      <button onClick={this.toggleDeletionMode}>Delete mode</button>,
      <CytoscapeComponent
        elements={this.state.elements}
        className="game-editor"
        layout={this.props.touched ? null : { name: "dagre" }}
        cy={cy => (this.myCyRef = cy)}
        stylesheet={stylesheet}
        {...this.props.cyOptions}
      />,
      <pre>Connection mode: {this.state.connectionMode.toString()}</pre>,
      <pre>Deletion mode: {this.state.deletionMode.toString()}</pre>,
      <pre>{JSON.stringify(this.state.elements, null, 2)}</pre>,
      <EditElementModal
        isOpen={this.state.modalIsOpen}
        onRequestClose={this.closeModal}
        content={this.state.editingNode.data.content}
        closeModal={this.closeModal}
        onApplyContent={this.handleApplyContent}
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
  const maxElementCounter = JSON.parse(editor.dataset.maxElementCounter);

  ReactDOM.render(
    <GameEditor
      elements={elements}
      beginningId={beginningId}
      cyOptions={{ ...cyOptions, maxZoom: 2, minZoom: 0.5 }}
      touched={touched}
      maxElementCounter={maxElementCounter}
    />,
    editor
  );
});
