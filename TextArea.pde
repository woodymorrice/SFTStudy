import org.fife.ui.rsyntaxtextarea.Token;
import org.fife.ui.rsyntaxtextarea.TokenMaker;
import org.fife.ui.rsyntaxtextarea.modes.JavaTokenMaker;

class TextArea implements Scrollable {
  float taLeft, taTop, taWidth, taHeight, viewLeft, viewTop, contentWidth, contentHeight;
  List<String> lines;
  
  HashMap<Integer, Integer> tokenColors;
  color defaultColor = gray;
  
  PFont font;
  
  final float textOffset = 5.0; // pixels from the border
  
  boolean printBool = true;
  int nTokensPrinted = 0;
  
  TokenMaker tokenMaker;
  javax.swing.text.Segment segment;
  Token token;
  
  public TextArea(float taLeft, float taTop, float taWidth, float taHeight) {
    this.taLeft = taLeft;
    this.taTop = taTop;
    this.taWidth = taWidth;
    this.taHeight = taHeight;
    this.viewLeft = taLeft;
    this.viewTop = taTop;
    this.contentWidth = taWidth;
    this.contentHeight = taHeight;
    
    tokenColors = initTokenColors();

    font = loadFont("Consolas-64.vlw");
 
    tokenMaker = new JavaTokenMaker();
  }
  
  void setText(List<String> lines) {
    this.lines = lines;
    contentWidth = taWidth;
    contentHeight = taHeight;
  }
  
  
  color getColor(int tokenType) {
    return tokenColors.getOrDefault(tokenType, defaultColor);
  }
  
  float getContentWidth() { return contentWidth; }
  float getContentHeight() { return contentHeight; }
  float getViewLeft() { return viewLeft; }
  float getViewTop() { return viewTop; }
  float getViewWidth() { return taWidth; }
  float getViewHeight() { return taHeight; }
  void setViewLeft(float viewLeft) { this.viewLeft = viewLeft; }
  void setViewTop(float viewTop) { this.viewTop = viewTop; }
  
  void draw() {
    if (lines != null) {
      
      textFont(font);
      textSize(16);

      float lineHeight = textAscent()+textDescent();
      
      for (int lineIndex = 0; lineIndex < lines.size(); lineIndex++) {
        String line = lines.get(lineIndex);
        javax.swing.text.Segment segment = new javax.swing.text.Segment(line.toCharArray(), 0, line.length());
        Token token = tokenMaker.getTokenList(segment, Token.NULL, 0);
        
        float x = viewLeft+textOffset;
        float y = viewTop+textOffset + lineIndex*lineHeight;

        while (token != null && token.isPaintable()) {
          color tokenColor = getColor(token.getType());
          String lexeme = token.getLexeme();
          
          if (printBool) {
            println("Token: " + token.getLexeme() + " -> type: " + token.getType());
            nTokensPrinted++;
            if (nTokensPrinted == 300) {
              printBool = false;
            }
          }
          
          fill(tokenColor);
          text(lexeme, x, y+textAscent());
          
          x += textWidth(lexeme);
          
          token = token.getNextToken(); 
        }
        
        if (x > contentWidth) contentWidth = x;   // update width
        if (y > contentHeight) contentHeight = y; // and height
      }
    }
    
  }

  
  void handleMousePressed() {

  }
  
  void handleMouseReleased() {

  }
  
  void handleMouseDragged() {

  }
  
  void handleMouseMoved() {

  }
  
  HashMap<Integer, Integer> initTokenColors() {
    HashMap<Integer, Integer> tokenColors = new HashMap<Integer, Integer>();
    tokenColors.put(1, gray);     // single line comment
    tokenColors.put(2, gray);     // multi-line comment
    tokenColors.put(3, gray);     // javadoc comment
    tokenColors.put(6, red2);     // keywords
    tokenColors.put(9, purple2);  // boolean
    tokenColors.put(10, purple2); // int
    tokenColors.put(11, purple2); // float
    tokenColors.put(13, green2);  // string
    tokenColors.put(14, green2);  // character
    tokenColors.put(19, blue2);   // annotation
    tokenColors.put(20, yellow2); // identifier
    tokenColors.put(22, blue);    // separator
    tokenColors.put(23, aqua2);   // operator
    tokenColors.put(35, red);     // error: identifier
    tokenColors.put(36, red);     // error: number format
    tokenColors.put(37, red);     // error: string
    tokenColors.put(38, red);
    
    return tokenColors;
  }
}
