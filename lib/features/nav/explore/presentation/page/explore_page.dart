

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/features/nav/home/presentation/controller/home_controller.dart';

class ExplorePage extends GetView<HomeController>{
  const ExplorePage({super.key});


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("This is posts page"),),
    );
  }

}