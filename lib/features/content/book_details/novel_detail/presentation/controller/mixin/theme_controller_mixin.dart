import 'dart:async';

import 'package:get/get.dart';
import 'package:reading_app/core/configs/const/app_constants.dart';
import 'package:reading_app/core/services/api/data/entities/models/read_theme_model.dart';
import 'package:reading_app/core/services/api/domain/usecase/themes/read_theme_use_case.dart';

mixin ThemeControllerMixin on GetxController {
  RxString fontReadTheme = AppConstants.fontDefault.obs;
  var textSizeReadTheme = 16.0.obs;
  Rx<ReadThemeModel> readThemeColorModel = ReadThemeModel().obs;
  Timer? _debounce;

  Future<void> initThemeControllerMixin() async {
    var data = await ReadThemeUseCase.getReadTheme();
    fontReadTheme.value = await ReadThemeUseCase.getFontReadTheme();
    textSizeReadTheme.value = await ReadThemeUseCase.getTextSizeReadTheme();
    readThemeColorModel.value = ReadThemeModel.fromMap(data ?? {});
  }

  void changeReadTheme(ReadThemeModel currentReadTheme) {
    readThemeColorModel.value = currentReadTheme;
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      ReadThemeUseCase.setReadTheme(readThemSetting: currentReadTheme.toJson());
    });
  }

  void changeSizeText(double size) {
    textSizeReadTheme.value = size;
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      ReadThemeUseCase.setTextSizeReadTheme(sizeText: size);
    });
  }

  void changeFontText(String font) {
    fontReadTheme.value = font;
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      ReadThemeUseCase.setFontReadTheme(font: font);
    });
  }

  @override
  void onClose() {
    _debounce?.cancel();
    super.onClose();
  }
}
