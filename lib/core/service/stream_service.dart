import 'dart:async';

class StreamService {
  static final StreamService _instance = StreamService._internal();
  factory StreamService() => _instance;

  final StreamController<dynamic> _controller =
      StreamController<dynamic>.broadcast();

  StreamService._internal();

  void addData(dynamic data) {
    _controller.sink.add(data);
  }

  Stream<dynamic> get stream => _controller.stream;

  void dispose() {
    _controller.close();
  }
}
