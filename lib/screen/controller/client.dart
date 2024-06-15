import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';


typedef Unit8ListCallback= Function(Uint8List data);
typedef DynamicCallback= Function(dynamic data);
class Client{
  String hostname;
  Unit8ListCallback onData;
  DynamicCallback onError;
  Client (
      {required this. hostname, required this.onData, required this. onError});
  bool isConnected = false;
  Socket? socket;

  Future<bool> connect() async {
    try{
      socket = await Socket.connect(hostname, 10000);
      socket!.listen(onData, onError: onError,
          onDone: () async {
            disconnect();
            isConnected = false;
          });
      isConnected = true;
      write("CustomerAppConnected");
    }catch(e){
      debugPrint("Catch Error: $e");
    }
    return isConnected;
  }
  void write(String message) {
    socket!.write(message);
  }
  void disconnect () {
  const message =
  "Customer App got disconnected";
  write(message);
  if (socket != null) {
    socket!.destroy();
    isConnected =false;
    socket=null;
  }
  }
}