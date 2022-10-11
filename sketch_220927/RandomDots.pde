class RandomDots extends AppBase {
  
List<Circle> cirList = new LinkedList<Circle>();
color[] dotsCol_0 = {#000922, #00326A, #FCC92C, #F6E800, #C6AAD0, #915DA3, #C1E1DC, #008ACE, #E25371};
color[] dotsCol_1 = {#D93245, #DFA765, #382919, #3A3B66, #743E5D, #EB613B, #006984, #F2DCD3, #D99033};
color[] dotsCol_2 = {#FFEA60, #F0AD24, #F08330, #EA5541, #EB668B, #F19DAE, #ABC555, #FAF3DC, #C39155};
color[] dotsCol_3 = {#FEDE7F, #EB668B, #F9C385, #F29B8F, #B1D36A, #B04E84, #D2E281, #93417B, #F7E160};
color[] dotsCol_4 = {#BEE0C8, #00AFCC, #4457A5, #0090A9, #006F9A, #AFD6E3, #3E807F, #7CB0AD, #004D84};
color[] dotsCol_5 = {#E8D3D3, #B93F76, #E67155, #ECC0A2, #DF899E, #F08B5F, #BE6D54, #DDB589, #F7EDF4};
color[] dotsCol_6 = {#FBCA4D, #E7B148, #F6EFC2, #F0DF75, #FAC98D, #FAF7EB, #ECD339, #F2934E, #D4B386};
color[] dotsCol_7 = {#9F8DC6, #614D9D, #6F5D76, #E9D8CA, #CBAEB6, #B6C067, #9C76AB, #DFC0DB, #D2C7E0};
color[] dotsCol_8 = {#9B3B65, #E75685, #DF8D98, #B35564, #F5D3D6, #A78D9E, #D0A7BF, #FF9F8A, #6A463F};

color[][] arrayCols = new color[][]{dotsCol_0, dotsCol_1, dotsCol_2, dotsCol_3, 
                                    dotsCol_4, dotsCol_5, dotsCol_6, dotsCol_7, dotsCol_8};

int num_dotCol, sec_co, select_num = 0, arrayLen, RD_xyz_400;//0927ADD

  
  RandomDots(PApplet _parent) {
    super(_parent);
  }
  @Override void setup() {
    blendMode(BLEND);
    parent.background(0);
    
    noStroke();
    arrayLen = arrayCols.length;
    

  }
  @Override void update() {
    
    
  }
  @Override void draw() {
    sec_co = second();
    noStroke();
    blendMode(BLEND);
    coH = int(random(100, 200));
    //coS = int(random(0, 100));
    //coB = int(random(0, 100));
    num_dotCol = int(random(9));
    //colorMode(HSB, coH, coS, coB);
    
    RD_xyz_400 = int(XYZ[4]*100);//0927ADDプランク時間調整
    
    if(int(XYZ[2] + XYZ[3] + RD_xyz_400 + XYZ[5])%4 == 0){ //0927ADD
      //運動回数がカラーセット変更トリガー
      //if(sec_co%7 == 0){
       select_num = int(random(arrayLen));
    }
    
    if(Math.random() < 0.75) {
        cirList.add(new Circle(random(width), random(height), 0, color(arrayCols[select_num][num_dotCol])));
    }
    updateCircles();
    drawCircles();
    fade();
    
    //表示
    fill(255);
    //テキスト関係
    
    //ST_01.writeST(sec_co);//運動時間（後で入れる値修正する）
    ST_02.writeST(XYZ[2]);//ウォーキング回数
    ST_03.writeST(XYZ[3]);//スクワット回数
    ST_04.writeST(XYZ[4]);//サイドプランク回数？
    ST_05.writeST(XYZ[5]);//ランジ回数
    
    
    
    
    
  }
  
  void updateCircles() {
    float vRadius = 3.0; //半径変化量
    float mS = int(random(5, 500));
    float maxSize = mS; //最大半径
    Iterator<Circle> iter = cirList.iterator();
    while(iter.hasNext())
    {
        Circle cir = iter.next();
        cir.setRadius(cir.getRadius() + vRadius);
        if(cir.getRadius() > maxSize )
        {
            iter.remove();
        }
    }
  }

  void drawCircles() {
    for(Circle cir : cirList)
    {
      cir.draw();
    }
  }

  void fade() {
      fill(0, 0, 0, 15);
      rect(0, 0, 2*width, 2*height);//ここ大事
  }

  class Circle {    
      private float x, y, r;
      private color c;
      
      public Circle(float x, float y, float r, color c) {
          this.x = x;
          this.y = y;
          this.c = c;
          this.r = r;
      }
      
      public void setRadius(float r) {
          this.r = r;
      }
      
      public float getRadius() {
          return r;
      }
   
      public void draw() {
          colorMode(HSB, 300, 100, 100);
          fill(c, 99);
          ellipse(x+random(-1, 1), y+random(-1, 1), r, r);
      }
    }
}
