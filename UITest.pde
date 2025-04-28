float sidebarWidthRatio = 0.2;
float previewHeightRatio = 0.33;

float sidebarWidth;
float previewTop;

ScrollBar scrollBar1;
ScrollBar scrollBar2;

void setup() {
  size(1440,900); // 1920 x 1080
  
  sidebarWidth = sidebarWidthRatio * width;
  previewTop = height - previewHeightRatio*height;
  
  float sb1Width = 20;
  scrollBar1 = new ScrollBar(width-sb1Width, 0, sb1Width, height);
  float sb2Width = 20;
  scrollBar2 = new ScrollBar(sidebarWidth-sb2Width, 0, sb2Width, previewTop);
}

void draw() {
  background(bg);
  drawSidebar();
  
  scrollBar1.draw();
  scrollBar2.draw();
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
  scrollBar1.handleMousePressed();
  scrollBar2.handleMousePressed();
}

void mouseReleased() {
  scrollBar1.handleMouseReleased();
  scrollBar2.handleMouseReleased();
}

//void mouseDragged() {
//  scrollBar1.handleMouseDragged();
//  scrollBar2.handleMouseDragged();
//}

void mouseMoved() {
  scrollBar1.handleMouseMoved();
  scrollBar2.handleMouseMoved();
}
