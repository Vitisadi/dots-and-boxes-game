class Square{
  int x, y, w, h;
  boolean squareClaimed, playersBox;
  boolean sLeftPlayer, sRightPlayer, sTopPlayer, sBotPlayer;
  boolean sLeftComp, sRightComp, sTopComp, sBotComp;
  int selectionMargin = 10;
  Square(int x, int y, boolean squareClaimed){
    this.x = x;
    this.y = y;
    w = 100;
    h = 100;
    this.squareClaimed = squareClaimed;
    playersBox = false;
    sLeftPlayer = false;
    sRightPlayer = false;
    sTopPlayer = false;
    sBotPlayer = false;
    sLeftComp = false;
    sRightComp = false;
    sTopComp = false;
    sBotComp = false;
  }
  
  boolean isValidMove(int mouseLocationX, int mouseLocationY){
    return
      ((mouseLocationX > x - selectionMargin && mouseLocationX < x + selectionMargin && mouseLocationY > y + 15 && mouseLocationY < y + h - 15 && !sLeftPlayer && !sLeftComp)
      || (mouseLocationX > x + w - selectionMargin && mouseLocationX < x + w + selectionMargin && mouseLocationY > y + 15 && mouseLocationY < y + h - 15 && !sRightPlayer && !sRightComp)
      || (mouseLocationX > x + 15 && mouseLocationX < x + w - 15 && mouseLocationY > y - selectionMargin && mouseLocationY < y + selectionMargin && !sTopPlayer && !sTopComp)
      || (mouseLocationX > x + 15 && mouseLocationX < x + w - 15 && mouseLocationY > y + h - selectionMargin && mouseLocationY < y + h + selectionMargin && !sBotPlayer && !sBotComp));
  }
  
  void setSelected(int mouseLocationX, int mouseLocationY, boolean playersTurn){
    if(mouseLocationX > x - selectionMargin && mouseLocationX < x + selectionMargin && mouseLocationY > y + 15 && mouseLocationY < y + h - 15 && !sLeftPlayer && !sLeftComp){ //<>//
      if(playersTurn){
        sLeftPlayer = true; 
      }
      else {
        sLeftComp = true;
      }
    }
    if(mouseLocationX > x + w - selectionMargin && mouseLocationX < x + w + selectionMargin && mouseLocationY > y + 15 && mouseLocationY < y + h - 15 && !sRightPlayer && !sRightComp){
      if(playersTurn){
        sRightPlayer = true; 
      }
      else {
        sRightComp = true;
      }
    }
    if(mouseLocationX > x + 15 && mouseLocationX < x + w - 15 && mouseLocationY > y - selectionMargin && mouseLocationY < y + selectionMargin && !sTopPlayer && !sTopComp){
      if(playersTurn){
        sTopPlayer = true; 
      }
      else {
        sTopComp = true;
      }
    }
    if(mouseLocationX > x + 15 && mouseLocationX < x + w - 15 && mouseLocationY > y + h - selectionMargin && mouseLocationY < y + h + selectionMargin && !sBotPlayer && !sBotComp){
      if(playersTurn){
        sBotPlayer = true; 
      }
      else {
        sBotComp = true;
      }
    }
  }
  
  boolean checkCompletion(){
    return((sLeftPlayer || sLeftComp) && (sRightPlayer || sRightComp) && (sTopPlayer || sTopComp) && (sBotPlayer || sBotComp) && !squareClaimed);
  }
  
  void setCompletion(boolean playersTurn){
      squareClaimed = true;
      if(playersTurn){
        playersBox = true;
      } else {
        playersBox = false;  
      }
  }
  
  void display(){
    if(squareClaimed){
      if(playersBox){
        fill(26, 216, 215);
      } else {
         fill(216, 36, 26);
      }
    } else{
      noFill(); 
    }
    rect(x, y, w, h); 
  }
  
  void highlight(){
     if(sLeftPlayer){
       fill(24, 183, 182);
       rect(x - 10, y, 20, h); 
     } else if (sLeftComp){
       fill(170, 31, 24);
       rect(x - 10, y, 20, h); 
     }
     if(sRightPlayer){
       fill(24, 183, 182);
       rect(x + w - 10, y, 20, h); 
     } else if(sRightComp){
       fill(170, 31, 24);
       rect(x + w - 10, y, 20, h);  
     }
     if(sTopPlayer){
       fill(24, 183, 182);
       rect(x, y - 10, w, 20); 
     } else if(sTopComp) {
       fill(170, 31, 24);
       rect(x, y - 10, w, 20);  
     }
     if(sBotPlayer){
       fill(24, 183, 182);
       rect(x, y + h - 10, w, 20); 
     } else if (sBotComp){
       fill(170, 31, 24);
       rect(x, y + h - 10, w, 20); 
     }
  }
}
