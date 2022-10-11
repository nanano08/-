class BallSlactRect extends AppBase {

ArrayList<Ball> balls;
int ballWidth = 80;
int coH, coS, coB, co_sec, BSR_xyz_400;
float half_w, half_h, mk_X, mk_Y;
sla_Rect rect1, rect2, rect3, rect4;

  
  BallSlactRect(PApplet _parent) {
    super(_parent);
  }
  @Override void setup() {
    half_w = width/2;
    half_h = height/2;
    co_sec = 0;
    parent.noStroke();
    parent.colorMode(HSB, 360, 100, 100);
    rect1 = new sla_Rect(0, 4, width/2, height/2, 80, 6);
    rect2 = new sla_Rect(0, 5, width/3, height/3, 120, 3);
    rect3 = new sla_Rect(0, 6, 2*width/3, 2*height/2, 50, 6);
    rect4 = new sla_Rect(0, 7, 2*width/2, 2*height/3, 150, 2);
    
    // Create an empty ArrayList (will store Ball objects)
    balls = new ArrayList<Ball>();
    
    // Start by adding one element
    balls.add(new Ball(width/2, 0, ballWidth));
    
    
    
  }
  @Override void update() {
    coH = int(random(0, 300));
    coS = int(random(0, 100));
    coB = int(random(0, 100));
  }
  @Override void draw() {
    
    parent.background(0);
    parent.noStroke();
    blendMode(ADD);
    parent.colorMode(HSB, coH, coS, coB);
    

    //テキスト関係
    fill(#EFEFEF);
    //ST_01.writeST(co_sec);//運動時間（後で入れる値修正する）
    ST_02.writeST(XYZ[2]);//ウォーキング回数
    ST_03.writeST(XYZ[3]);//スクワット回数
    ST_04.writeST(XYZ[4]);//サイドプランク回数？
    ST_05.writeST(XYZ[5]);//ランジ回数
    
    
    switch(co_sec){
      case 100:
        co_sec = 0;
        //mk_X = random(-300, 300);
        //mk_Y = random(-500, 50);
        //ballWidth = int(random(10, 100));
        //balls.add(new Ball(half_w + mk_X, half_h + mk_Y, ballWidth));
        
        switch(int(XYZ[0])){
          case 2://ウォーキング
            mk_X = random(-300, 300);
            mk_Y = random(-500, 50);
            ballWidth = int(map(XYZ[9], -350, 350, 10, 200));//gyroX
            balls.add(new Ball(half_w + mk_X, half_h + mk_Y, ballWidth));
            break;
          case 3://スクワット
            mk_X = random(-300, 300);
            mk_Y = random(-500, 50);
            ballWidth = int(map(XYZ[13], 30, 90, 10, 200));//roll
            balls.add(new Ball(half_w + mk_X, half_h + mk_Y, ballWidth));
            break;
          case 4://サイドプランク
            mk_X = map(XYZ[16], -20, 20, -300, 300);//y_angle
            mk_Y = random(-500, 50);
            ballWidth = int(random(10, 200));
            balls.add(new Ball(half_w + mk_X, half_h + mk_Y, ballWidth));
            break;
          case 5://ランジ
            mk_X = random(-300, 300);
            mk_Y = map(XYZ[16], 30, 130,-500, 50);//y_angle
            ballWidth = int(random(10, 200));
            balls.add(new Ball(half_w + mk_X, half_h + mk_Y, ballWidth));
            break;
          default:
            mk_X = random(-300, 300);
            mk_Y = random(-500, 50);
            ballWidth = int(random(10, 100));
            balls.add(new Ball(half_w + mk_X, half_h + mk_Y, ballWidth));
            break;
        }
        
        break;
      default:
        co_sec++;
        break;
    }
    
    BSR_xyz_400 = int(XYZ[4]*100);//0927ADDプランク時間調整
    
    if(int(XYZ[2])%2 == 1 || int(XYZ[3])%2 == 1 || BSR_xyz_400%2 == 1 || int(XYZ[5])%2 == 1){ //運動回数によりボール生成
      mk_X = random(-300, 300);
      mk_Y = random(-500, 50);
      ballWidth = int(random(10, 100));
      balls.add(new Ball(half_w + mk_X, half_h + mk_Y, ballWidth));
    }
    
    
    for (int i = balls.size()-1; i >= 0; i--) { 
      
      // An ArrayList doesn't know what it is storing so we have to cast the object coming out
      Ball ball = balls.get(i);
      ball.move();
      ball.display();
      if (ball.finished()) {
        // Items can be deleted with remove()
        balls.remove(i);
      }
    }
  
    rect1.display();
    rect2.display();
    rect3.display();
    rect4.display();
    
    
    rect1.Reset(rect1.rx, rect1.ry);
    rect2.Reset(rect2.rx, rect2.ry);
    rect3.Reset(rect3.rx, rect3.ry);
    rect4.Reset(rect4.rx, rect4.ry);
    

  }
  
  
  //void mousePressed() {
    // A new ball object is added to the ArrayList (by default to the end)
  //  ballWidth = int(random(10, 80));
    //ballVec = PVector.random2D();
  //  balls.add(new Ball(mouseX, mouseY, ballWidth));
    //balls.add(new Ball(ballVec.x, ballVec.y, ballWidth));
  //}
  
  
}


// Simple bouncing ball class

class Ball {
  
  float x;
  float y;
  float speed;
  float gravity;
  float w;
  float life = 255;
  
  Ball(float tempX, float tempY, float tempW) {
    x = tempX;
    y = tempY;
    w = tempW;
    speed = 0;
    gravity = 0.1;
  }
  
    void move() {
    // Add gravity to speed
    speed = speed + gravity;
    // Add speed to y location
    y = y + speed;
    // If square reaches the bottom
    // Reverse speed
    if (y > height) {
      // Dampening
      speed = speed * -0.8;
      y = height;
    }
  }
  
  boolean finished() {
    // Balls fade out
    life--;
    if (life < 0) {
      return true;
    } else {
      return false;
    }
  }
  
  void display() {
    // Display the circle
    fill(100, 200, 50,life);
    //stroke(0,life);
    ellipse(x,y,w,w);
  }
}  

// Slact Rect class
class sla_Rect {
  
  int rx, ry, rw, rh, sp, sp_num;
  
  
  sla_Rect(int rec_sp, int sp_add, int rec_x, int rec_y, int rec_w, int rec_h){
    sp = rec_sp;
    sp_num = sp_add;
    rx = rec_x;
    ry = rec_y;
    rw = rec_w;
    rh = rec_h;
  }
  
  void display() {
    rx = 10 + sp;
    
    pushMatrix();
    rotate(PI/5.0);
    fill(100, 200, 50, 95);
    rect(rx, ry, rw, rh);
    popMatrix();
    
    sp = sp + sp_num;
    
  }
  
  void Reset (int end_x, int end_y) {
    if(end_x > width + 150 || end_y > height) {
      sp = 0;
      rw = int(random(60, 600));
      rh = int(random(2, 10));
      rx = int(random(-height, height));
      ry = int(random(-width/2, width/2));
      
    }
  }
}
