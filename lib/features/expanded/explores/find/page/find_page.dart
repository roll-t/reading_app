import 'package:flutter/material.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal.dart';

class FindPage extends StatelessWidget {
  const FindPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: TextNormal(
        textChild: "thong tin tim kiem",
      ),
    );
  }
}
