void main(List<String> arguments) {
  void enableFlags(bool? bold, bool? hidden){
    print('$bold $hidden');
  }
  enableFlags(true, false);

  // 指定默认值 默认为 null
  void enableFlags1({bool? bold, bool hidden = true}){
    print('$bold $hidden');
  }
  enableFlags1();

  // 参数非必须
  void enableFlags2({bool? bold, required bool? hidden}){
    print('$bold $hidden');
  }
  enableFlags2(hidden: null);

  // 添加其他位置参数
  void enableFlags3(String name, {bool? bold, required bool? hidden}){
    print('$name $bold $hidden');
  }
  enableFlags3('张三',hidden: null);

  // 添加可选参数
  void enableFlags4(String name, [String action = '唱 跳 rap']){
    print('$name $action');
  }
  enableFlags4('坤坤');

  // 命令行应用参数  dart function.dart test
  // assert(arguments === ['test']);
  print(arguments);

  // 匿名函数 (){}
  var list = [1,2,3,4];
  var listMap = list.map<String>((item) => (item + 1).toString())
  ..forEach((element) { print('$element A'); });
  print(listMap);

  void enableFlags5(String name, List list){
    var [a,b,c] = list;
    [c,b,a] = [a,b,c];
    print('$name $a $b $c');
  }
  enableFlags5('zhangsan', [1,2,3,4]);

  // 异步使用 （async* / Stream）  同步使用 （sync* / Iterable）
  Stream<num> streamAsyncFun(num n) async*{
    yield n++;
  }

  Iterable<num> iterAsyncFun(num n) sync*{
    yield n++;
  }
}