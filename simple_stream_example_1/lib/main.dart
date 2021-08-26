import 'package:flutter/material.dart';
import 'package:simple_stream_example_1/theme/theme.dart';
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
      title: 'Stream sample 1',
      debugShowCheckedModeBanner: false,
      theme: MyTheme.darkTheme,
      home: MyHomePage(),
    );
  }
}

// We use a StatefulWidget to have the dispose method
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final NumberStream myStreamProvider = NumberStream();

  void setInitialvalue() async {
    await Future<void>.delayed(const Duration(seconds: 3));
    myStreamProvider.addNumberToSink(99);
  }

  @override
  void initState() {
    setInitialvalue();
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
              stream: myStreamProvider.stream,
              initialData: -1, // initial value of the stream
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Center(child: Text('ConnectionState.none'));
                    case ConnectionState.waiting:
                      return Center(child: Text('ConnectionState.waiting'));
                    case ConnectionState.active:
                      return Center(child: Text('${snapshot.data}'));
                    case ConnectionState.done:
                      return Center(child: Text('${snapshot.data}'));
                  }
                }
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () => updateStream(),
                  child: Text("Update Stream")),
              ElevatedButton(
                  onPressed: () => myStreamProvider.addError(),
                  child: Text("Update with Error"))
            ],
          ),
        ],
      ),
    );
  }
}
