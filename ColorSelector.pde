class ColorSelector{
    
    int x, y, h, w;
    int hueLine_x, hueLine_w, hueLine_h, hueLine_y, hueCircle_r;
    int sel_x, sel_y, sel_w, sel_h;
    int grad_x, grad_y, grad_w, grad_h;
    
    float gradSel_x, gradSel_y, gradSel_r;
    
    float selected_hue, selected_s, selected_b;
    
    boolean buffer;
    
    PGraphics graphics;
    
    ColorSelector(int x, int y, int w, int h){
      this.x = x;
      this.y = y;
      this.w = w;
      this.h = h;
      
      this.graphics = createGraphics(w, h);
      
      this.hueLine_x = 0;
      this.hueLine_w = this.w;
      this.hueLine_y = this.h - (this.h - this.w/4)/2;
      this.hueLine_h = 10;
      this.hueCircle_r = 20;
      this.selected_hue = 0;
      
      
      this.selected_b = 100;
      this.selected_s = 100;
      this.selected_hue = 100;
      
      this.sel_x = 0;
      this.sel_y = 0;
      this.sel_w = this.w/3;
      this.sel_h = this.w/4 + 50 + 1;
      
      this.grad_x = this.w/3;
      this.grad_y = 0;
      this.grad_w = 2*(this.w/3);
      this.grad_h = this.w/4 + 50;
      
      this.gradSel_x = this.grad_x + this.grad_w;
      this.gradSel_y = 0;
      this.gradSel_r = 10;
      
      this.renderHueLine(this.hueLine_x, this.hueLine_y, this.hueLine_w, this.hueLine_h);
      
      this.renderGradient();
      this.renderSelectedColor();
      
      this.buffer = false;
    }
    
 
    
    
    void display(){
      
      noFill();
      stroke(220);
      rect(colSel_x - 20, colSel_y - 20, colSel_w + 40, colSel_h);
      image(this.graphics, this.x, this.y);
      
      this.listen();
      
    }
    
    void listen(){
      
      if( mousePressed && mouseX >= this.x &&  mouseX < this.x + this.w && mouseY >= this.y && mouseY < this.y + this.h ){
        float mx_adj = mouseX - this.x;
        float my_adj = mouseY - this.y;
        //println("color selector pressed");
        if(  mx_adj >= this.hueLine_x &&  mx_adj < this.hueLine_x + this.hueLine_w && my_adj >= this.hueLine_y - 10 && my_adj < this.hueLine_y+10 + this.hueLine_h ){
         
          
          this.selected_hue = map(mx_adj, this.hueLine_x, this.hueLine_x+ this.hueLine_w, 0, 100);
          this.renderHueLine(this.hueLine_x, this.hueLine_y, this.hueLine_w, this.hueLine_h);
          //println("selected hue: " + this.selected_hue);
          this.renderGradient();
          this.renderSelectedColor();
        }
        if(  mx_adj >= this.grad_x &&  mx_adj < this.grad_x + this.grad_w && my_adj >= this.grad_y - 10 && my_adj < this.grad_y+10 + this.grad_h ){
         
          
          this.selected_b = map(my_adj, this.grad_y, this.grad_y+ this.grad_h, 100, 0);
          this.selected_s = map(mx_adj, this.grad_x, this.grad_x+ this.grad_w, 0, 100);
          //println("gradsel changed");
          this.gradSel_x = mx_adj;
          this.gradSel_y = my_adj;
          //println("selected b: " + this.selected_b);
          this.renderSelectedColor();
          this.renderGradient();
        }
      }
    }

    void renderSelectedColor(){
        this.graphics.beginDraw();
        this.graphics.colorMode(HSB, 100);
        this.graphics.noStroke();
        this.graphics.fill(this.selected_hue, this.selected_s, this.selected_b);
        this.graphics.rect(this.sel_x, this.sel_y, this.sel_w, this.sel_h);
        this.graphics.endDraw();
    }
    
    void renderHueLine(int x, int y, int w, int h){
      this.graphics.beginDraw();
      this.graphics.noStroke();
      this.graphics.colorMode(RGB, 255);
      this.graphics.fill(255);
      this.graphics.rect(x, y - h, w, h*2);
      this.graphics.colorMode(HSB, 100);
      for (int i = x; i < x + w; i++){
        this.graphics.strokeWeight(1);
        this.graphics.stroke(map(i, x, x+w, 0, 100), 100, 100);
        this.graphics.line(i, y - h/2, i, y+h/2);
      }
      this.graphics.strokeWeight(2);
      this.graphics.stroke(0, 0, 100);
      this.graphics.fill(this.selected_hue, 100, 100);
      this.graphics.ellipse(map(this.selected_hue, 0, 100, x, x+w), y, this.hueCircle_r, this.hueCircle_r);
      this.graphics.endDraw();
    }
    
    
    void renderGradient(){
      int x = this.grad_x;
      int y = this.grad_y;
      int h = this.grad_h;
      int w = this.grad_w;
      int inc = 1;
      int r = 1;
      this.graphics.beginDraw();
      this.graphics.colorMode(HSB, 100, 100, 100);
      this.graphics.noStroke();
      if (mousePressed){
        inc = 5;
        r = 10;
        this.buffer = true;
        //println("buffer switched here2");
        //this.renderSelectedColor();
      }else{
        inc = 1;
        r = 1;
        this.buffer = false;
        //println("buffer switched here");
      }
      //this.graphics.fill(50, 100, 100);
      for (int i = x; i < x + w; i+= inc){
        for (int j = y; j < y + h; j+= inc){
          if (this.buffer){
            this.graphics.fill(this.selected_hue, map(i, x, x+w, 0, 100), map(j, y, y+h, 100, 0));
            this.graphics.ellipse(i, j, r, r);
            
            
            
          }else{
            this.graphics.stroke(this.selected_hue, map(i, x, x+w, 0, 100), map(j, y, y+h, 100, 0));
            this.graphics.point(i, j);
          }
        }
      }
      //side line while buffered fixer
      
      //this.graphics.noStroke();
      //this.graphics.fill(this.selected_hue,this.selected_s,this.selected_b);
      //this.graphics.rect(x, y, 1, h+5);
      
      
      //bottom line bug fixer
      //this.graphics.stroke(0, 0, 0);
      //this.graphics.strokeWeight(2);
      //this.graphics.line(x, y+h, x+w, y+h);
      
      this.graphics.colorMode(HSB, 100);
        this.graphics.noStroke();
        this.graphics.fill(this.selected_hue, this.selected_s, this.selected_b);
        this.graphics.rect(this.sel_x, this.sel_y, this.sel_w, this.sel_h);
        
      
      //println("displaying circle" + frameCount);
      this.graphics.stroke(1, 0, 100);
      this.graphics.noFill();
      this.graphics.strokeWeight(2);
      this.graphics.ellipse(this.gradSel_x, this.gradSel_y, this.gradSel_r, this.gradSel_r);
      
      this.graphics.endDraw();
    }

}
