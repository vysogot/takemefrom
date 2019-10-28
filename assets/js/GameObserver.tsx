import * as React from "react";
import * as ReactDOM from "react-dom";
import dagre from "cytoscape-dagre";
import CytoscapeComponent from "react-cytoscapejs";
import Cytoscape from "cytoscape";
import popper from "cytoscape-popper";
import tippy from "tippy.js";
import { Socket } from "phoenix";

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
  channel: any;
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
      layout: null
    };
  }

  colorizeNode = (nodeId, color) => {
    this.cy
      .style()
      .selector("node#" + nodeId)
      .style("background-color", color)
      .update();
  };

  componentDidMount() {
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

    this.props.channel.on("observe-choice", ({ place }) => {
      this.colorizeNode(place.id, Colors.blue);
    });
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
    return (
      <div>
        <CytoscapeComponent
          elements={this.state.elements}
          className="game-editor"
          layout={null}
          cy={cy => (this.cy = cy)}
          {...this.props.cyOptions}
        />
      </div>
    );
  }
}

document.addEventListener("DOMContentLoaded", () => {
  const observer = document.getElementById("game-observer");

  if (observer) {
    const elements = JSON.parse(observer.dataset.elements);
    const beginningId = observer.dataset.beginningId;
    const cyOptions = JSON.parse(observer.dataset.cyOptions);
    const gameSessionName = observer.dataset.gameSessionName;
    const token = observer.dataset.token;

    const socket = new Socket("/socket", { params: { token, observer: true } });
    socket.connect();
    const channel = socket.channel(`games:${gameSessionName}`);
    channel
      .join()
      .receive("ok", response => {
        console.log("Joined " + gameSessionName);
      })
      .receive("error", response => {
        console.log(response);
      });

    ReactDOM.render(
      <GameObserver
        elements={elements}
        beginningId={beginningId}
        cyOptions={{ ...cyOptions, maxZoom: 2, minZoom: 0.5 }}
        channel={channel}
      />,
      observer
    );
  }
});
