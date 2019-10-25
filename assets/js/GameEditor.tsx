import * as React from "react";
import * as ReactDOM from "react-dom";
import dagre from "cytoscape-dagre";
import CytoscapeComponent from "react-cytoscapejs";
import Cytoscape from "cytoscape";
import Modal from "react-modal";
import EditElementModal from "./GameEditor/EditElementModal";
import popper from "cytoscape-popper";
import tippy from "tippy.js";
// import "tippy.js/dist/tippy.css";

declare function require(path: string): any; // move it somewhere else .d.ts I guess
require("dagre");

Cytoscape.use(dagre);
Cytoscape.use(popper);

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
  gameId: number;
}

interface GameEditorState {
  nextId: number;
  modalIsOpen: boolean;
  elements: any[];
  editingNode: any;
  connectionMode: boolean;
  connectingNodeId?: string;
  deletionMode?: boolean;
  isSaved: boolean;
  saveButtonLabel: string;
}

class GameEditor extends React.Component<GameEditorProps, GameEditorState> {
  cy: any;

  constructor(props) {
    super(props);
    this.cy = React.createRef();

    this.state = {
      nextId: props.maxElementCounter + 1,
      modalIsOpen: false,
      elements: props.elements,
      editingNode: props.elements[0],
      connectionMode: false,
      deletionMode: false,
      saveButtonLabel: "Saved",
      isSaved: true
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
    this.cy
      .style()
      .selector("node#" + nodeId)
      .style("background-color", color)
      .update();

    this.cy
      .style()
      .selector("node#" + this.props.beginningId)
      .style("background-color", Colors.orange)
      .update();
  };

  colorizeBeginning = () => {
    this.colorizeNode(this.props.beginningId, Colors.orange);
  };

  enableSaveButton = () => {
    this.setState({ isSaved: false, saveButtonLabel: "Save" });
  }

  componentDidUpdate() {
    this.colorizeBeginning();
  }

  componentDidMount() {
    this.colorizeBeginning();

    this.cy.on("data dragfree add remove viewport", this.enableSaveButton)

    this.cy.on(
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

    this.cy.ready(() => {
      this.cy.elements().forEach(ele => {
        this.makePopper(ele);
      });
    });

    this.cy.elements().unbind("mouseover");
    this.cy.elements().bind("mouseover", event => event.target.tippy.show());

    this.cy.elements().unbind("mouseout");
    this.cy.elements().bind("mouseout", event => event.target.tippy.hide());
  }

  makePopper = ele => {
    let ref = ele.popperRef(); // used only for positioning

    ele.tippy = tippy(ref, {
      // tippy options:
      content: () => {
        let content = document.createElement("div");

        content.innerHTML = ele.data("content");

        return content;
      },
      trigger: "manual" // probably want manual mode
    });
  };

  save = () => {
    const [_empty, _game, id, _edit] = window.location.pathname.split("/");

    fetch(`/api/games/${id}`, {
      method: "PUT",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        maxElementCounter: this.state.nextId,
        cy: this.cy.json()
      })
    })
    .then((response) => response.json())
    .then((json) => {
      if (json.id !== undefined) {
        this.setState({ isSaved: true, saveButtonLabel: "Saved" })
      }
    });
  };

  handleApplyContent = content => {
    // for some reason using enableSaveButton here doesn't work
    this.setState({
      isSaved: false,
      saveButtonLabel: "Save",
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

  modeClassName = mode => {
    return mode ? "modeOn" : ""
  }

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
      <div className="buttonContainer">
        <button onClick={this.save} disabled={this.state.isSaved}>{this.state.saveButtonLabel}</button>
        <button onClick={this.addNode}>Add</button>
        <button
          className={this.modeClassName(this.state.connectionMode)}
          onClick={this.toggleConnectionMode}
        >
          Connect
        </button>
        <button
          className={this.modeClassName(this.state.deletionMode)}
          onClick={this.toggleDeletionMode}
        >
          Delete
        </button>
        <a href={`/play/${this.props.gameId}`}>Play</a>
      </div>,
      <CytoscapeComponent
        elements={this.state.elements}
        className="game-editor"
        layout={this.props.touched ? null : { name: "dagre" }}
        cy={cy => (this.cy = cy)}
        stylesheet={stylesheet}
        {...this.props.cyOptions}
      />,
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
  const editor = document.getElementById("editor");

  if (editor) {
    Modal.setAppElement("#editor");

    const elements = JSON.parse(editor.dataset.elements);
    const beginningId = editor.dataset.beginningId;
    const cyOptions = JSON.parse(editor.dataset.cyOptions);
    const touched = JSON.parse(editor.dataset.touched);
    const maxElementCounter = JSON.parse(editor.dataset.maxElementCounter);
    const gameId = JSON.parse(editor.dataset.gameId);

    ReactDOM.render(
      <GameEditor
        elements={elements}
        beginningId={beginningId}
        cyOptions={{ ...cyOptions, maxZoom: 2, minZoom: 0.5 }}
        touched={touched}
        maxElementCounter={maxElementCounter}
        gameId={gameId}
      />,
      editor
    );
  }
});
