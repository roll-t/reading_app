import 'package:get/get.dart';
import 'package:reading_app/core/services/prefs/prefs.dart';
import 'package:reading_app/features/nav/audio/presentation/controller/audio_controller.dart';
class AudioBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Prefs(), fenix: true);
    Get.put(AudioController());
  }
}
