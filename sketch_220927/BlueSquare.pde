class BlueSquare extends AppBase {
  PVector pos;
  PVector vel;

  
  BlueSquare(PApplet _parent) {
    super(_parent);
  }
  @Override void setup() {
    pos = new PVector(parent.width/2, parent.height/2, 0);
    vel = PVector.random2D().mult(4);
    
    parent.colorMode(HSB, 360, 100, 100);
    parent.rectMode(CENTER);
    
    
  }
  @Override void update() {
    pos.add(vel);
    if(pos.x < 0 || pos.x > width){
      vel.x *= -1;
    }
    if(pos.y < 0 || pos.y > height){
      vel.y *= -1;
    }
    
    coH = int(random(0, 300));
    coS = int(random(0, 100));
    coB = int(random(0, 100));
  }
  @Override void draw() {
    
    blendMode(BLEND);
    parent.colorMode(HSB, coH, coS, coB);
    background(0);
    parent.noStroke();
    
    fill(10, 80, 100);//0927ADD
    //テキスト関係
    //ST_01.writeST(pos.x);//運動時間（後で入れる値修正する）
    ST_02.writeST(XYZ[2]);//ウォーキング回数
    ST_03.writeST(XYZ[3]);//スクワット回数
    ST_04.writeST(XYZ[4]);//サイドプランク回数？
    ST_05.writeST(XYZ[5]);//ランジ回数
    
    BSquare.writeST(XYZ[1]);
    
    rect(pos.x, pos.y, 50, 50);
    
  }
}
