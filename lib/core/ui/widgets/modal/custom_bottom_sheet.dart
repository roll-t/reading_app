import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomSheetWidget extends StatelessWidget {
  final List<Widget> viewItems;
  final double ? heightSheet;
  final EdgeInsets? paddingContent;

  const CustomBottomSheetWidget(BuildContext context,{
    super.key,
    required this.viewItems, 
    this.heightSheet, 
    this.paddingContent,
  });

  // Function to show the bottom sheet
  void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(0), // Rounded top corners
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: paddingContent,
          height:heightSheet ?? Get.height * 0.3,
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: viewItems,
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
