//parent button just allows to click inside and is clicked
//can either be clicked and stay in that mode,
//or be clicked and something be activated

class Button{
    
    float x, y, w, h;
    boolean singlePress, pressed, listening, iconMode;
    int r, g, b;
    PImage icon;
    String label;
    
    Button(float x, float y, float w, float h, boolean singlePressMode, int r, int g, int b, String text, boolean iconMode, boolean listening){
      this.x = x;
      this.y = y;
      this.w = w;
      this.h = h;
      this.singlePress = singlePressMode;
      this.pressed = false;
      this.r = r;
      this.g = g;
      this.b = b;
      this.iconMode = iconMode;
      if (iconMode){
        this.icon = loadImage(text);
      }else{
        this.label = text;
      }
      this.listening = listening;
    }
    
    boolean wasClicked(){
      if (mouseX > this.x && mouseX < this.x + this.w && mouseY > this.y && mouseY < this.y + this.w && this.listening){
        if (this.singlePress){
          this.pressed = true;
        }
        //println("button clicked");
        return true;
      }
      return false;
    }
    
    void display(){
        if (this.listening){
        strokeWeight(1);
        stroke(0);
        fill(this.r, this.g, this.b);
        
        rectMode(CORNER);
        rect(this.x, this.y, this.w, this.h);
        
        if (this.iconMode){
          imageMode(CORNER);
          image(this.icon, this.x, this.y, this.w, this.h);
        }else{
          fill(0);
          textAlign(CENTER);
          textSize(12);
          text(this.label, this.x + this.w/2, this.y + this.h/2 - 5);
        }
      }
    }
    
}


class ProjectButton extends Button{
  
  //click and will open up: Open Project, Create New Project
  //whenever project is created or opened, stop listening and displaying
  
  boolean projectOpen, offeringOptions;
  CreateProjectButton createProjectButton;
  OpenProjectButton openProjectButton;
  DimensionButtons dimensionButtons;
  
  ProjectButton(float x, float y, float w, float h){
    super(x, y, w, h, true, 200, 200, 200, "plus-sign.png", true, true);
    this.projectOpen = false;
    this.offeringOptions = false;
    
    this.createProjectButton = new CreateProjectButton(this.x - width/7, this.y, this.w*4, this.h);
    buttonList.add(this.createProjectButton);
    
    this.openProjectButton = new OpenProjectButton(this.x + width/10, this.y, this.w*4, this.h);
    buttonList.add(this.openProjectButton);
    
    
  }
  
  @Override
  boolean wasClicked(){
    if (super.wasClicked()){
      println("project button was clicked");
      
      this.offeringOptions = true;
      super.listening = false;
      
      return true;
    }
    return false;
  }
  
  @Override
  void display(){
    if (this.projectOpen){
      //do nothing
    }else if (this.offeringOptions){
      //this.createProjectButton.display();
      this.createProjectButton.listening = true;
      
      //this.openProjectButton.display();
      this.openProjectButton.listening = true;
    }
    else{
      super.display();
    }
  }
  
  void offerOptions(){
    
  }

}



class CreateProjectButton extends Button{
  
  DimensionButtons dimensionButtons;
  
  CreateProjectButton(float x, float y, float w, float h){
    super(x, y, w, h, true, 200, 200, 200, "Create New Project", false, false);
    
    dimensionButtons = new DimensionButtons(this.x - width/6, this.y, this.w/2, this.h, 20);
  }
  
  @Override
  boolean wasClicked(){
    if (super.wasClicked()){
      println("CreateNewProject button was clicked");
      
      projectButton.offeringOptions = false;
      this.hide();
      projectButton.openProjectButton.hide();
      projectButton.projectOpen = true;
      
      dimensionButtons.turnOnButtons();
      
      return true;
    }
    return false;
  }
  
  void hide(){
    super.listening = false;
  }
  
}

class OpenProjectButton extends Button{
  

  OpenProjectButton(float x, float y, float w, float h){
    super(x, y, w, h, true, 200, 200, 200, "Open Project", false, false);

  }
  
  @Override
  boolean wasClicked(){
    if (super.wasClicked()){
      println("OpenProject button was clicked");
      
      projectButton.offeringOptions = false;
      this.hide();
      projectButton.openProjectButton.hide();
      projectButton.projectOpen = true;
      
      return true;
    }
    return false;
  }
  
  void hide(){
    super.listening = false;
  }
  
}


class DimensionButtons extends Button{
  
    float x, y, buttonW, buttonH, dist;
    Button squareButton, videoButton, landscapeButton, portraitButton, storyButton; //1:1, 19:6, 1.91:1, 4:5, 9:16
    ArrayList<Button> buttons;
    
    DimensionButtons(float x, float y, float buttonW, float buttonH, float dist){
      super(x, y, (buttonW + dist)*5, buttonH, true, 0, 0, 0, "", false, false);
      this.x = x;
      this.y = y;
      this.buttonW = buttonW;
      this.buttonH = buttonH;
      this.dist = dist;
      
      this.squareButton = new Button(this.x, this.y, this.buttonW, this.buttonH, true, 200, 200, 200, "square\n1:1", false, false);
      this.videoButton = new Button(this.x + (this.buttonW + dist), this.y, this.buttonW, this.buttonH, true, 200, 200, 200, "video\n19:6", false, false);
      this.landscapeButton = new Button(this.x + (this.buttonW + dist)*2, this.y, this.buttonW, this.buttonH, true, 200, 200, 200, "landscape\n1.91:1", false, false);
      this.portraitButton = new Button(this.x + (this.buttonW + dist)*3, this.y, this.buttonW, this.buttonH, true, 200, 200, 200, "portrait\n4:5", false, false);
      this.storyButton = new Button(this.x +(this.buttonW + dist)*4, this.y, this.buttonW, this.buttonH, true, 200, 200, 200, "story\n9:16", false, false);
      
      this.buttons = new ArrayList<Button>();
      this.buttons.add(squareButton);
      this.buttons.add(videoButton);
      this.buttons.add(landscapeButton);
      this.buttons.add(portraitButton);
      this.buttons.add(storyButton);
      
      buttonList.add(this);
      for (Button b : this.buttons){
        buttonList.add(b);
      }
    }
    
    @Override
    void display(){
      for (Button b : this.buttons){
        b.display();
      }
    }
    
    void turnOnButtons(){
      this.listening = true;
      for (Button b : this.buttons){
        b.listening = true;
      }
    }
    
    void turnOffButtons(){
      this.listening = false;
      for (Button b : this.buttons){
        b.listening = false;
      }
    }
    
    void createCanvas(){
      Canvas newCanvas = new Canvas(300, 100, 600, 400);
      canvasList.add(newCanvas);
      workingCanvas = newCanvas;
    }
    
    void hide(){
      for (Button b : this.buttons){
        b.listening = false;
      }
    }
    
  @Override
  boolean wasClicked(){
    if (super.wasClicked()){
      println("A dimension button was clicked");      
      
      canvasCreated = true;
      
      //1:1, 19:6, 1.91:1, 4:5, 9:16
      if (squareButton.wasClicked()){
        println("square button was clicked");
        
        canvas_w = 500;
        canvas_h = 500;
      }
      if (videoButton.wasClicked()){
        println("video button was clicked");
        
        canvas_w = 700;
        canvas_h = 221;
      }
      if (landscapeButton.wasClicked()){
        println("landscape button was clicked");
        
        canvas_w = 700;
        canvas_h = 366;
      }
      if (portraitButton.wasClicked()){
        println("portrait button was clicked");
        
        canvas_w = 400;
        canvas_h = 500;
      }
      if (storyButton.wasClicked()){
        println("story button was clicked");
        
        canvas_w = 281;
        canvas_h = 500;
      }
      
      workingCanvas = new GridCanvas(canvas_x, canvas_y, canvas_w, canvas_h);
        
      canvasList.add(workingCanvas);
      
      this.turnOffButtons();
            
      return true;
    }
    return false;
  }
  
}
