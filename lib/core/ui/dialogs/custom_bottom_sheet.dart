import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomSheetWidget extends StatelessWidget {
  final List<Widget> viewItems;
  final double? heightSheet;
  final EdgeInsets? paddingContent;

  const CustomBottomSheetWidget(
    BuildContext context, {
    super.key,
    required this.viewItems,
    this.heightSheet,
    this.paddingContent,
  });

  // Function to show the bottom sheet
  void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Cho phép cuộn khi nội dung quá lớn
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(0), // Rounded top corners
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: paddingContent ??
              const EdgeInsets.all(
                  8), // Nếu không có paddingContent thì sử dụng mặc định
          height: heightSheet ??
              Get.height * 0.5, // Chiều cao mặc định nếu không có giá trị
          width: Get.width,
          child: SingleChildScrollView(
            // Bao bọc nội dung trong SingleChildScrollView để cuộn
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: viewItems,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        show(context); // Trigger the bottom sheet
      },
      child: const Text('Open Bottom Sheet'),
    );
  }
}
