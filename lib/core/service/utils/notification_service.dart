
// import 'package:get/get.dart';
// import 'package:reading_app/features/materials/notification/presentation/controller/notification_controller.dart';
// import 'package:stomp_dart_client/stomp_dart_client.dart';

// class NotificationService {
//   final NotificationController _notificationController = Get.find<NotificationController>();
//   late StompClient stompClient;

//   void connectToServer() {
//     stompClient = StompClient(
//       config: StompConfig.SockJS(
//         url: 'http://your-backend-url/ws',
//         onConnect: onConnected,
//         onWebSocketError: (error) => print('WebSocket Error: $error'),
//       ),
//     );

//     stompClient.activate();
//   }

//   void onConnected(StompFrame frame) {
//     stompClient.subscribe(
//       destination: '/topic/notifications',
//       callback: (frame) {
//         if (frame.body != null) {
//           _notificationController.addNotification(frame.body!);
//         }
//       },
//     );
//   }
// }
