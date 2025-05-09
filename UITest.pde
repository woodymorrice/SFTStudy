import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import org.fife.ui.rsyntaxtextarea.Token;
import org.fife.ui.rsyntaxtextarea.TokenMaker;
import org.fife.ui.rsyntaxtextarea.modes.JavaTokenMaker;

final float SCROLLBAR_SIZE = 20; // width for vertical, height for horizontal

float sidebarWidthRatio = 0.2;
float previewHeightRatio = 0.33;

float sidebarWidth;
float previewTop;

ScrollBar scrollBar2;

ScrollPane pageView;


// Globals
float gTextWidth = 0;
float gTextHeight = 0;


void setup() {
  size(1440,900); // 1920 x 1080
  
  sidebarWidth = sidebarWidthRatio * width;
  previewTop = height - previewHeightRatio*height;
  
  // list view
  //scrollBar2 = new ScrollBar(null, sidebarWidth-SCROLLBAR_SIZE, 0, SCROLLBAR_SIZE, previewTop);
  
  // page view
  pageView = new ScrollPane(sidebarWidth+1, 0, width-(sidebarWidth+1), height);
  
  try {
    List<String> lines = Files.readAllLines(Paths.get(dataPath("BiomeManager.java")));
    pageView.setText(lines);
  }
  catch (Exception e) {
    print(e);
  }
  
  
}

void draw() {
  background(bg);
  
  pageView.draw();
  drawSidebar();

  
}

void drawSidebar() {
  fill(bg);
  rect(0, 0, sidebarWidth, height);
  
  stroke(bg1);
 
  // sidebar border
  line(sidebarWidth, 0, sidebarWidth, height);
  
  // border between list and preview
  line(0, previewTop, sidebarWidth, previewTop);
}

void mousePressed() {
  //scrollBar2.handleMousePressed();
  
  // page view
  pageView.handleMousePressed();
}

void mouseReleased() {
  //scrollBar2.handleMouseReleased();
  
  // page view
  pageView.handleMouseReleased();
}

void mouseDragged() {
  //scrollBar2.handleMouseDragged();
  
  // page view
  pageView.handleMouseDragged();
}

void mouseMoved() {
  //scrollBar2.handleMouseMoved();
  
  // page view
  pageView.handleMouseMoved();
}
