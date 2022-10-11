class CurveShapeS extends AppBase {
  
ArrayList<Form>form = new ArrayList<Form>();

int tran, xyz_400;

int[] colors_0 = {#eac435, #345995, #03cea4, #fb4d3d, #ca1551};
int[] colors_1 = {#0068B7, #924992, #00AEC4, #F8B616, #E4007F};
int[] colors_2 = {#53B98D, #E95386, #FDD121, #F18F4D, #C37BB1};
int[] colors_3 = {#26499D, #CE0080, #75236F, #E6CE56, #E9E6F3};
int[] colors_4 = {#D93245, #3A3B66, #743E5D, #EB613B, #006984};

color[][] arrayCols5 = new color[][]{colors_0, colors_1, colors_2, colors_3, colors_4};
color[] selectCol5 = colors_0;
  
  CurveShapeS(PApplet _parent) {
    super(_parent);
  }
  @Override void setup() {
    //colorMode(HSB, 360, 100, 100, 100);
    parent.background(0);
    rectMode(CENTER);
    newForm();
    tran = second();
    

  }
  @Override void update() {
    
  }
  
  @Override void draw() {
    tran = second();
    
    background(0);
    
    //camera(width*0.5, height*1.1, width*0.6, width*0.5, height*0.7, 0, 0, 1, 0);
    
    for (int i=0; i<form.size(); i++) {
       Form f = form.get(i);
       f.run();
    }
    
    
    //テキスト関係
    //ST_01.writeST(tran);//運動時間（後で入れる値修正する）
    ST_02.writeST(XYZ[2]);//ウォーキング回数
    ST_03.writeST(XYZ[3]);//スクワット回数
    ST_04.writeST(XYZ[4]);//サイドプランク回数？
    ST_05.writeST(XYZ[5]);//ランジ回数
    
    xyz_400 = int(XYZ[4]*100);//0927ADDプランク時間調整
    
    //if(int(XYZ[2])%10 == 0 || int(XYZ[3])%5 == 0 || xyz_400%10 == 0 || int(XYZ[5])%5 == 0){ //運動回数によりリセット
    if(tran%10 == 0){
      newForm();
      selectCol5 = arrayCols5[int(random(arrayCols5.length))];
          }
          //0927ADD
    /*
    switch(int(XYZ[0])){
        case 2://ウォーキング
          if(int(XYZ[2])%10 == 0){
             newForm();
             selectCol5 = arrayCols5[int(random(arrayCols5.length))];
          }
          break;
        case 3://スクワット
          if(int(XYZ[3])%4 == 0){
             newForm();
             selectCol5 = arrayCols5[int(random(arrayCols5.length))];
          }
          break;
        case 4://サイドプランク
          if(tran == 2 || tran == 17|| tran == 36 || tran == 50){
             newForm();
             selectCol5 = arrayCols5[int(random(arrayCols5.length))];
          }
          break;
        case 5://ランジ
          if(int(XYZ[5])%3 == 0){
             newForm();
             selectCol5 = arrayCols5[int(random(arrayCols5.length))];
          }
          break;
        default:
          if(tran == 2 || tran == 29 || tran == 47){
             newForm();
             selectCol5 = arrayCols5[int(random(arrayCols5.length))];
          }
          break;
      }
       */
  }
 
  
  void newForm() {
 form = new ArrayList<Form>();
 int c = 8;
 float w = width/c;
 

 noFill();
 stroke(0);

 for (int j=0; j<c; j++) {
   for (int i=0; i<c; i++) {
     form.add(new Form(i*w+w/2, j*w+w/2, w));
   }
 }
 
}

void mousePressed() {
 newForm();
}


int getCol() {
 return selectCol5[(int)random(selectCol5.length)];
}

class Form {
 float x, y, s;
 float ss, sss;
 float hs;
 float z=0;
 float angle=0;
 int t, t1, t2, t3, t4, t5, t6, t7;
 float step;
 color col;
 float p;
 float rectS;
 
 //add
 float raX, raY;
 
 Form(float x, float y, float s) {
   this.x = x;
   this.y = y;
   this.s = s;

   hs = s/2;
   step = 1;
   t = -(int)random(2500);
   t1 = 0+50;
   t2 = t1+50;
   t3 = t2+10;
   t4 = t3+80;
   t5 = t4+80;
   t6 = t5+60;
   t7 = t6+50;
   col = getCol();
   p = random(1);
   
   raX = random(2, 4);
   raY = random(1.5, 4);
   
   
 }

 void show() {
   blendMode(ADD);
   noFill();
   stroke(col);
   push();
   translate(x, y);
   rotate(angle);
   if (p < 0.1)circle(0, 0, ss);
   else square(0, 0, ss);
   

   noStroke();
   fill(col);
   //translate(0, 0, z);
   translate(x/raX, 0);
   if (p < 0.1) circle(0, 0, sss);//ch
   else square(0, 0, sss*2);//ch

   fill(col);
   noStroke();
   translate(raX, y/raY);
   if (p < 0.1) circle(0, 0, rectS*raX/2);
   else square(0, 0, rectS*raY/2);
   pop();
 }

 void move() {
   if (t > 0) {
     if (t < t1) {
       float mp = map(t, 0, t1-1, 0, 1);
       ss = lerp(0, s, sqrt(mp));
     } else if (t < t2) {
       float mp = map(t, t1, t2-1, 0, 1);
       z = lerp(s*4, -s*0.2, sq(sq(mp)));
       sss = lerp(0, s*0.25, sqrt(mp));
     } else if (t < t3) {
       float mp = map(t, t2, t3-1, 0, 1);
       z = lerp(-s*0.2, 0, sqrt(mp));
     } else if (t < t4) {
       float mp = map(t, t3, t4-1, 0, 1);
       angle = lerp(0, TAU, sq(mp));
       sss = lerp(s*0.25, s*0.5, sq(mp));
     } else if (t < t5) {
       float mp = map(t, t4, t5-1, 0, 1);
       angle = lerp(TAU, TAU*2, mp-sq(mp));
       ss = 0;
     } else if (t < t6) {
       float mp = map(t, t5, t6-1, 0, 1);
       angle = lerp(PI, 0, mp);
       sss = lerp(s*0.5, 0, mp);
       z = lerp(0, -s/2, mp);
     } else if (t < t7) {
       float mp = map(t, t6, t7-1, 0, 1);
       rectS = lerp(0, s-1, sq(mp));
       angle = lerp(PI, 0, sq(mp));
     }
   }
   t += step;
 }

 void run() {
   show();
   move();
 }
}
  
  
  
  
  
}
