class ScrollBar {
  float sbLeft, sbTop, sbWidth, sbHeight, buttonWidth, buttonHeight, thumbZero, thumbTop, thumbHeight;
  boolean draggingThumb = false;
  boolean upPressed = false;
  boolean downPressed = false;
  
  final color defaultBackgroundColor = bg;
  final color defaultForegroundColor = bg1;
  final color highlightColor = fg4;
  final color selectedColor = aqua2;
  
  final float scrollAmount = 2.0;
  
  color thumbColor = defaultForegroundColor;
  color upButtonColor = defaultForegroundColor;
  color downButtonColor = defaultForegroundColor;
  
  
  public ScrollBar(float sbLeft, float sbTop, float sbWidth, float sbHeight) {
    this.sbLeft = sbLeft;
    this.sbTop = sbTop;
    this.sbWidth = sbWidth;
    this.sbHeight = sbHeight;
    
    this.buttonWidth = sbWidth;
    this.buttonHeight = sbWidth; // square buttons
    
    this.thumbZero = sbTop + buttonHeight;
    this.thumbTop = thumbZero;
    // change this, it should depend on the contents of the scrollPane
    this.thumbHeight = sbHeight/4;
  }
  
  
  void draw() {
    updateScrollWithButton();
    
    // draw scrollbar track
    fill(defaultBackgroundColor);
    rect(sbLeft, sbTop, sbWidth, sbHeight);
    
    // draw scrollbar thumb
    fill(thumbColor);
    rect(sbLeft, thumbTop, sbWidth, thumbHeight);
    
    // draw up arrow button
    fill(upButtonColor);
    rect(sbLeft, sbTop, buttonWidth, buttonHeight);
    fill(defaultBackgroundColor);
    triangle(
      sbLeft+buttonWidth*1/2, sbTop+buttonHeight*1/4,
      sbLeft+buttonWidth*1/4, sbTop+buttonHeight*3/4,
      sbLeft+buttonWidth*3/4, sbTop+buttonHeight*3/4
    );
    
    // draw down arrow button
    float downArrowTop = sbHeight-buttonHeight;
    fill(downButtonColor);
    rect(sbLeft, downArrowTop, buttonWidth, buttonHeight);
    fill(defaultBackgroundColor);
    triangle(
      sbLeft+buttonWidth*1/4, downArrowTop+buttonHeight*1/4,
      sbLeft+buttonWidth*3/4, downArrowTop+buttonHeight*1/4,
      sbLeft+buttonWidth*1/2, downArrowTop+buttonHeight*3/4
    );
  }
  
  void updateScrollWithButton() {
    float minThumbHeight = sbTop+buttonHeight;
    float maxThumbHeight = sbTop+sbHeight-buttonHeight-thumbHeight;
    
    if (upPressed) {
      thumbTop = constrain(
        thumbTop -= scrollAmount, minThumbHeight, maxThumbHeight
      );
    }
    if (downPressed) {
      thumbTop = constrain(
        thumbTop += scrollAmount, minThumbHeight, maxThumbHeight
      );
    }
  }
  
  boolean overThumb(float x, float y) {
    return (x >= sbLeft && x <= sbLeft+sbWidth &&
            y >= thumbTop && y <= thumbTop+thumbHeight);
  }
  
  boolean overUpButton(float x, float y) {
    return (x >= sbLeft && x <= sbLeft+buttonWidth &&
            y >= sbTop && y <= sbTop+buttonHeight);
  }
  
  boolean overDownButton(float x, float y) {
    float downArrowTop = sbHeight-buttonHeight;
    return (x >= sbLeft && x <= sbLeft+buttonWidth &&
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
  
  void handleMouseDragged() {
      if (draggingThumb) {
        float minThumbHeight = sbTop+buttonHeight;
        float maxThumbHeight = sbTop+sbHeight-buttonHeight-thumbHeight;
        
        thumbTop = constrain(
          thumbTop += mouseY-pmouseY, minThumbHeight, maxThumbHeight
        );
      }
  }
  
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
