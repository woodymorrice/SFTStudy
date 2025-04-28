class ScrollPane {
  float spLeft, spTop, spWidth, spHeight;
  ScrollBar scrollBar;
  TextArea textArea;
  
  public ScrollPane(float spLeft, float spTop, float spWidth, float spHeight) {
    this.spLeft = spLeft;
    this.spTop = spTop;
    this.spWidth = spWidth;
    this.spHeight = spHeight;
    
    // text area
    textArea = new TextArea(spLeft, spTop, spWidth-SCROLLBAR_WIDTH, spHeight);
    
    // scroll bar
    float scrollBarLeft = spLeft+spWidth-SCROLLBAR_WIDTH;
    scrollBar = new ScrollBar(scrollBarLeft, spTop, SCROLLBAR_WIDTH, spHeight); 
  }
  
  void draw() {
    textArea.draw();
    scrollBar.draw();
  }
  
  void handleMousePressed() {
    textArea.handleMousePressed();
    scrollBar.handleMousePressed();
  }
  
  void handleMouseReleased() {
    textArea.handleMouseReleased();
    scrollBar.handleMouseReleased();
  }
  
  void handleMouseDragged() {
    textArea.handleMouseReleased();
    scrollBar.handleMouseDragged();
  }
  
  void handleMouseMoved() {
    textArea.handleMouseMoved();
    scrollBar.handleMouseMoved();
  }
  
  void setText(List<String> text) {
    textArea.setText(text);
  }
}
