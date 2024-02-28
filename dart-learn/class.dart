// base 关键字表示只能在当前文件使用
base class Point{
  final num x;  // final 修饰符表示常量，变量无法被修改
  final num y;
  late final String _address; // _ 私有变量，late 关键字表示可以之后赋值。在late修饰的参数使用之前需要赋值
  late final num x_more;

  // 静态变量以最后一次赋值为准
  static String name = 'zhangsan'; // 静态变量在使用之前不会初始化，静态变量可以用const修饰

  Point(this.x, this.y);

  // 常量构造函数
  // const Point(this.x, this.y); // const 修饰构造只能在属性全为 final 时使用，创建实例时相同参数的实例为同一个实例

  // 命名构造函数
  // Point.p(this.x, this.y, this._address);
  Point.p(Map data):x = data['x'], y = data['y']{
    _address = '$x $y';
  }

  // 重定向构造函数
  Point.r(num x):this(x, x+2);

  // 工厂构造函数，普通的构造无法返回值，工厂函数可以指定需要返回的东西
  factory Point.f(){
    Point p = Point(1,2);
    p._address = '${p.x}_${p.y}';
    return p;
  }

  // 静态方法
  static Point fromJson(Map<String, num> map){
    return Point(map['x']!, map['y']!);
  }

  // 操作符
  num operator +(num n) => x + n + 1;

  // getter 和 setter
  num get add_n => x + x_more;

  set add_n(num more) => x_more = more;
}

// exntends 与 implements 区别：implements不会调用父类构造方法
class Person{
  String? name;

  Person({this.name});

  String greet(String who) => 'Hello, $who. I am $name.';

  Person.fromJson(this.name){
    print('person $name');
  }
}

// 命名构造函数
class Student extends Person{
  Student({super.name});

  Student.fromJson(String name):super.fromJson(name){
    print('student $name');
  }

  @override
  String greet(String who) {
    print(super.greet(who));
    return '$name, $who in children.';
  }
}

// 抽象方法
abstract class Action{
  void set field(String f);

  String get field;

  String start();
}

class Impostor implements Person, Action{
  @override
  String? name;

  @override
  String field;

  Impostor(this.name, this.field);

  @override
  String greet(String who) => 'Hi $who. Do you know who I am? _ $name _';

  @override
  String start() {
    return '$name run in $field';
  }
}

// mixin
mixin Animal on Action{
  String? name;
  num? age;
  String? color;

  String message() => '$name is $color and it is $age years old';
}

class Tiger extends Action with Animal{
  @override
  String field;

  Tiger(this.field, n, a, c){
    name = n;
    age = a;
    color = c;
  }

  @override
  String start() {
    return '$name start run in $field';
  }
}

void fun_class(){
  Point.name = 'lisi class';
  print('fun ${Point.name}');
}

// enum
enum Color {
  red, blue, yellow,
  light(name: 'white');

  const Color({this.name});

  final String? name;

  String get _name {
    if(this.name == null){
      List s = this.toString().split('.');
      return s[1];
    }else {
      return this.name!;
    }
  }
}

// extension 扩展方法
extension EnumName on Color {
  String? getName(){
    return this.name;
  }
}
// 扩展泛型
extension TigerCry<T> on Tiger{
  cry<T>(T args){
    print('$args ${this.name} ao ao ao');
  }
}

// 可调用实例，实现 class 的 call 方法
class Fun {
  final String name;
  Fun(this.name);

  String call(num age){
    return '$name _ $age';
  }
}

// abstract 抽象类，无法创建实例，可以有抽象方法
// base 被修饰的class无法被外部访问
// interface 接口，里面的属性与方法必须都是抽象方法
// final 禁止继承与实现
// sealed 创建封闭类，封闭类只能在同一个库文件中被继承，封闭类是隐式抽象的，无法创建实例
main(){
  // const 使用
  // Point p1 = const Point(2,2);
  // Point p2 = const Point(2,2);
  // print(p1 == p2);
  // assert(identical(p1, p2));

  // 以下两种使用方式相同
  Point p3 = Point.fromJson({'x':4, 'y':4});
  p3._address = '湖南';

  // 静态变量
  print('outside ${Point.name}');
  void fun(){
    Point.name = 'lisi';
    print('fun ${Point.name}');
  }
  fun();
  void fun02(){
    print('fun02 ${Point.name}');
  }
  fun02();

  Point p4 = Point(6,6)
  .._address = '湖南';
  print(p4._address);

  // 解构 class
  var Point(:x) = Point(6,6);
  print('x $x');

  // 多继承
  Impostor im = Impostor('zhangsan', 'farm');
  print(im.start());

  // 命名构造函数
  Point p5 = Point.p({'x':5,'y':6});
  print(p5._address);

  // 工厂构造函数
  Point p6 = Point.f();
  print(p6._address);

  Student.fromJson('zhangsan');

  // 运算符
  Point p7 = Point(5,2);
  print('${p7 + 1} ${p7.x + 5}'); // p7.x + 1

  // getter setter
  p7.add_n = 5;
  print(p7.add_n);

  // extends
  Student s = Student(name: 'zhangsan');
  print(s.name);
  print(s.greet('lisi'));

  // mixin
  Tiger tiger = Tiger('farm', 'titi', 12, 'yellow');
  print(tiger.start());
  print(tiger.message());

  // enum
  print(Color.light._name); // white

  // extension
  print(Color.light.getName()); // white
  tiger.cry<num>(9);

  // 可调用class
  Fun f = Fun('zhangsan');
  print(f(20));
}