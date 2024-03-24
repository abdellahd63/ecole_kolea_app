import 'dart:async';
import 'dart:io';
import 'dart:isolate';

Future<SendPort> init() async{
  Completer<SendPort> completer = new Completer<SendPort>();
  ReceivePort isolateToMainStream = ReceivePort();

  isolateToMainStream.listen((data) {
    if(data is SendPort){
      SendPort mainToIsolateStream = data;
      completer.complete(mainToIsolateStream);
    }else{
      print('isolateToMainStream  $data');
    }
  });
  await Isolate.spawn(myIsolate, isolateToMainStream.sendPort);
  return completer.future;
}
void myIsolate(SendPort isolateToMainStream){
  ReceivePort mainToIsolateStream = ReceivePort();
  isolateToMainStream.send(mainToIsolateStream.sendPort);
  mainToIsolateStream.listen((data) {
    print('mainToIsolateStream  $data');
    exit(0);
  });
  isolateToMainStream.send('this is from myisolate()');
}
void main() async{
  SendPort mainToIsolateStream = await init();
  mainToIsolateStream.send(['Hello','Hello']);
}