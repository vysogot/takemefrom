import { Socket } from "phoenix";

const gameContainer = document.getElementById("game-container");

if (gameContainer) {
  const token = gameContainer.dataset.token;
  const gameName = gameContainer.dataset.gameName;
  const socket = new Socket("/socket", { params: { token } });
  socket.connect();

  const channel = socket.channel(`games:${gameName}`);
  channel
    .join()
    .receive("ok", response => {
      console.log("Joined " + gameName);
    })
    .receive("error", response => {
      console.log(response);
    });
}
