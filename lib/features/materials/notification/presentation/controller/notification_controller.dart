import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

class NotificationController extends GetxController {
  var notifications = <String>[].obs;
  late StompClient stompClient;

  @override
  void onInit() {
    super.onInit();
    connectToWebSocket();
  }

  void connectToWebSocket() {
    print("Đang kết nối tới WebSocket...");
    stompClient = StompClient(
      config: StompConfig(
        url: 'wss://14.225.218.46:8080/ws',
        onConnect: onConnected,
        beforeConnect: () async {
          print('Chuẩn bị kết nối...');
          await Future.delayed(const Duration(milliseconds: 200));
        },
        onWebSocketError: (dynamic error) {
          print('Lỗi WebSocket: $error');
        },
        onStompError: (StompFrame error) {
          print('Lỗi STOMP: ${error.body}');
        },
        onDisconnect: (StompFrame? frame) {
          print('Đã ngắt kết nối khỏi WebSocket.');
        },
        onDebugMessage: (String debug) {
          print('Thông báo Debug: $debug');
        },
      ),
    );
    stompClient.activate();
  }

  void onConnected(StompFrame frame) {
    stompClient.subscribe(
      destination: '/topic/notifications',
      callback: (frame) {
        if (frame.body != null) {
          addNotification(frame.body!);
        }
      },
    );
  }

  // Thêm thông báo mới vào danh sách và hiển thị Snackbar
  void addNotification(String message) {
    notifications.add(message);
    Get.snackbar(
      'Thông báo mới',
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  // Xóa thông báo
  void removeNotification(int index) {
    if (index >= 0 && index < notifications.length) {
      notifications.removeAt(index);
    }
  }

  // Xóa tất cả thông báo
  void clearNotifications() {
    notifications.clear();
  }

  @override
  void onClose() {
    stompClient.deactivate();
    super.onClose();
  }
}
