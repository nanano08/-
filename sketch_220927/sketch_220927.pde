//0906更新（最新）
import netP5.*;
import oscP5.*;

import java.util.List;
import java.util.LinkedList;
import java.util.Iterator;

// OSC関係
// OSCの初期化 (受信ポートは6700に設定する)
OscP5 osc = new OscP5(this, 6700);
float[] XYZ = new float[17];
int c_i = 0;

  
// スクリプト関係  
ArrayList<AppBase>apps;
int selected;


//色関係
int coH, coS, coB;


//テキスト関係
resultST ST_01, ST_02, ST_03, ST_04, ST_05;
resultST BSquare;
String u_msg1 = "Press s key to save this Result screen";//リザルト画面
int kyori = 15;


//画面切り替えトリガー
int ch_sec;



void setup() {
  size(700,700);
  background(0);
  colorMode(HSB,360,100,100);
  textSize(50);
  ch_sec =second();
  
  apps = new ArrayList<AppBase>();
  apps.add(new BlueSquare(this));
  apps.add(new CurveShapeS(this));
  apps.add(new RandomDots(this));
  apps.add(new CircleCorner(this));
  apps.add(new BallSlactRect(this));
  apps.add(new ResultScreen(this));
  
  for(AppBase app:apps){
    app.setup();
  }
  selected = 0;
  
  //テキスト関係
  //ST_01 = new resultST("ActiveTime : ", 0, 10, 15);
  ST_02 = new resultST("Walking     : ", 0, 10, 40-kyori);
  ST_03 = new resultST("Squat         : ", 0, 10, 60-kyori);
  ST_04 = new resultST("SidePlank : ", 0, 10, 80-kyori);
  ST_05 = new resultST("Lunge         : ", 0, 10, 100-kyori);
  
  
  BSquare = new resultST("Start Countdown  ", 0, width/3+2*kyori, height/2); //0927ADD
  
  
  
}
void draw() {
  apps.get(selected).update();
  apps.get(selected).draw();
  ch_sec =second();//もしかしたらvoid OSCに置いた方が良いかも？
  
}
void keyPressed(){
  if(key == '0'){
    selected = 0;
  }
  if(key == '1'){
    selected = 1;
  }
  if(key == '2'){
    selected = 2;
  }
  if(key == '3'){
    selected = 3;
  }
  if(key == '4'){
    selected = 4;
  }
  if(key == '5'){
    selected = 5;
  }
  
  //
    if(key == 's'){
    String py = str(year());
    String pm = str(month());
    String pd = str(day());
    String ph = str(hour());
    String Nichizi = py + pm + pd + ph;
    String pmin = str(minute());//0922ADD
    String prof=System.getenv("USERPROFILE"); 
    saveFrame(prof+"/Desktop/ActiveRecords/" + Nichizi + "####.png");//ActiveRecordsファイルはなければ自動で作成
    //CSV出力(0922ADD)
    String savefileCSV = prof+"/Desktop/ActiveRecords/"+ Nichizi + pmin +".csv";
    String S_xyz_4 = str(XYZ[4]);
    String[] SP_S_xyz_4 = split(S_xyz_4, ".");  
    String RecordWords = "DateAndTime" + "," + (py+"/"+pm+"/"+pd) + "," +
                         "Waiking" + "," + XYZ[2] + "," +
                         "Squat" + "," + XYZ[3] + "," +
                         "SidePlank" + "," + SP_S_xyz_4[0] + ":" + SP_S_xyz_4[1] + "," +
                         "Lunge" + "," + XYZ[5];
    String[] list = split(RecordWords, ',');
    saveStrings(savefileCSV, list);
    //exit();
    //完了したメッセージに切り替え(0922ADDここまで)
    u_msg1 = "Saved successfully!";
  }
  
}
// OSC関係
void oscEvent(OscMessage msg) {
  // アドレス /color に色を受信したら，それを背景に設定する
  if (msg.checkAddrPattern("/color")) {
    //下の代入を元に箱用意する
    //float core206 = msg.get(6).floatValue();
    
    //下の代入を元に箱用意する
    //XYZ[0] = core206;

    c_i = 0;
    while(c_i < 17) {
      XYZ[c_i] = msg.get(c_i).floatValue();
      c_i++;
    }
    //println(XYZ[4]);
    
    //映像切り替えスイッチ
    switch(int(XYZ[0])){
      case 0:
        selected = 0;
        u_msg1 = "Press s key to save this Result screen";//一応リセット
        break;
      case 100:
        selected = 5;
        break;
      default:
        //8秒ごとにランダムに映像切り替え
        if(ch_sec%10 == 0){
          int selected_num = int(random(1, 5));
          selected = selected_num;
        }
        break;
    }
  }
}

//テキスト関係
class resultST{
  
  PFont STD7;//配列を格納する変数を定義
  String item_text;
  float item_count;
  int textX, textY;
  int Resize;
  
  resultST(String item, float item_co, int poX, int poY){
    item_text = item;
    item_count = item_co;
    textX = poX;
    textY = poY;
    STD7 = createFont("x16y32pxGridGazer.ttf", 20);
  }
  
  void writeST(float counts){
    textFont(STD7);//text()で表示するフォントをD7という変数に格納されているフォントに変更
    textAlign(LEFT, CENTER);//text()で指定した座標を中心としたテキストボックスを作成
    text(item_text + counts, textX, textY);
  }
  
  void textResize(int textSize){
    Resize = textSize;
    textSize(Resize);
  }
  
  
}
