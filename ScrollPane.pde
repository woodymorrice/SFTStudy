class ScrollPane {
  float spLeft, spTop, spWidth, spHeight;
  ScrollBar verticalScrollBar;
  ScrollBar horizontalScrollBar;
  TextArea textArea;
  
  public ScrollPane(float spLeft, float spTop, float spWidth, float spHeight) {
    this.spLeft = spLeft;
    this.spTop = spTop;
    this.spWidth = spWidth;
    this.spHeight = spHeight;
    
    // text area
    textArea = new TextArea(spLeft, spTop, spWidth-SCROLLBAR_SIZE, spHeight-SCROLLBAR_SIZE);
    
    // vertical scroll bar
    float verticalScrollBarLeft = spLeft+spWidth-SCROLLBAR_SIZE;
    verticalScrollBar = new ScrollBar(
      verticalScrollBarLeft, spTop, SCROLLBAR_SIZE, spHeight-SCROLLBAR_SIZE
    );
    
    // horizontal scroll bar
    float horizontalScrollBarTop = spTop+spHeight-SCROLLBAR_SIZE;
    horizontalScrollBar = new ScrollBar(
      spLeft, horizontalScrollBarTop, spWidth-SCROLLBAR_SIZE, SCROLLBAR_SIZE, true
    );
  }
  
  void draw() {
    textArea.draw();
    verticalScrollBar.draw();
    horizontalScrollBar.draw();
  }
  
  void handleMousePressed() {
    textArea.handleMousePressed();
    verticalScrollBar.handleMousePressed();
    horizontalScrollBar.handleMousePressed();
  }
  
  void handleMouseReleased() {
    textArea.handleMouseReleased();
    verticalScrollBar.handleMouseReleased();
    horizontalScrollBar.handleMouseReleased();
  }
  
  void handleMouseDragged() {
    textArea.handleMouseReleased();
    verticalScrollBar.handleMouseDragged();
    horizontalScrollBar.handleMouseDragged();
  }
  
  void handleMouseMoved() {
    textArea.handleMouseMoved();
    verticalScrollBar.handleMouseMoved();
    horizontalScrollBar.handleMouseMoved();
  }
  
  void setText(List<String> text) {
    textArea.setText(text);
  }
}
