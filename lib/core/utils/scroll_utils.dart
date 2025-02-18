import 'package:flutter/widgets.dart';

class ScrollUtils {
  // Cuộn đến vị trí đầu của ListView
  static void scrollToTop(ScrollController controller) {
    controller.animateTo(
      0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // Cuộn đến vị trí cuối của ListView
  static void scrollToBottom(ScrollController controller) {
    controller.animateTo(
      controller.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // Kiểm tra xem có cuộn đến cuối cùng không
  static bool isMaxScrollExtent(ScrollController controller) {
    return controller.position.pixels == controller.position.maxScrollExtent;
  }

  // Cuộn đến một vị trí cụ thể (theo pixel)
  static void scrollToPosition(ScrollController controller, double position) {
    controller.animateTo(
      position,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // Cuộn đến chỉ mục trong danh sách (mặc định là 100 pixel cho mỗi mục)
  static void scrollToIndex(ScrollController controller, int index,
      {double itemHeight = 100.0}) {
    final position = index * itemHeight;
    scrollToPosition(controller, position);
  }

  static void scrollToMax(ScrollController scrollController) {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300), // Thời gian cuộn đến cuối
        curve: Curves.easeInOut,
      );
    }
  }

  // Lắng nghe sự kiện cuộn khi cuộn đến ngưỡng nhất định (Ví dụ: 80%)
  static void listenToScrollThreshold(
      ScrollController controller, Function onThresholdReached,
      {double threshold = 0.8}) {
    controller.addListener(() {
      double maxScroll = controller.position.maxScrollExtent;
      double currentScroll = controller.position.pixels;
      if (currentScroll / maxScroll >= threshold) {
        onThresholdReached();
      }
    });
  }

  static void scrollDown(ScrollController controller, double offset) {
    controller.animateTo(
      controller.offset + offset,
      duration: const Duration(milliseconds: 300), // Thời gian cuộn
      curve: Curves.easeInOut, // Hiệu ứng cuộn
    );
  }

  // Cuộn đến phần tử mới nhất trong danh sách khi có dữ liệu mới
  static void scrollToNewItem(ScrollController controller) {
    if (controller.hasClients) {
      controller.animateTo(
        controller.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
}
