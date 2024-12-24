import 'dart:async';
import 'dart:isolate';

class IsolateManager {
  static final IsolateManager _instance = IsolateManager._internal();
  factory IsolateManager() => _instance;

  late Isolate _isolate;
  late ReceivePort _receivePort;
  final StreamController<dynamic> _streamController =
      StreamController<dynamic>.broadcast();

  IsolateManager._internal();

  Future<void> initialize() async {
    _receivePort = ReceivePort();

    _isolate = await Isolate.spawn(_isolateEntry, _receivePort.sendPort);

    _receivePort.listen((message) {
      _streamController.add(message);
    });
  }

  /// Hàm xử lý trong Isolate
  static void _isolateEntry(SendPort sendPort) {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      final data = DateTime.now().toString();
      sendPort.send(data);
    });
  }

  /// Stream cho các màn hình sử dụng
  Stream<dynamic> get stream => _streamController.stream;

  void dispose() {
    _isolate.kill(priority: Isolate.immediate);
    _receivePort.close();
    _streamController.close();
  }
}
