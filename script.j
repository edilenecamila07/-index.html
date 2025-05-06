// Model
class GameModel {
  constructor() {
    this.games = [
      { id: 1, name: "Jogo da Memória", plays: 0 },
      { id: 2, name: "Corrida Maluca", plays: 0 },
      { id: 3, name: "Puzzle Lógico", plays: 0 }
    ];
  }

  getGames() {
    return this.games;
  }

  playGame(id) {
    const game = this.games.find(g => g.id === id);
    if (game) {
      game.plays++;
    }
  }
}

// View
class GameView {
  constructor() {
    this.gameListElement = document.getElementById("gameList");
  }

  displayGames(games, onPlayCallback) {
    this.gameListElement.innerHTML = "";
    games.forEach(game => {
      const gameDiv = document.createElement("div");
      gameDiv.className = "game";

      const gameInfo = document.createElement("span");
      gameInfo.textContent = `${game.name} — Jogadas: ${game.plays}`;

      const playBtn = document.createElement("button");
      playBtn.textContent = "Jogar";
      playBtn.addEventListener("click", () => onPlayCallback(game.id));

      gameDiv.appendChild(gameInfo);
      gameDiv.appendChild(playBtn);
      this.gameListElement.appendChild(gameDiv);
    });
  }
}

// Presenter
class GamePresenter {
  constructor(model, view) {
    this.model = model;
    this.view = view;

    this.view.displayGames(this.model.getGames(), this.handlePlay.bind(this));
  }

  handlePlay(gameId) {
    this.model.playGame(gameId);
    this.view.displayGames(this.model.getGames(), this.handlePlay.bind(this));
  }
}

// Inicializa MVP
document.addEventListener("DOMContentLoaded", () => {
  const model = new GameModel();
  const view = new GameView();
  new GamePresenter(model, view);
});
