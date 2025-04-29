import org.fife.ui.rsyntaxtextarea.Token;
import org.fife.ui.rsyntaxtextarea.TokenMaker;
import org.fife.ui.rsyntaxtextarea.modes.JavaTokenMaker;

class TextArea {
  float taLeft, taTop, taWidth, taHeight, viewLeft, viewTop;
  List<String> lines;
  
  HashMap<Integer, Integer> tokenColors;
  color defaultColor = gray;
  
  PFont font;
  
  final float textOffset = 5.0; // pixels from the border
  
  TokenMaker tokenMaker;
  javax.swing.text.Segment segment;
  Token token;
  
  public TextArea(float taLeft, float taTop, float taWidth, float taHeight) {
    this.taLeft = taLeft;
    this.taTop = taTop;
    this.taWidth = taWidth;
    this.taHeight = taHeight;
    this.viewLeft = viewLeft;
    this.viewTop = viewTop;
    
    tokenColors = initTokenColors();

    font = loadFont("Consolas-64.vlw");
 
    tokenMaker = new JavaTokenMaker();
  }
  
  void setText(List<String> lines) {
    this.lines = lines;
  }
  
  
  color getColor(int tokenType) {
    return tokenColors.getOrDefault(tokenType, defaultColor);
  }
  
  float getViewLeft() { return viewLeft; }
  float getViewTop()  { return viewTop;  }
  
  
  void setViewLeft(float viewLeft) {
    this.viewLeft = viewLeft;
  }
  
  void setViewTop(float viewTop) {
    this.viewTop = viewTop;
  }
  
  void draw() {
    if (lines != null) {
      
      textFont(font);
      textSize(16);
      
      float lineX = taLeft;
      float lineY = taTop;
      float lineHeight = textAscent()+textDescent();
      
      for (int lineIndex = 0; lineIndex < lines.size(); lineIndex++) {
        String line = lines.get(lineIndex);
        javax.swing.text.Segment segment = new javax.swing.text.Segment(line.toCharArray(), 0, line.length());
        Token token = tokenMaker.getTokenList(segment, Token.NULL, 0);
        
        float x = taLeft+textOffset;
        float y = taTop+textOffset + lineIndex*lineHeight;
      
        while (token != null && token.isPaintable()) {
          color tokenColor = getColor(token.getType());
          String lexeme = token.getLexeme();
          
          fill(tokenColor);
          text(lexeme, x, y+textAscent());
          
          x += textWidth(lexeme);
          
          token = token.getNextToken(); 
        }
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
    tokenColors.put(22, purple2); // separator
    tokenColors.put(23, aqua2);   // operator
    tokenColors.put(35, red);     // error: identifier
    tokenColors.put(36, red);     // error: number format
    tokenColors.put(37, red);     // error: string
    tokenColors.put(38, red);
    
    return tokenColors;
  }
}
