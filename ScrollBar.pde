class ScrollBar {
  float left, top, sbWidth, sbHeight, buttonWidth, buttonHeight, thumbTop, thumbHeight;
  boolean draggingThumb = false;
  boolean upPressed = false;
  boolean downPressed = false;
  
  final color defaultBackgroundColor = bg;
  final color defaultForegroundColor = bg1;
  final color highlightColor = fg4;
  final color selectedColor = aqua2;
  
  color thumbColor = defaultForegroundColor;
  color upButtonColor = defaultForegroundColor;
  color downButtonColor = defaultForegroundColor;
  
  // Dragging logic
  float scrollOffset = 0; // Scroll offset in pixels
  
  
  public ScrollBar(float left, float top, float sbWidth, float sbHeight) {
    this.left = left;
    this.top = top;
    this.sbWidth = sbWidth;
    this.sbHeight = sbHeight;
    
    this.buttonWidth = sbWidth;
    this.buttonHeight = sbWidth;
    
    this.thumbTop = top + buttonHeight;
    // change this, it should depend on the contents of the scrollPane
    this.thumbHeight = sbHeight/4;
  }
  
  
  void draw() {
    // draw scrollbar track
    fill(defaultBackgroundColor);
    rect(left, top, sbWidth, sbHeight);
    
    // draw scrollbar thumb
    fill(thumbColor);
    rect(left, thumbTop, sbWidth, thumbHeight);
    
    // draw up arrow button
    fill(upButtonColor);
    rect(left, top, buttonWidth, buttonHeight);
    fill(defaultBackgroundColor);
    triangle(
      left+buttonWidth*1/2, top+buttonHeight*1/4,
      left+buttonWidth*1/4, top+buttonHeight*3/4,
      left+buttonWidth*3/4, top+buttonHeight*3/4
    );
    
    // draw down arrow button
    float downArrowTop = sbHeight-buttonHeight;
    fill(downButtonColor);
    rect(left, downArrowTop, buttonWidth, buttonHeight);
    fill(defaultBackgroundColor);
    triangle(
      left+buttonWidth*1/4, downArrowTop+buttonHeight*1/4,
      left+buttonWidth*3/4, downArrowTop+buttonHeight*1/4,
      left+buttonWidth*1/2, downArrowTop+buttonHeight*3/4
    );
  }
  
  boolean overThumb(float x, float y) {
    return (x >= left && x <= left+sbWidth &&
            y >= thumbTop && y <= thumbTop+thumbHeight);
  }
  
  boolean overUpButton(float x, float y) {
    return (x >= left && x <= left+buttonWidth &&
            y >= top && y <= top+buttonHeight);
  }
  
  boolean overDownButton(float x, float y) {
    float downArrowTop = sbHeight-buttonHeight;
    return (x >= left && x <= left+buttonWidth &&
            y >= downArrowTop && y<= downArrowTop+buttonHeight);
  }
  
  void handleMousePressed() {
    if (overThumb(mouseX, mouseY)) {
      draggingThumb = true;
      thumbColor = selectedColor;
    }
    else if (overUpButton(mouseX, mouseY)) {
      upButtonColor = selectedColor;
      upPressed = true;
    }
    else if (overDownButton(mouseX, mouseY)) {
      downButtonColor = selectedColor;
      downPressed = true;
    }
  }
  
  void handleMouseReleased() {
    if (draggingThumb) {
      thumbColor = overThumb(mouseX, mouseY) ? highlightColor : defaultForegroundColor;
      draggingThumb = false;
    }
    
    if (upPressed) {
      upButtonColor = overUpButton(mouseX, mouseY) ? highlightColor : defaultForegroundColor;
      upPressed = false;
    }
    
    if (downPressed) {
      downButtonColor = overDownButton(mouseX, mouseY) ? highlightColor : defaultForegroundColor;
      downPressed = false;
    }
  }
  
  //void handleMouseDragged() {
  //    if (draggingThumb) {
  //      thumbTop = constrain(mouseY-thumbHeight/2, top+buttonHeight, top+sbHeight-buttonHeight-thumbHeight);
  //    }
  //}
  
  void handleMouseMoved() {
    if (overThumb(mouseX, mouseY) && !draggingThumb) {
      thumbColor = highlightColor;
    } else { thumbColor = defaultForegroundColor; }
    
    if (overUpButton(mouseX, mouseY) && !upPressed) {
      upButtonColor = highlightColor;
    } else { upButtonColor = defaultForegroundColor; }
    
    if (overDownButton(mouseX, mouseY) && !downPressed) {
      downButtonColor = highlightColor;
    } else { downButtonColor = defaultForegroundColor; }
  }
}
