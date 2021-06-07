//open a project or start new project

boolean darkMode = false;

ProjectButton projectButton;

ArrayList<Button> buttonList;

ArrayList<Canvas> canvasList;
Canvas workingCanvas;

int canvas_x, canvas_y, canvas_w, canvas_h;

boolean canvasCreated;

ArrayList<Key> listeningKeys;

int colSel_x = 550;
int colSel_y = 550;
int colSel_w = 400;
int colSel_h = 240;

ColorSelector colorSelector;

void settings(){
  size(1000, 800);
}

void setup(){
  buttonList = new ArrayList<Button>();
  projectButton = new ProjectButton(int(width * 0.65), int(height * 0.25), int(height * 0.05), int(height * 0.05));
  buttonList.add(projectButton);
  
  canvasList = new ArrayList<Canvas>();
  
  canvas_x = 200;
  canvas_y = 20;
  canvas_w = 700;
  canvas_h = 500;
  
  canvasCreated = false;
  
  listeningKeys = new ArrayList<Key>();
  
  colorSelector = new ColorSelector(700, 550, 200, 200);
}
void draw(){
  
  background(255);
  
  //colorSelector.display();
  
  for (Button b : buttonList){
    b.display();
  }
  
  if (canvasCreated){
    workingCanvas.display();
  }
}

void mouseClicked(){
  for (Button b : buttonList){
    b.wasClicked();
  }
}

void mouseReleased(){
  if (canvasCreated){
    workingCanvas.handleRelease();
  }
}
  
  void keyReleased(){
    String c = "";
    
    if (key == CODED){
      if (keyCode == UP) {
        c = "UP";
      }
      if (keyCode == DOWN) {
        c = "DOWN";
      }
      if (keyCode == LEFT) {
        c = "LEFT";
      }
      if (keyCode == RIGHT) {
        c = "RIGHT";
      }
      if (keyCode == SHIFT) {
        c = "SHIFT";
      }
    }else {
      c = str(key);
    }
    for (Key k : listeningKeys){
      if (k.modes.contains("RELEASED")){
       k.checkRelease(c);
      }
    }
  }

void keyPressed(){
  String c = "";
    
    if (key == CODED){
      if (keyCode == UP) {
        c = "UP";
      }
      if (keyCode == DOWN) {
        c = "DOWN";
      }
      if (keyCode == LEFT) {
        c = "LEFT";
      }
      if (keyCode == RIGHT) {
        c = "RIGHT";
      }
      if (keyCode == SHIFT) {
        c = "SHIFT";
      }
    }else {
      c = str(key);
    }
    
    for (Key k : listeningKeys){
       k.checkPress(c);
    }
  }
