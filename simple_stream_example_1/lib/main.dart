import 'package:flutter/material.dart';
import 'dart:math';
import 'my_stream.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final NumberStream myStreamProvider = NumberStream();

  @override
  void initState() {
    super.initState();
  }

  void updateStream() {
    Random random = Random();
    int myNum = random.nextInt(10);
    myStreamProvider.addNumberToSink(myNum);
  }

  @override
  dispose() {
    myStreamProvider.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stream sample 1"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StreamBuilder<int>(
              stream: myStreamProvider.myModels,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                if (!snapshot.hasData) {
                  return Text('no data');
                }

                return Center(child: Text('${snapshot.data}'));
              }),
          ElevatedButton(
              onPressed: () => updateStream(), child: Text("Update Stream")),
        ],
      ),
    );
  }
}
