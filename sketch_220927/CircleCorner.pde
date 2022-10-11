class CircleCorner extends AppBase {

int a = 0,i_cut = 2, a_cut = 2, col = 90, add_sp = 6;
int dis_s;
int i, x, y;
int coH, coS, coB;
float Po1, Cpo1;
int CC_xyz_SW = 1;
  
  CircleCorner(PApplet _parent) {
    super(_parent);
  }
  @Override void setup() {
    background(0);
    noFill();
    dis_s = height;//変えない
    Po1 = 3.5*width;//変えない
    
    
  }
  @Override void update() {
    coH = int(random(0, 300));
    coS = int(random(80, 100));
    coB = int(random(80, 100));
    
  }
  @Override void draw() {
    
    background(0);
    blendMode(BLEND);
    strokeWeight(CC_xyz_SW);
    parent.colorMode(HSB, coH, coS, coB);
    noFill();
    
    for (y = 0; y <= dis_s; y += dis_s) {
      for (x = 0; x <= dis_s; x += dis_s) {
        for (i = 0; i <= dis_s/5; i += 30) {
          stroke(col, 100 - i, 100 - i);
          circle(x, y, i + a);
          Cpo1 = Po1 - i/i_cut * a/a_cut;
          circle(x, y, Cpo1);
        }
      }
    }
    a+=add_sp;//広がる速度
    
    
    //テキスト関係
    fill(255);
    //ST_01.writeST(a);//運動時間（後で入れる値修正する）
    ST_02.writeST(XYZ[2]);//ウォーキング回数
    ST_03.writeST(XYZ[3]);//スクワット回数
    ST_04.writeST(XYZ[4]);//サイドプランク回数？
    ST_05.writeST(XYZ[5]);//ランジ回数
    
    
    if(i + a > Po1) {
      a = 0;
      x = 0;
      y = 0;
      i_cut = int(random(2, 5));
      a_cut = int(random(2, 7));
      add_sp = int(random(6, 15));
      col = int(random(0, 130));
      
      switch(int(XYZ[0])){
        case 2://ウォーキング
          CC_xyz_SW = int(map(XYZ[9], -350, 350, 0, 10));//gyroX
          break;
        case 3://スクワット
          CC_xyz_SW = int(map(XYZ[13], 30, 90, 0, 10));//roll
          break;
        case 4://サイドプランク
          CC_xyz_SW = int(map(XYZ[16], -20, 20, 0, 10));//y_angle
          break;
        case 5://ランジ
          CC_xyz_SW = int(map(XYZ[16], 30, 130, 0, 10));//y_angle
          break;
        default:
          CC_xyz_SW = int(random(1, 5));        
          break;
      }
    }
  }
}
