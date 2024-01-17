import 'dart:ffi';

import './cat.dart';
import './cat.dart' as animal hide Dog;

// late: 通常 Dart 的语义分析可以检测非空变量在使用之前是否被赋值, 如果你确定变量在使用之前已设置，但 Dart 推断错误的话，可以将变量标记为 late 来解决这个问题
late String l;

main(){
  // string 在 Dart 中通过调用就对象的 toStri ng() 方法来得到对象相应的字符串。
  String b = '1.222';
  String b1 = '价格是：$b'; //字符串可以通过 ${expression} 的方式内嵌表达式。 如果表达式是一个标识符，则 {} 可以省略
  String b2 = '''
    价格就是：
    $b
    你猜对了吗！
  '''; // 使用连续三个单引号或者三个双引号实现多行字符串对象的创建
  String b3 = r'张三 \n 你是不是？ \u03B1'; // 使用 r 前缀，可以创建 “原始 raw” 字符串

  // num 整数值不大于64位（具体取决于平台）,在 Dart VM 上， 值的范围从 -263 到 263 - 1.
  // 从 Dart 2.1 开始，必要的时候 int 字面量会自动转换成 double 类型
  num a = 1.22;
  int a1 = 1;
  double a2 = 1; // 相当于 double z = 1.0.
  num bNum = num.parse(b); // 将字符串转换为数字

  // boolean
  bool c = false;

  // set
  Set set = <int>{1,2,3};
  Iterator iter = set.iterator;  // 迭代器
  print(iter.moveNext());
  print(iter.current);

  // const（编译时常量） final（运行时常量） 常量，区别：const 变量不能在运行时更改
  final int f = set.first;
  const int c1 = 1;
  const int c2 = 2;
  const c3 = c1 * c2; // 数字类型字面量是编译时常量。 在算术表达式中，只要参与计算的因子是编译时常量， 那么算术表达式的结果也是编译时常量。（可以赋值给const变量）

  // late 关键字
  l = '1';
  late String l1 = set.last.toString(); // 如果l1从未被使用，则set.last.toString()永远不会被调用

  // 类型检查和转换 集合中的 if 和 展开操作符（... 和 ...?）
  const Object iMy = 3; // Where i is a const Object with an int value...
  const listMy = [iMy as int]; // Use a typecast.
  const mapMy = {if (iMy is int) iMy: 'int'}; // Use is and collection if.
  var setMy = {if (listMy is List<int>) ...listMy}; // ...and a spread.
  setMy.add(3);
  List<int> listMy1 = [...setMy];

  // var 类型推断
  var mapMy1 = {mapMy.isEmpty ? {1:1,2:2,3:3}: {4:4}};
  // list 可迭代集合
  var listWhere = listMy.where((element) => element > 0);

  print(mapMy1);

  // class中属性添加 _ 表示私有属性，在不同文件下无法访问
  Cat cat = Cat('kiki', 2);
  cat.birthday = DateTime.now();
  // cat._birthday   // error
  print(cat.age);

  // dynamic 任意属性
  dynamic name = 'name';
  name = 1;
  print(name);

  // map
  const Map map = {'a': 'a'};
  print(set.iterator);

  // import '**' hide Dog;
  // Dog dog = Dog('dog'); // 报错，警告
  animal.Cat('A', 1).run('farm');

  var s = 'string interpolation';
  // assert 当第一个参数为 false 时会打断代码执行
  assert('Dart has $s, which is very handy.' ==
      'Dart has string interpolation, '
          'which is very handy.');
  assert('That deserves all caps. '
      '${s.toUpperCase()} is very handy!' ==
      'That deserves all caps. '
          'STRING INTERPOLATION is very handy!');

  String n = 'name';
  num n2 = 1;
  bool n3 = false;
  var n4 = null;
  Set<int> n5 = {1,2,3};
  Map<String,int> n6 = {'aaa':1};
  Cat n7 = Cat('1',2)
  ..birthday = DateTime.now();
  Symbol n8 = #n8; // const Symbol('n8')
  String n9 = '$n $n2 $n3 $n4 $n5 ${n6['aaa']} $n7 $n8';
  print(n9);


  // record
  Set<Object> set5 = {1, true, 'a'};
  Record record = (1,true,{'aaa':1},{1,2,true});
  ({int a, bool b}) record1 = (a: 1, b: true);
  var record2 = ('first', a: 2, b: true, 'last');
  (num, bool, int a) record3 = (1, true, 2);

  var (x, x2) = (1,2);
  var [an,an1] = [1,2];
  (num, List<num>) pr = (x,[an,an1]);
  var (pr1, [pr2, pr3]) = pr;

  const sa = 'sa';
  const sb = 'sb';
  switch (['sa', '1']){
    case [sa || sb, '1']:
      print('$sa $sb');
  }

  var sValue = switch (const [sa]){
    == const ['1'] || == const [sa] => true,
    _ => false
  };


  // 空检查与空断言区别：空断言会报错，引发运行时异常
  List<String?> row = ['user', '6666'];
  switch (row) {
    case [var s?]:
      // 's' has type non-nullable String here.
      print('空检查 $s');
  }

  switch (row) {
    case ['user', var name2!]: // ...
      // 'name' is a non-nullable string here.
      print('空断言 $name');
  }

  (int, int?) position = (2, 3);
  var (pa, pa1!) = position;

  switch ((1, 2)) {
    case (int a, String b):
      print("$a $b");
  }

  // ... 表示任意长度
  var [arr1,arr2, ...arr3, arr4, arr5] = [1, 2, 3, 4, 5, 6, 7];
  print('$arr1 $arr2 $arr3 $arr4 $arr5');

  // 解构对象
  var Cat(name:cName, age:cAge) = Cat('zz', 2)..birthday = DateTime.now();
  print('$cName, $cAge');

  // 解构记录
  var (myString: foo, myNumber: bar) = (myString: 'string', myNumber: 1);
  print('$foo, $bar');

  // 集合
  var liN = null;
  var li = [1,2,3];
  var li1 = [0, ...li];
  var li2 = [0, ...li, ...?liN]; // ...? 当 liN 为 null 时，将 liN 当做空集合 []
  print(li2);

  var ma = {'a': 1};
  var ma1 = {'b': 2, ...ma};
  print(ma1);

  var listOfInts = [1, 2, 3];
  var listOfStrings = ['#0', for (var i in listOfInts) '#$i'];
  print(listOfStrings);

  var login = 'Manager';
  var nav = ['Home', 'Furniture', 'Plants', if (login case 'Manager') 'Inventory'];
  print(nav);
}