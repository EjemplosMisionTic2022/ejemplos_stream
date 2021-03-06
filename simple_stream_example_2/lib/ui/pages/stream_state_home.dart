import 'package:flutter/material.dart';
import 'package:simple_stream_example_2/data/simple_model.dart';

import '../../domain/stream_state_handler.dart';

class StreamStateHome extends StatefulWidget {
  @override
  _StreamStateHomeState createState() => _StreamStateHomeState();
}

class _StreamStateHomeState extends State<StreamStateHome> {
  final StreamStateHandler myStreamProvider = StreamStateHandler();

  void setInitialvalue() async {
    await Future<void>.delayed(const Duration(seconds: 3));
    myStreamProvider.changeValue(SingleModel(0));
  }

  @override
  void initState() {
    setInitialvalue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stream sample 2"),
      ),
      body: _getBuilder(),
    );
  }

  Widget _getBuilder() {
    return StreamBuilder(
      stream: myStreamProvider.stream,
      builder: (BuildContext context, AsyncSnapshot<SingleModel> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(child: Text('ConnectionState.none'));
            case ConnectionState.waiting:
              return Center(child: Text('ConnectionState.waiting'));
            case ConnectionState.active:
              SingleModel? currentValue = snapshot.data;
              return _buildUi(currentValue!);
            case ConnectionState.done:
              SingleModel? currentValue = snapshot.data;
              return _buildUi(currentValue!);
          }
        }
      },
    );
  }

  Widget _buildUi(SingleModel currentValue) {
    print(currentValue.value);
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                  height: 40.0,
                  color: currentValue.value == 0 ? Colors.blue : Colors.grey,
                  child: Center(child: Text("C1")),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                  height: 40.0,
                  color: currentValue.value == 1 ? Colors.red : Colors.grey,
                  child: Center(child: Text("C2")),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                  height: 40.0,
                  color: currentValue.value == 2 ? Colors.yellow : Colors.grey,
                  child: Center(child: Text("C3")),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () => changeData(currentValue),
                child: Text("Press me!!")),
          )
        ]);
  }

  void changeData(SingleModel currentValue) {
    int newValue = (currentValue.value + 1) % 3;
    //if (newValue == 3) {
    //  newValue = 0;
    //}
    currentValue.value = newValue;
    myStreamProvider.changeValue(currentValue);
  }
}
