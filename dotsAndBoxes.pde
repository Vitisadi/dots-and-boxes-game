int boardSize = 3;
Square[] squares;
boolean playersTurn = true;
int playersPoints = 0;
int computersPoints = 0;
boolean playerExtraTurn = false;
boolean computerExtraTurn = false;
boolean gameOver = false;
boolean playerWin;
int computerThinkingStart = -1;
Button load, save, reset;

void setup() {
  size(800, 600);
  String[] saveMe = new String[9];
  for (int i = 0; i < 9; i++) {
    saveMe[i] = "" + "Square " + i + ":" + "false,false,false,false,false,false,false,false,false,false";
  }
  saveStrings("savedFile.txt", saveMe);
  load = new Button("LOAD GAME", 0.25*width - 75, 550);
  save = new Button("SAVE GAME", 0.75*width + 75, 550);
  reset = new Button("RESET GAME", 0.5*width, 550);
  createSquares();
}

void draw() {
  drawBackground();
  drawSquares();
  drawGrid();
  gameOver();
  computerGameInteraction();
  load.display();
  save.display();
  reset.display();
}

void mousePressed() {
  playerGameInteraction();

  if (save.clicked()) {
    saveGame();
  }
  if (load.clicked()) {
    loadGame();
  }
  if (reset.clicked()) {
    resetGame();
  }
}

void playGame(){
  if(playersTurn){
    playerGameInteraction();
  }
  if(!playersTurn){
    computerGameInteraction();
  }
  squares = new Square [boardSize * boardSize];
  for (int x = 0; x < boardSize; x++) {
    for (int y = 0; y < boardSize; y++) {
      squares[(x + y) + (2 * x)] = new Square ((100 * x) + 250, (100 * y) + 150, false);
    }
  }
  for (int i = 0; i < squares.length; i++) {
    squares[i].display();
  }
  for (int i = 0; i < squares.length; i++) {
    squares[i].highlight();
  }
}

void createSquares() {
  squares = new Square [boardSize * boardSize];
  for (int x = 0; x < boardSize; x++) {
    for (int y = 0; y < boardSize; y++) {
      squares[(x + y) + (2 * x)] = new Square ((100 * x) + 250, (100 * y) + 150, false);
    }
  }
}

void drawGrid() {
  for (int x = 0; x < boardSize + 1; x++) {
    for (int y = 0; y < boardSize + 1; y++) {
      fill(255);
      ellipse((100 * x) + 250, (100 * y) + 150, 25, 25);
    }
  }
}

void drawSquares() {
  for (int i = 0; i < squares.length; i++) {
    squares[i].display();
  }
  for (int i = 0; i < squares.length; i++) {
    squares[i].highlight();
  }
}

void drawBackground() {
  background(255);
  textAlign(CENTER);
  textSize(25);
  fill(26, 216, 215);
  text("Players Points: " + playersPoints, 150, 100);
  fill(216, 36, 26);
  text("Computers Points: " + computersPoints, 650, 100);
  fill(0);
  text("Dots & Boxes", width/2, 50);
}

boolean playerGameInteraction() {
  if (!playersTurn) {
    return false;
  }

  boolean playerValidMoveMade = false;
  for (int i = 0; i < squares.length; i++) {
    if (squares[i].isValidMove(mouseX, mouseY)) {
      squares[i].setSelected(mouseX, mouseY, true); 
      if (squares[i].checkCompletion()) {
        squares[i].setCompletion(true);
        playersPoints++;
        playerExtraTurn = true;
      } 
      playerValidMoveMade = true;
    }
  }

  if (!playerValidMoveMade) {
    return false;
  }

  if (!playerExtraTurn) {
    playersTurn = false;
  } else {
    playerExtraTurn = false;
  }
  return true;
}

void computerGameInteraction() {
  if (!playersTurn) {
    if (computerThinkingStart == -1) {
      computerThinkingStart = millis() + 1000;
      return;
    } else if (computerThinkingStart > millis()) {
      return;
    }
    computerThinkingStart = -1;

    for (int i = 0; i < squares.length; i++) {
      if (!squares[i].sLeftPlayer && !squares[i].sLeftComp) {
        setComputerMove(i, "left");
        break;
      }
      if (!squares[i].sRightPlayer && !squares[i].sRightComp) {
        setComputerMove(i, "right");
        break;
      }
      if (!squares[i].sTopPlayer && !squares[i].sTopComp) {
        setComputerMove(i, "top");
        break;
      }
      if (!squares[i].sBotPlayer && !squares[i].sBotComp) {
        setComputerMove(i, "bot");
        break;
      }
    }
    for (int i = 0; i < squares.length; i++) {
      if (squares[i].checkCompletion()) {
        squares[i].setCompletion(false);
        computersPoints++; 
        computerExtraTurn = true;
      }
    }
    if (!computerExtraTurn) {
      playersTurn = true;
    } else {
      computerExtraTurn = false;
    }
  }
}

void setComputerMove(int initialSquare, String initialDirection) {
  switch(initialDirection) {
  case "left":
    squares[initialSquare].sLeftComp = true;
    if (initialSquare != 0 && initialSquare != 1 && initialSquare != 2) {
      squares[initialSquare - 3].sRightComp = true;
    }
    break;
  case "right":
    squares[initialSquare].sRightComp = true;
    if (initialSquare != 6 && initialSquare != 7 && initialSquare != 8) {
      squares[initialSquare + 3].sLeftComp = true;
    }
    break;
  case "top":
    squares[initialSquare].sTopComp = true;
    if (initialSquare != 0 && initialSquare != 3 && initialSquare != 6) {
      squares[initialSquare - 1].sBotComp = true;
    }
    break;
  case "bot":
    squares[initialSquare].sBotComp = true;
    if (initialSquare != 2 && initialSquare != 5 && initialSquare != 8) {
      squares[initialSquare + 1].sTopComp = true;
    }
    break;
  }
}

void gameOver() {
  if (computersPoints + playersPoints == 9) {
    textSize(30);
    fill(0);
    if (computersPoints > playersPoints) {
      playerWin = false;
      text("You Lose :(", width/2, 110);
    } else if (computersPoints < playersPoints) {
      playerWin = true;
      text("You Win :)", width/2, 110);
    }
  }
}

void saveGame() {
  String[] saveMe = new String[9];
  for (int i = 0; i < 9; i++) {
    saveMe[i] = "" + "Square " + i + ":" + squares[i].sLeftPlayer + "," + squares[i].sRightPlayer + "," + squares[i].sTopPlayer + "," + squares[i].sBotPlayer + "," 
      + squares[i].sLeftComp + "," + squares[i].sRightComp + "," + squares[i].sTopComp + "," + squares[i].sBotComp + ","
      + squares[i].squareClaimed + "," + squares[i].playersBox;
  }
  saveStrings("savedFile.txt", saveMe);
}

void loadGame() {
  resetGame();
  String[] loaded = new String[9];
  loaded = loadStrings("savedFile.txt");
  String[] firstSplitLoad = new String[2];
  String[] secondSplitLoad = new String[10];
  for (int i = 0; i < 9; i++) {
    firstSplitLoad = loaded[i].split(":", 2);
    secondSplitLoad = firstSplitLoad[1].split(",");

    squares[i].sLeftPlayer = parseBoolean(secondSplitLoad[0]);
    squares[i].sRightPlayer = parseBoolean(secondSplitLoad[1]);
    squares[i].sTopPlayer = parseBoolean(secondSplitLoad[2]);
    squares[i].sBotPlayer = parseBoolean(secondSplitLoad[3]);
    squares[i].sLeftComp = parseBoolean(secondSplitLoad[4]);
    squares[i].sRightComp = parseBoolean(secondSplitLoad[5]);
    squares[i].sTopComp = parseBoolean(secondSplitLoad[6]);
    squares[i].sBotComp = parseBoolean(secondSplitLoad[7]);
    squares[i].squareClaimed = parseBoolean(secondSplitLoad[8]);
    squares[i].playersBox = parseBoolean(secondSplitLoad[9]);

    if (squares[i].squareClaimed) {
      if (squares[i].playersBox) {
        playersPoints++;
      } else {
        computersPoints++;
      }
    }
  }
}

void resetGame() {
  playersPoints = 0;
  computersPoints = 0;
  for (int i = 0; i < 9; i++) {
    squares[i].sLeftPlayer = false;
    squares[i].sRightPlayer = false;
    squares[i].sTopPlayer = false;
    squares[i].sBotPlayer = false;
    squares[i].sLeftComp = false;
    squares[i].sRightComp = false;
    squares[i].sTopComp = false;
    squares[i].sBotComp = false;
    squares[i].squareClaimed = false;
    squares[i].playersBox = false;
  }
}
