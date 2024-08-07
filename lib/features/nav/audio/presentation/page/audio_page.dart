import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/features/nav/audio/presentation/controller/audio_controller.dart';
import 'package:reading_app/features/nav/audio/presentation/widgets/build_list_audio_column_category.dart';
import 'package:reading_app/features/nav/audio/presentation/widgets/build_slider_audio.dart';
import 'package:reading_app/features/nav/audio/presentation/widgets/build_sliver_audio_app_bar.dart';
import 'package:reading_app/features/nav/commic/presentation/widgets/build_list_row_category.dart';

class AudioPage extends GetView<AudioController> {
  const AudioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const BuildSliverAudioAppBar(),
          SliverToBoxAdapter(child: BuildSliderAudio(controller: controller)),

          // list category 1
          SliverToBoxAdapter(
            child: BuildListAudioColumnCategory(
              titleList: "Nghe nhiều nhất",
              seeMore: () {
                Get.toNamed(Routes.category,
                    arguments: {"titleCategory": "Nghe nhiều nhất"});
              },
              listBook: controller.listData,
              maxLength: 3,
            ),
          ),

          //build list category follow row
          SliverToBoxAdapter(
            child: BuildListRowCategory(
              listBookData: controller.listData,
              titleList: AppContents.newestUpdate,
              seeMore: () {
                Get.toNamed(Routes.category,
                    arguments: {"titleCategory": AppContents.newestUpdate});
              },
            ),
          ),

          // list category 1
          SliverToBoxAdapter(
            child: BuildListAudioColumnCategory(
              titleList: "Bão cập nhật",
              seeMore: () {
                Get.toNamed(Routes.category,
                    arguments: {"titleCategory": "Bão cập nhật"});
              },
              listBook: controller.listData,
              maxLength: 3,
            ),
          ),

          //build list category follow row
          SliverToBoxAdapter(
            child: BuildListRowCategory(
              listBookData: controller.listData,
              titleList: AppContents.newestUpdate,
              seeMore: () {
                Get.toNamed(Routes.category,
                    arguments: {"titleCategory": AppContents.newestUpdate});
              },
            ),
          ),

          // list category 1
          SliverToBoxAdapter(
            child: BuildListAudioColumnCategory(
              titleList: AppContents.hottestOfWeek,
              seeMore: () {
                Get.toNamed(Routes.category,
                    arguments: {"titleCategory": AppContents.hottestOfWeek});
              },
              listBook: controller.listData,
              maxLength: 3,
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(
              height: 100,
            ),
          ),
        ],
      ),
    );
  }
}
