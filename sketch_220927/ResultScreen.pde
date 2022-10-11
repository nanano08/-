class ResultScreen extends AppBase {
  
int tileCount = 50;
int actRandomSeed = 0;
float maxDist;
color[] baseCol = {#000922, #00326A, #FCC92C, #F6E800, #C6AAD0, #915DA3, #C1E1DC, #008ACE, #E25371};
int dec_num, dec_num_bg;

String pY = str(year());
String pM = str(month());
String pD = str(day());

//表示
PFont RED7;//配列を格納する変数を定義
float tc_01;//debug
int re_poX, re_poY;
//String u_msg1 = "Press s key to save this Result screen";
int rech = 2*kyori;

  
  ResultScreen(PApplet _parent) {
    super(_parent);
  }
  @Override void setup() {
    
    strokeCap(PROJECT);
    maxDist = sqrt(sq(width)+sq(height));
    dec_num = int(random(9));
    dec_num_bg = int(random(9));
    
    
    //表示
    RED7 = createFont("x16y32pxGridGazer.ttf", 60);//変数にttfの60pのサイズのフォントを格納
    re_poX = width/2;
    re_poY = height/4;
    

  }
  @Override void update() {
    
  }
  @Override void draw() {
    blendMode(BLEND);
    strokeCap(PROJECT);
    background(baseCol[dec_num_bg]);
    randomSeed(actRandomSeed);
    drawGrid(baseCol[dec_num]);
  
    fill(#EFEFEF);
    rect(width/2, height/2, width/1.5, height/1.5);
    tc_01 = 25;//debug

    
    //表示
    textFont(RED7);//text()で表示するフォントをD7という変数に格納されているフォントに変更
    textAlign(CENTER, CENTER);//text()で指定した座標を中心としたテキストボックスを作成
    
    fill(#363D49);
    text("Result", re_poX, re_poY);
    textSize(30);
    text(pY+"/"+pM+"/"+pD, re_poX, re_poY+50);
    textSize(40);
    //text("Total ActiveTime : "+tc_01, re_poX, re_poY+85);
    text("Walking     : "+XYZ[2], re_poX, re_poY+145-rech);
    text("Squat         : "+XYZ[3], re_poX, re_poY+205-rech);
    
    String R_xyz_4 = str(XYZ[4]);
    String[] SP_R_xyz_4 = split(R_xyz_4, ".");  
    
    text("SidePlank : "+SP_R_xyz_4[0] + ":" + SP_R_xyz_4[1], re_poX, re_poY+265-rech);
    text("Lunge         : "+XYZ[5], re_poX, re_poY+325-rech);
    
    textSize(20);
    text(u_msg1, re_poX, re_poY+380);

  }
  //koko
  void drawGrid(color stCol) {
    for (int gridY = 0; gridY< tileCount; gridY++) {
      for (int gridX = 0; gridX< tileCount; gridX++) {
        int posX = width/tileCount* gridX;
        int posY = height/tileCount* gridY;
        int toggle = (int)random(0, 2);
        //float w = map(dist(mouseX, mouseY, posX, posY), 0, maxDist, 0, 20);
        //float b = map(dist(mouseX, mouseY, posX, posY), 0, maxDist, 100, 0);
        color strokeCol = color(stCol);
        
        if (toggle == 0) {
          stroke(strokeCol);
          strokeWeight(3);
          line(posX, posY, posX+width/tileCount, posY+height/tileCount);
        }
        if (toggle == 1) {
          stroke(strokeCol);
          strokeWeight(3);
          line(posX, posY+width/tileCount, posX+height/tileCount, posY);
        }
      }
    }
  }
  
  //void keyPressed(){
  //  if(key == 's'){
  //    String py = str(year());
  //    String pm = str(month());
  //    String pd = str(day());
  //    String ph = str(hour());
  //    String Nichizi = py + pm + pd + ph;
      
  //    String prof=System.getenv("USERPROFILE"); 
  //    saveFrame(prof+"/Desktop/ActiveRecords/" + Nichizi + "####.png");//ActiveRecordsファイルはなければ自動で作成
  //    u_msg1 = "Saved successfully!";
  //  }
  //}
  
  void keyReleased(){
    if(key == 's')redraw();
  }
}
