import java.util.*;

// Configurações do jogo
final int GRID_WIDTH = 40;
final int GRID_HEIGHT = 30;
final int CELL_SIZE = 20;
final int STARTING_MONEY = 10000000;
final int WAVES_TO_WIN = 21;
final float GAME_SPEED_NORMAL = 1.0f;
final float GAME_SPEED_FAST = 2.0f;
 
// Estados do jogo
GameState gameState;
GameGrid gameGrid;
WaveManager waveManager;
Player player;
UI ui;
float gameSpeed = GAME_SPEED_NORMAL;


PImage money;
PImage torre2;
PImage torre3;
PImage torre4;
PImage torre5;
PImage torre6;
PImage Fundo;
PImage FundoEscuro;
PImage dragao;
PImage dragaobranco;
PImage dragaoarm;
PImage fantasma;

void setup() {
  size(800, 600);
  gameState = new GameState();
  gameGrid = new GameGrid(GRID_WIDTH, GRID_HEIGHT, CELL_SIZE);
  waveManager = new WaveManager();
  player = new Player(STARTING_MONEY);
  ui = new UI();
  torre2 = loadImage("3.png");
  torre3 = loadImage("2.png");
  torre4 = loadImage("4.png");
  torre5 = loadImage("5.png");
  torre6 = loadImage("1.png");
  money  = loadImage("bau.png");
  Fundo  = loadImage("fundo.jpg");
  FundoEscuro  = loadImage("fundoEscuro.png");
  dragao = loadImage("Dragaofofo.png");
  dragaobranco = loadImage("DragaoFofoBranco.png");
  dragaoarm = loadImage("DragaoFofoArm.png");
  fantasma = loadImage("fantasma.png");
  
  Fundo.resize(width, height);
  FundoEscuro.resize(width, height);
}

void draw() {
  
  
  if (gameState.getCurrentWave() < 10) {
    background(Fundo);
    
  
  }else {
    background(FundoEscuro);
  }
  


  gameGrid.update();
  gameGrid.display();
  waveManager.update();
  waveManager.display();
  ui.display();
  //  imageMode();

  if (gameState.isGameOver()) {
    displayGameOver();
  }
}

void mouseDragged() {
   if (mouseButton == LEFT && gameState.isPlaying()) {
    int gridX = mouseX / CELL_SIZE;
    int gridY = mouseY / CELL_SIZE;

    if (gridX >= 0 && gridX < GRID_WIDTH && gridY >= 0 && gridY < GRID_HEIGHT) {
      ui.handleGridClick(gridX, gridY);
    }
  }else if(mouseButton == RIGHT && gameState.isPlaying()){
      
  }
}

void mousePressed() {
  if (mouseButton == LEFT && gameState.isPlaying()) {
    int gridX = mouseX / CELL_SIZE;
    int gridY = mouseY / CELL_SIZE;

    if (gridX >= 0 && gridX < GRID_WIDTH && gridY >= 0 && gridY < GRID_HEIGHT) {
      ui.handleGridClick(gridX, gridY);
    }
  }else if(mouseButton == RIGHT && gameState.isPlaying()){
    
    int gridX = mouseX / CELL_SIZE;
    int gridY = mouseY / CELL_SIZE;

    if (gridX >= 0 && gridX < GRID_WIDTH && gridY >= 0 && gridY < GRID_HEIGHT) {
      gameGrid.Sell(gridX, gridY);
    }
  }
}


void keyPressed() {
  if (key == '1') {
    ui.selectStructure(StructureType.WALL);
  } else if (key == '2') {
    ui.selectStructure(StructureType.SAND);
  } else if (key == '3') {
    ui.selectStructure(StructureType.TOWER);
  } else if (key == 'r' || key == 'R') {
    restartGame();
  } else if (key == ' ' && !waveManager.isWaveInProgress()) {
    waveManager.startWave();
  } else if (key == 't' || key == 'T') {
    toggleGameSpeed();
  }
}

void displayGameOver() {
  // Fundo escuro translúcido
  fill(0, 0, 0, 180);
  rect(0, 0, width, height);

  // Caixa central com fundo semi-transparente
  int boxW = 400;
  int boxH = 200;
  int boxX = width/2 - boxW/2;
  int boxY = height/2 - boxH/2;

  fill(50, 50, 50, 220);
  noStroke();
  rect(boxX, boxY, boxW, boxH, 20); // bordas arredondadas

  // Título (vitória ou derrota)
  textAlign(CENTER, CENTER);
  textSize(40);
  if (gameState.hasWon()) {
    fill(0, 255, 100); // verde para vitória
    text("🎉 VITÓRIA! 🎉", width/2, height/2 - 50);
    
    textSize(20);
    fill(255);
    text("Você sobreviveu a " + WAVES_TO_WIN + " ondas!", width/2, height/2);
  } else {
    fill(255, 80, 80); // vermelho para derrota
    text("💀 DERROTA 💀", width/2, height/2 - 50);

    textSize(20);
    fill(200);
    text("O dinheiro foi capturado!", width/2, height/2);
  }

  // Mensagem de reinício
  textSize(16);
  fill(255, 255, 100);
  text("Pressione R para reiniciar", width/2, height/2 + 60);
}

void restartGame() {
  gameState = new GameState();
  gameGrid = new GameGrid(GRID_WIDTH, GRID_HEIGHT, CELL_SIZE);
  waveManager = new WaveManager();
  player = new Player(STARTING_MONEY);
  ui = new UI();
  gameSpeed = GAME_SPEED_NORMAL;
}

void toggleGameSpeed() {
  if (gameSpeed == GAME_SPEED_NORMAL) {
    gameSpeed = GAME_SPEED_FAST;
  } else {
    gameSpeed = GAME_SPEED_NORMAL;
  }
}
