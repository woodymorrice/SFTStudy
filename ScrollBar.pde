/* Vertical by default, horizontal if 5th argument is true */
class ScrollBar {
  float sbLeft, sbTop, sbWidth, sbHeight, buttonWidth, buttonHeight, thumbZero, thumbStart, thumbSize;
  float minThumb, maxThumb;
  boolean draggingThumb = false;
  boolean decreasePressed = false;
  boolean increasePressed = false;
  
  boolean isVertical = true;
  
  final color defaultBackgroundColor = bg;
  final color defaultForegroundColor = bg1;
  final color highlightColor = fg4;
  final color selectedColor = aqua2;
  
  final float scrollAmount = 2.0;
  
  color thumbColor = defaultForegroundColor;
  color decreaseButtonColor = defaultForegroundColor;
  color increaseButtonColor = defaultForegroundColor;
  
  TextArea textArea;
  
  
  /* Default vertical scrollbar constructor */
  public ScrollBar(
    TextArea textArea, float sbLeft, float sbTop, float sbWidth, float sbHeight
  ) {
    this.textArea = textArea;
    this.sbLeft = sbLeft;
    this.sbTop = sbTop;
    this.sbWidth = sbWidth;
    this.sbHeight = sbHeight;
    
    this.buttonWidth = sbWidth;
    this.buttonHeight = sbWidth; // square buttons
    
    this.thumbZero = sbTop+buttonHeight;
    this.thumbStart = thumbZero;
    // change this, it should depend on the contents of the scrollPane
    this.thumbSize = updateThumbSize();
  }
  
  /* Horizontal scrollbar constructor */
  public ScrollBar(
    TextArea textArea, float sbLeft, float sbTop, float sbWidth, float sbHeight, boolean isHorizontal
  ) {
    this(textArea, sbLeft, sbTop, sbWidth, sbHeight);
    
    if (isHorizontal) {
      this.isVertical = false;
      this.buttonWidth = sbHeight;
      this.buttonHeight = sbHeight; // square buttons
      
      this.thumbZero = sbLeft+buttonWidth;
      this.thumbStart = thumbZero;
      // change this, it should depend on the contents of the scrollPane
      this.thumbSize = updateThumbSize();
    }
  }
  
  float updateThumbSize() {
    float thumbScale, newSize;
    if (isVertical) {
      thumbScale = textArea.getViewHeight()/textArea.getContentHeight();
      newSize = thumbScale * (sbHeight-2*buttonHeight);
    }
    else {    
      thumbScale = textArea.getViewWidth()/textArea.getContentWidth();
      newSize = thumbScale * (sbWidth-2*buttonWidth);
    }
    
    updateThumbMinMax(newSize);
    return newSize;
  }
  
  void updateThumbMinMax(float newSize) {
    if (isVertical) {
      minThumb = sbTop+buttonHeight;
      maxThumb = sbTop+sbHeight-buttonHeight-newSize;
    }
    else {
      minThumb = sbLeft+buttonWidth;
      maxThumb = sbLeft+sbWidth-buttonWidth-newSize;
    }
  }
  
  
  void draw() {
    this.thumbSize = updateThumbSize();
    updateScrollWithButton();
    
    // draw scrollbar track
    fill(defaultBackgroundColor);
    rect(sbLeft, sbTop, sbWidth, sbHeight);
    
    // draw scrollbar thumb
    fill(thumbColor);
    if (isVertical) {
      rect(sbLeft, thumbStart, sbWidth, thumbSize);
    }
    else {
      rect(thumbStart, sbTop, thumbSize, sbHeight);
    }
    
    // draw decrease arrow button
    fill(decreaseButtonColor);
    rect(sbLeft, sbTop, buttonWidth, buttonHeight);
    fill(defaultBackgroundColor);
    if (isVertical) {
      triangle(
        sbLeft+buttonWidth*1/2, sbTop+buttonHeight*1/4,
        sbLeft+buttonWidth*1/4, sbTop+buttonHeight*3/4,
        sbLeft+buttonWidth*3/4, sbTop+buttonHeight*3/4
      );
    }
    else {
      triangle(
        sbLeft+buttonWidth*1/4, sbTop+buttonHeight*1/2,
        sbLeft+buttonWidth*3/4, sbTop+buttonHeight*1/4,
        sbLeft+buttonWidth*3/4, sbTop+buttonHeight*3/4
      );
    }
    
    // draw increase arrow button
    fill(increaseButtonColor);
    if (isVertical) {
      float increaseArrowTop = sbTop+sbHeight-buttonHeight; 
      rect(sbLeft, increaseArrowTop, buttonWidth, buttonHeight);
      
      fill(defaultBackgroundColor);
      triangle(
        sbLeft+buttonWidth*1/4, increaseArrowTop+buttonHeight*1/4,
        sbLeft+buttonWidth*3/4, increaseArrowTop+buttonHeight*1/4,
        sbLeft+buttonWidth*1/2, increaseArrowTop+buttonHeight*3/4
      );
    }
    else {
      float increaseArrowLeft = sbLeft+sbWidth-buttonWidth;
      rect(increaseArrowLeft, sbTop, buttonWidth, buttonHeight);
      
      fill(defaultBackgroundColor);
      triangle(
        increaseArrowLeft+buttonWidth*1/4, sbTop+buttonHeight*1/4,
        increaseArrowLeft+buttonWidth*1/4, sbTop+buttonHeight*3/4,
        increaseArrowLeft+buttonWidth*3/4, sbTop+buttonHeight*1/2
      );
    }
  }
  
  void updateScrollWithButton() {
    updateThumbMinMax(thumbSize);
    
    float oldStart = thumbStart;
    if (decreasePressed) {
      thumbStart = constrain(
        thumbStart -= scrollAmount, minThumb, maxThumb
      );
    }
    if (increasePressed) {
      thumbStart = constrain(
        thumbStart += scrollAmount, minThumb, maxThumb
      );
    }
    handleScroll(oldStart-thumbStart);
  }
  
  boolean overThumb(float x, float y) {
    boolean isOver;
    if (isVertical) {
      isOver = x >= sbLeft && x <= sbLeft+sbWidth &&
        y >= thumbStart && y <= thumbStart+thumbSize;
    }
    else {
      isOver = x >= thumbStart && x <= thumbStart+thumbSize &&
        y >= sbTop && y <= sbTop+sbHeight;
    }
    return isOver;
  }
  
  boolean overDecreaseButton(float x, float y) {
    return (x >= sbLeft && x <= sbLeft+buttonWidth &&
            y >= sbTop && y <= sbTop+buttonHeight);
  }
  
  boolean overIncreaseButton(float x, float y) {
    boolean isOver;
    if (isVertical) {
      float increaseArrowTop = sbTop+sbHeight-buttonHeight;
      isOver = x >= sbLeft && x <= sbLeft+buttonWidth &&
        y >= increaseArrowTop && y<= increaseArrowTop+buttonHeight;
    }
    else {
      float increaseArrowLeft = sbLeft+sbWidth-buttonWidth;
      isOver = x >= increaseArrowLeft && x <= increaseArrowLeft+buttonWidth &&
        y >= sbTop && y<= sbTop+buttonHeight;
    }
    return isOver;
  }
  
  void handleMousePressed() {
    if (overThumb(mouseX, mouseY)) {
      draggingThumb = true;
      thumbColor = selectedColor;
    }
    else if (overDecreaseButton(mouseX, mouseY)) {
      decreaseButtonColor = selectedColor;
      decreasePressed = true;
    }
    else if (overIncreaseButton(mouseX, mouseY)) {
      increaseButtonColor = selectedColor;
      increasePressed = true;
    }
  }
  
  void handleMouseReleased() {
    if (draggingThumb) {
      thumbColor = overThumb(mouseX, mouseY) ? highlightColor : defaultForegroundColor;
      draggingThumb = false;
    }
    if (decreasePressed) {
      decreaseButtonColor = overDecreaseButton(mouseX, mouseY) ? highlightColor : defaultForegroundColor;
      decreasePressed = false;
    }
    if (increasePressed) {
      increaseButtonColor = overIncreaseButton(mouseX, mouseY) ? highlightColor : defaultForegroundColor;
      increasePressed = false;
    }
  }
  
  void handleMouseDragged() {
      if (draggingThumb) {
        updateThumbMinMax(thumbSize);
        
        float diff = isVertical ? mouseY-pmouseY : mouseX-pmouseX;
        
        float oldStart = thumbStart;
        thumbStart = constrain(
          thumbStart += diff, minThumb, maxThumb
        );
        
        handleScroll(oldStart-thumbStart);
      }
  }
  
  void handleScroll(float thumbDistMoved) {
    float thumbSpace = maxThumb-minThumb;
    
    float contentSpace = isVertical ? textArea.getContentHeight() : textArea.getContentWidth();
    
    
    float ratio = contentSpace/thumbSpace;
    
    
    //float distRatio = textArea.content
    //float dist = thumbStart-minThumb;
    
    //float ratio = dist/total;
    
    if (isVertical) {
      textArea.setViewTop(textArea.getViewTop() + ratio*thumbDistMoved);
    }
    else {
      textArea.setViewLeft(textArea.getViewLeft() + ratio*thumbDistMoved);
    }
  }
  
  void handleMouseMoved() {
    if (overThumb(mouseX, mouseY) && !draggingThumb) {
      thumbColor = highlightColor;
    } else { thumbColor = defaultForegroundColor; }
    
    if (overDecreaseButton(mouseX, mouseY) && !decreasePressed) {
      decreaseButtonColor = highlightColor;
    } else { decreaseButtonColor = defaultForegroundColor; }
    
    if (overIncreaseButton(mouseX, mouseY) && !increasePressed) {
      increaseButtonColor = highlightColor;
    } else { increaseButtonColor = defaultForegroundColor; }
  }
}
