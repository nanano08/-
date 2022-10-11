// 抽象クラスAppBase
// 個別のスケッチを実行するクラスの設計図となる
abstract class AppBase {
  protected PApplet parent;
  public AppBase(PApplet _parent) {
    parent = _parent;
  }
  public void setup() {
    //抽象クラスなので何も書かない
  }
  public void update() {
    //抽象クラスなので何も書かない
  }
  public void draw() {
    //抽象クラスなので何も書かない
  }
}
