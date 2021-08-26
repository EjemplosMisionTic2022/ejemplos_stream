import 'dart:async';
import '../data/simple_model.dart';

class StreamStateHandler {
  SingleModel data = new SingleModel(0);
  final _myModelController = StreamController<SingleModel>.broadcast();

  get stream => _myModelController.stream;

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
