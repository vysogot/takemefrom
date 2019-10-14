import React from "react";
import ReactDOM from "react-dom";
import dagre from "cytoscape-dagre";
import CytoscapeComponent from "react-cytoscapejs";
import Cytoscape from "cytoscape";

Cytoscape.use(dagre);

class MyApp extends React.Component {
  constructor(props) {
    super(props);
    this.myCyRef = React.createRef();
  }

  componentDidMount() {
    this.myCyRef
      .style()
      .selector("node#" + this.props.beginningId)
      .style("background-color", "darkorange")
      .update();
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
          "target-arrow-color": "#9dbaea"
        }
      }
    ];

    return [
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
  const editor = document.getElementById("editor");
  const elements = JSON.parse(editor.dataset.elements);
  const beginningId = editor.dataset.beginningId;

  ReactDOM.render(
    <MyApp elements={elements} beginningId={beginningId} />,
    editor
  );
});
