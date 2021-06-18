import 'dart:async';

class NumberStream {
  final _myModelController = StreamController<int>.broadcast();

  get myModels => _myModelController.stream;

  NumberStream() {}

  addNumberToSink(int newNumber) {
    _myModelController.sink.add(newNumber);
  }

  addError() {
    _myModelController.sink.addError('error');
  }

  close() {
    _myModelController.close();
  }
}
