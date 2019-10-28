import { Socket } from "phoenix";

import * as React from "react";
import * as ReactDOM from "react-dom";

const gameContainer = document.getElementById("game-container");

class Game extends React.Component<any, any> {
  constructor(props) {
    super(props);

    this.state = {
      place: props.place,
      choices: props.choices
    };
  }

  componentDidMount() {
    this.props.channel.on("choice-taken", ({ place, choices }) => {
      this.setState({ place, choices });
    });
  }

  takeChoice = (event, choice) => {
    event.preventDefault();
    this.props.channel.push("take-choice", { choice_id: choice.id, target_id: choice.target });
  };

  render() {
    return (
      <div>
        <p
          id="content"
          dangerouslySetInnerHTML={{
            __html: this.state.place.content
          }}
        />
        {this.state.choices.map(choice => {
          return (
            <p className="choice">
              <a
                onClick={e => this.takeChoice(e, choice)}
                dangerouslySetInnerHTML={{
                  __html: choice.content
                }}
              />
            </p>
          );
        })}
      </div>
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

  channel.on("beginning", ({ place, choices }) => {
    ReactDOM.render(
      <Game place={place} choices={choices} channel={channel} />,
      gameContainer
    );
  });
}
