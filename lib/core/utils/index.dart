import 'package:tick_note/core/utils/app_colors.dart';
import 'package:tick_note/core/utils/app_distances.dart';
import 'package:tick_note/core/utils/app_fonts.dart';
import 'package:tick_note/core/utils/size_config.dart';

abstract class R {
  static AppColors colors = AppColors();

  static AppFontFamily fontFamily = AppFontFamily();
  static AppFontSize fontSize = AppFontSize();
  static AppMargin margin = AppMargin();
  static AppPadding padding = AppPadding();
  static SizeConfig sizeConfig = SizeConfig();
}
