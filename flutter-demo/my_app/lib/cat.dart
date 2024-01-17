class Cat {
  final String name;
  final int age;
  late final DateTime _birthday;
  String? type;

  Cat(this.name, this.age);


  void run(String place){
    print('$name run around at $place.');
  }

  String get message => '''
    姓名：$name
    年龄：$age
    生日：$_birthday
  ''';

  set birthday(DateTime time) => _birthday = time;

  @override
  String toString() => '$name,$age,$type,$_birthday';
}

class Dog {
  String name;
  Dog(this.name);
}

void main(){
  Cat cat = Cat('mimi', 2)
  ..birthday = DateTime.now(); // cat.birthday = DateTime.now();
  cat.type ??= 'type_data'; // cat.type = cat.type ?? 'type_data';

  print(cat.toString());

  print(cat.name is String ? 'Y': 'N');

  print(cat.type ?? 'bantiam');

  print(cat._birthday);

  // ?. 操作符
  Cat? fn(bool b) => b ? (Cat('mimi', 3)..type = 'fn_type') : null;
  var fnD = fn(true)
      ?..type = 'type_before'
      ..birthday = DateTime.timestamp();

  print(fnD.toString());

  // 级联嵌套
  String name = (Cat('kiki', 4)
    ..birthday = DateTime.now()
    ..toString()).name;

  print(name);

  // ()  []  ?[]  .  ?.  !
  Cat cat2 = Cat('GiGi', 1);
  cat2.run('farm'); // ()
  print([1,2,3][1]); // [] 将 int 传递给以访问索引处的元素
  print(fn(true)?.type); // ?.
  print(fn(true)!.type); // !.  如果表达式为 null ，则引发运行时异常
  print(null?[1]); // 将 int 传递给以访问索引处的元素，除非为 null
}