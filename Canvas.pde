//flexible dimensions when created
//mayybe flexible dimensions after? not sure how thats gonna work
//maybe we save with high pixel density or something

class Canvas{

    float x, y;
    int w, h;
    PGraphics graphics;
    
    Canvas(float x, float y, int w, int h){
      this.x = x;
      this.y = y;
      this.w = w;
      this.h = h;
      this.graphics = createGraphics(w, h);
    }

    void display(){
      strokeWeight(1);
      stroke(0);
      noFill();
      rect(canvas_x, canvas_y, canvas_w, canvas_h);
      //image(this.graphics, this.x, this.y, this.w, this.h);
    }
    
    void handleRelease(){
    
    }
}



class GridCanvas extends Canvas{

    boolean showGrid;
    Key leftKey, rightKey, upKey, downKey, paintKey, hideGridKey;
    float box_x, box_y, box_size;
    
    ColorSelector colorSelector;
    
    GridCanvas(float x, float y, int w, int h){
      super(x, y, w, h);
      this.leftKey = new Key(new String[]{"a", "LEFT"}, new String[]{"RELEASED", "PRESSED"});
      this.rightKey = new Key(new String[]{"d", "RIGHT"}, new String[]{"RELEASED"});
      this.upKey = new Key(new String[]{"w", "UP"}, new String[]{"RELEASED"});
      this.downKey = new Key(new String[]{"s", "DOWN"}, new String[]{"RELEASED"});
      this.paintKey= new Key(new String[]{"SHIFT"}, new String[]{"RELEASED"});
      this.hideGridKey = new Key(new String[]{"q"}, new String[]{"RELEASED"});
      
      listeningKeys.add(this.leftKey);
      listeningKeys.add(this.rightKey);
      listeningKeys.add(this.upKey);
      listeningKeys.add(this.downKey);
      listeningKeys.add(this.paintKey);
      listeningKeys.add(this.hideGridKey);
      
      this.box_size = 10;
      this.box_x = 0;
      this.box_y = 0;
      
      this.colorSelector = new ColorSelector(colSel_x, colSel_y, colSel_w, colSel_h);
      
    }
    
    @Override
    void display(){
      super.display();
      this.graphics.beginDraw();
      //this.graphics.background(255, 168, 184);
      
      if (this.showGrid){
        //vertical lines
        for (int i = 0; i < this.w; i+= this.box_size){
          stroke(0);
          strokeWeight(1);
          line(this.x + i, this.y, this.x + i, this.y + this.h);
        }
        
        //horizontal lines
        for (int i = 0; i < this.h; i+= this.box_size){
          stroke(0);
          strokeWeight(1);
          line(this.x, this.y + i, this.x + this.w, this.y + i);
        }
      }
      
      stroke(0);
      strokeWeight(2);
      noFill();
      rect(this.x + this.box_x, this.y + this.box_y, this.box_size, this.box_size);
      
      this.graphics.endDraw();
      
      image(this.graphics, this.x, this.y, this.w, this.h);
      
      this.colorSelector.display();
      
      this.update();
    }
    
    void update(){
      if (this.leftKey.isOn()){
        this.moveLeft();
        //println("move left" + frameCount);
      }
      if (this.rightKey.isOn()){
        this.moveRight();
        //println("move right" + frameCount);
      }
      if (this.upKey.isOn()){
        this.moveUp();
        //println("move up" + frameCount);
      }
      if (this.downKey.isOn()){
        this.moveDown();
        //println("move down" + frameCount);
      }
      if (this.paintKey.isOn()){
        this.paint();
        //println("paint" + frameCount);
      }
      if (this.hideGridKey.isOn()){
        this.toggleGrid();
        //println("toggleGrid" + frameCount);
      }
    }
    
    @Override
    void handleRelease(){
      this.colorSelector.renderGradient();
      this.colorSelector.renderSelectedColor();
    }
    
    void moveLeft(){
      this.box_x -= this.box_size;
      
      if (this.box_x < 0){
        this.box_x = this.w - this.box_size;
      }
    }
    
    void moveRight(){
      this.box_x += this.box_size;
      
      if (this.box_x >= this.w){
        this.box_x = 0;
      }
    }
    
    void moveUp(){
      this.box_y -= this.box_size;
      
      if (this.box_y < 0){
        this.box_y = this.h - this.box_size;
      }
    }
    
    void moveDown(){
      this.box_y += this.box_size;
      
      if (this.box_y >= this.h){
        this.box_y = 0;
      }
    }
    
    void paint(){
      this.graphics.beginDraw();
      this.graphics.noStroke();
      this.graphics.colorMode(HSB, 100);
      println("hue: " + this.colorSelector.selected_hue + ", s: ", this.colorSelector.selected_s + ", b: ", this.colorSelector.selected_b);
      this.graphics.fill(this.colorSelector.selected_hue, this.colorSelector.selected_s, this.colorSelector.selected_b);
      this.graphics.rect(this.box_x, this.box_y, this.box_size, this.box_size);
      this.graphics.endDraw();
    }
    
    void toggleGrid(){
      this.showGrid = !this.showGrid;
    }
}

class Key{

    ArrayList<String> chars;
    ArrayList<String> modes;
    boolean isOn;
    
    Key(String[] chars, String[] modes){
      
      this.chars = new ArrayList<String>();
      for (int i = 0; i < chars.length; i ++){
        this.chars.add(chars[i]);
      }
      this.modes = new ArrayList<String>();
      for (int i = 0; i < modes.length; i ++){
        this.modes.add(modes[i]);
      }
    
      this.isOn = false;
    }
    
    boolean isOn(){
      boolean return_val = isOn;
      isOn = false;
      return return_val;
    }
    
    void checkRelease(String k){
      if (modes.contains("RELEASED")){
        if (this.chars.contains(k)){
          //println(k + " pressed");
          if (this.isOn == true){
            this.isOn = false;
          }else {
            this.isOn = true;
          }
        }
      }
    }
    
    void checkPress(String k){
      if (modes.contains("PRESSED")){
        //if (this.chars.contains(k)){
        //  //println(k + " pressed");
        //  this.isOn = true;
        //}
      }
    }

}
