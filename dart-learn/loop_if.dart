import 'dart:math' as math;

void main(){
  // for 循环
  var message = StringBuffer('Dart is fun');
  for (var i = 0; i < 5; i++) {
    message.write('!');
  }
  print(message);

  // Dart 循环中的闭包捕获索引的值。 这避免了 JavaScript 中的常见陷阱  javascript会输出两个2
  var callbacks = [];
  for (var i = 0; i < 2; i++) {
    callbacks.add(() => print(i));
  }
  for (final c in callbacks) {
    c();
  }

  // while
  num n = 1;
  while(n < 5){
    print('while $n');
    n++;
  }

  // do whild
  num n2 = 1;
  do{
    print('do while $n2');
    n2++;
  }while(n2 < 5);

  // break 用于停止循环  continue 用于跳到下一个循环迭代
  for(num n3 = 0; n3 < 5; n3++){
    print('break $n3');
    break;
    continue;
    print('continue $n3');
  }


  // if - case  可以用来比较类型， 对单个模式进行结构
  const pair = 's';
  if(pair case (String s)){
    print('if case $pair $s');
  }

  // switch continue 回落
  switch (pair){
    case (String s) && (== pair.length):
      print('switch $s');
      continue newCase;

    newCase:
    case 'ss':
      print('new case $pair');
  }

  // switch 切换表达式
  var str = switch(pair){
    's' => 'true',
    == 's' && false => '$pair case1',
    _ => '$pair _'
  };
  print('str $str');


  // 详尽性检查 某个值可以进入开关，但与任何情况都不匹配
  bool? a = true;
  switch (a) {
    case true:
      print('yes');
    case false:
      print('no');
  }

  // switch class 匹配
  double calculateArea(Shape shape) => switch (shape) {
    Square(length: var l) => l * l,
    Circle(radius: var r) => math.pi * r * r,
    _ => 0
  };
  var shape = calculateArea(Zero());
  print(shape);

  var Square(length: aaa) = Square(2);
  var Square(length: bbb) = Square(3);
  print(aaa == bbb);

  // case when 语法
  if(Square(2) case Square(length: var ccc) when ccc == 2){
    print('Square(2) case Square when $ccc');
  }
  if(aaa.runtimeType case double when aaa == 2){
    print('aaa case double when $aaa');
  }
}

// sealed：密封， 只允许在同一个文件中被继承
sealed class Shape {}

class Square implements Shape {
  final double length;
  Square(this.length);
}

class Circle implements Shape {
  final double radius;
  Circle(this.radius);
}

class Zero implements Shape {
  Zero();
}