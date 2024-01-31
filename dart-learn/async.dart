import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

const String filename = 'cat.dart';

// readAsStringSync 同步调用
String _readFileSync() {
  final file = File(filename);
  final contents = file.readAsStringSync();
  return contents.trim();
}

// readAsString 异步调用
Future<String> _readFile(){
  final file = File(filename);
  return file.readAsString();
}

Future myFuture() async{
  await Future.delayed(Duration(seconds:2));
  return 'Y';
}

void main() async{
  DateTime d = DateTime.now();
  final fileData = _readFileSync();
  print('fileData.length ${fileData.length}');
  print(DateTime.now().millisecondsSinceEpoch - d.millisecondsSinceEpoch);

  // Isolate
  DateTime d2 = DateTime.now();
  final fileData2 = _readFile();
  fileData2.then((fileData2) => {
    print('fileData2.length ${fileData2.length}')
  });
  print(DateTime.now().millisecondsSinceEpoch - d2.millisecondsSinceEpoch);

  print('wait 2 seconds');
  myFuture().then((_) => {
    print('wait end')
  });

  // Isolate 多线程，延迟最低。由于dart是单线程，如果在执行 Future 时遇到耗时的计算任务或者 I/O操作，这些操作会占用当前线程的资源，从而导致应用出现卡顿现象，影响用户体验。
  // flutter 中的 compute 函数也是通过 Isolate 实现
  DateTime d3 = DateTime.now();
  Isolate.run(_readFile);
  print(DateTime.now().millisecondsSinceEpoch - d3.millisecondsSinceEpoch);

  // async*
  Stream<int> countStream(int to) async* {
    for (int i = 1; i <= to; i++) {
      yield i;
    }
  }
  Future<int> sumStream(Stream<int> stream) async {
    var sum = 0;
    await for (final value in stream) {
      sum += value;
    }
    return sum;
  }
  var stream = countStream(10);
  var sum = await sumStream(stream);
  print(sum); // 55
}