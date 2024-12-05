import 'dart:isolate';

import 'package:flutter/material.dart';

class HomaPage extends StatelessWidget {
  const HomaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
      child: Center(
        child: Column(
          children: [
            Image.asset('android/assets/gifs/balls.gif'),
            //isolate. task 1
            ElevatedButton(
              onPressed: () async
              {
              var total = await completTask1();
              debugPrint('Result 1: $total');
            }, 
            child: const Text('Task 1'),
            ),
            //isolate. task 2
            ElevatedButton(onPressed: () async
            {
              final receivePort = ReceivePort(); 
              await Isolate.spawn(complexTask25, receivePort.sendPort);
              receivePort.listen((total) {
               debugPrint('Result 2: $total');
              });
            }, 
            child: const Text('Task 2'),
            ),
            //isolate con parámetros. task3
            ElevatedButton(onPressed: () async
            {
              final receivePort = ReceivePort(); 
              await Isolate.spawn(complexTask3,(iteration: 1000000000, sendPort: receivePort.sendPort));
              receivePort.listen((total) {
                debugPrint('Result 3: $total');
            });
            }, 
            child: const Text('Task 3'),
            ),
          ],
        ),
      )),
    );
  }
 // para el task 1
  double completTask1(){
    
    var total = 0.0;
    for (var i = 0; i < 1000000000; i++) {
     total += i; 
    }
    return total;
 } 

}

complexTask25(SendPort sendPort) {
  var total = 0.0;
  for (var i =0; i< 100000000; i++){
    total +=i; 
  }
  sendPort.send(total);
}
complexTask3(({int iteration, SendPort sendPort}) data) {
  var total = 0.0;
  for (var i =0; i< data.iteration; i++){
    total +=i; 
  }
  data.sendPort.send(total);
}

 // --POJO--
 //class Data {
  //final int iteration;
  //final SendPort sendPort;
  // Data(this.iteration, this.sendPort);
 //}