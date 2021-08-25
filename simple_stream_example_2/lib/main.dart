import 'package:flutter/material.dart';
import 'ui/pages/stream_state_home.dart';
import 'ui/theme/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream sample 2',
      showSemanticsDebugger: false,
      theme: MyTheme.darkTheme,
      home: StreamStateHome(),
    );
  }
}
