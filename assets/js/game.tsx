import { Socket } from "phoenix";

import * as React from "react";
import * as ReactDOM from "react-dom";

const gameContainer = document.getElementById("game-container");

class Game extends React.Component<any, any> {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <p
        id="content"
        dangerouslySetInnerHTML={{
          __html: this.props.beginning.place.data.content
        }}
      />
    );
  }
}

if (gameContainer) {
  const token = gameContainer.dataset.token;
  const gameSessionName = gameContainer.dataset.gameSessionName;
  const socket = new Socket("/socket", { params: { token } });
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

  channel.on("beginning", beginning => {
    console.log(beginning);

    ReactDOM.render(
      <Game beginning={beginning} channel={channel} />,
      gameContainer
    );
  });
}
