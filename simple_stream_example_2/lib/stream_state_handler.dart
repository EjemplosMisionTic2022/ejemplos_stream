import 'dart:async';
import 'simple_model.dart';

class StreamStateHandler {
  SingleModel data = new SingleModel(value: 0);
  final _myModelController = StreamController<SingleModel>.broadcast();

  get myModels => _myModelController.stream;

  StreamStateHandler() {
    getMyModels();
  }

  getMyModels() async {
    _myModelController.add(data);
  }

  changeValue(SingleModel newValue) {
    data = newValue;
    getMyModels();
  }
}
