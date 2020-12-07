

class Button{

  public int x = 0;
  public int y = 0;
  public int w = 0;
  public int h = 0;
  public String meta = "";
  public String text = "";
  
  Button(String text, int x, int y, int w, int h, String meta){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.text = text; 
    this.meta = meta;
  }
  
  public void draw_button(int r, int g, int b){
    
      PShape button = createShape(GROUP);
            
      PShape base = createShape(RECT, this.x, this.y, this.w, this.h);
      base.setFill(color(r, g, b));
      button.addChild(base);
     
      shape(button);
      
      fill(255, 255, 255);
      textSize(22);
      textAlign(CENTER, CENTER);
      text(this.text, x + (w/2), y + (h/2) - 3);
      
  }
  
}
