var fun = () => 'a';

// 可选参数 []，命名参数 {}
String fun2(String a,[String? b]){
  return '$a$b';
}

// 创建一个异常
 class HasStringException implements Exception{
  final String s;
  HasStringException(this.s);

  String errMsg() => '$s is type of String';
}

void main(){
  // 异常处理
  String str = '张三';

  void testException(String a){
    throw HasStringException(a);
  }

  // on 追踪指定异常
  // catch 第一个参数是抛出的异常， 第二个是堆栈跟踪（StackTrace 对象）
  try{
    testException(str);
  } on HasStringException catch(e, s) {
    print(e);
  } catch(e){
    print(e);
  }

  // rethrow 处理完异常后任然让他抛出
  void testException02(String a){
    try{
      throw HasStringException(a);
    }catch(e){
      rethrow;
    }
  }

  try{
    testException02(str);
  }catch(e){
    print(e);
  } finally{ // 不管是否有exception都会执行
    print(str);
  }

  // assert 断言
  // 断言失败后会终止程序执行并抛出异常：AssertionError
  assert(str.startsWith('---'), 'URL ($str) should start with "https".');
  // 不会执行
  print('cancel');
}