import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import org.fife.ui.rsyntaxtextarea.Token;
import org.fife.ui.rsyntaxtextarea.TokenMaker;
import org.fife.ui.rsyntaxtextarea.modes.JavaTokenMaker;


final float SCROLLBAR_WIDTH = 20;


float sidebarWidthRatio = 0.2;
float previewHeightRatio = 0.33;

float sidebarWidth;
float previewTop;

ScrollBar scrollBar2;

ScrollPane pageView;

void setup() {
  size(1440,900); // 1920 x 1080
  
  sidebarWidth = sidebarWidthRatio * width;
  previewTop = height - previewHeightRatio*height;
  
  // list view
  scrollBar2 = new ScrollBar(sidebarWidth-SCROLLBAR_WIDTH, 0, SCROLLBAR_WIDTH, previewTop);
  
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
  drawSidebar();

  // list view
  scrollBar2.draw();
  
  // page view
  pageView.draw();
}

void drawSidebar() {
  stroke(bg1);
 
  // sidebar border
  line(sidebarWidth, 0, sidebarWidth, height);
  
  // border between list and preview
  line(0, previewTop, sidebarWidth, previewTop);
}

//void drawList() {
//  // For testing
//  ArrayList<String> filenames = new ArrayList<>();
//  filenames.add("file1.cs");
//  filenames.add("file2.cs");
//  filenames.add("file3.cs");
//  filenames.add("file4.cs");
//  filenames.add("file5.cs");
//}

void mousePressed() {
  scrollBar2.handleMousePressed();
  
  // page view
  pageView.handleMousePressed();
}

void mouseReleased() {
  scrollBar2.handleMouseReleased();
  
  // page view
  pageView.handleMouseReleased();
}

void mouseDragged() {
  scrollBar2.handleMouseDragged();
  
  // page view
  pageView.handleMouseDragged();
}

void mouseMoved() {
  scrollBar2.handleMouseMoved();
  
  // page view
  pageView.handleMouseMoved();
}
