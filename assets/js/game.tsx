import { Socket } from "phoenix";

const gameContainer = document.getElementById("game-container");

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
  });
}
