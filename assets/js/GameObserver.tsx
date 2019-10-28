import * as React from "react";
import * as ReactDOM from "react-dom";
import dagre from "cytoscape-dagre";
import CytoscapeComponent from "react-cytoscapejs";
import Cytoscape from "cytoscape";
import popper from "cytoscape-popper";
import tippy from "tippy.js";

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

interface GameObserverProps {
  elements: any[];
  beginningId: string;
  cyOptions: any;
}

interface GameObserverState {
  elements: any[];
  layout?: any;
}

class GameObserver extends React.Component<
  GameObserverProps,
  GameObserverState
> {
  cy: any;

  constructor(props) {
    super(props);
    this.cy = React.createRef();

    this.state = {
      elements: props.elements,
      mode: null,
      layout: null
    };
  }

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

  componentDidUpdate() {
    this.colorizeBeginning();
  }

  componentDidMount() {
    this.colorizeBeginning();

    this.cy.ready(() => {
      this.cy.elements().forEach(ele => {
        this.makePopper(ele);
      });
    });

    this.cy.elements().unbind("mouseover");
    this.cy.elements().bind("mouseover", event => event.target.tippy.show());

    this.cy.elements().unbind("mouseout");
    this.cy.elements().bind("mouseout", event => event.target.tippy.hide());

    this.cy.center();
  }

  makePopper = ele => {
    let ref = ele.popperRef();
    ele.tippy = tippy(ref, {
      content: () => {
        let content = document.createElement("div");
        content.innerHTML = ele.data("content");
        return content;
      },
      trigger: "manual"
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

    return (
      <div>
        <CytoscapeComponent
          elements={this.state.elements}
          className="game-editor"
          layout={null}
          cy={cy => (this.cy = cy)}
          stylesheet={stylesheet}
          {...this.props.cyOptions}
        />
      </div>
    );
  }
}

document.addEventListener("DOMContentLoaded", () => {
  const editor = document.getElementById("game-observer");

  if (editor) {
    const elements = JSON.parse(editor.dataset.elements);
    const beginningId = editor.dataset.beginningId;
    const cyOptions = JSON.parse(editor.dataset.cyOptions);

    ReactDOM.render(
      <GameObserver
        elements={elements}
        beginningId={beginningId}
        cyOptions={{ ...cyOptions, maxZoom: 2, minZoom: 0.5 }}
      />,
      editor
    );
  }
});
