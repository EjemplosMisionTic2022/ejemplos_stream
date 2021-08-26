import 'dart:async';

class NumberStream {
  final _myModelController = StreamController<int>.broadcast();

  get stream => _myModelController.stream;

  NumberStream() {}

  addNumberToSink(int newNumber) async {
    _myModelController.sink.add(newNumber);
  }

  addError() {
    _myModelController.sink.addError('some error');
  }

  close() {
    _myModelController.close();
  }
}
