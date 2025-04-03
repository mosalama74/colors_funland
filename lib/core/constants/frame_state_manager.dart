import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/features/addProfileInfo/presentation/pages/child_progress_scareen.dart';

class FrameStateManager {
  static final Map<String, String> _uncoloredToColoredMap = {
    AppImages.uncoloredelephantfram: AppImages.coloredelephantfram,
    AppImages.uncoloredturtle2fram: AppImages.coloredturtlefram,
    AppImages.uncoloredpenguinfram: AppImages.coloredpenguinfram,
    AppImages.uncoloredelephante2fram: AppImages.coloredelephante2fram,
    AppImages.uncoloredmonkey2fram: AppImages.coloredmonkey2fram,
    AppImages.uncoloredflower1fram: AppImages.coloredflower1fram,
    AppImages.uncoloredflower2fram: AppImages.coloredflower2fram,
    AppImages.uncoloredflower3fram: AppImages.coloredflower3fram,
    AppImages.uncoloredflower4Fram: AppImages.coloredflower4fram,
  };

  // Map painting images to their corresponding frames
  static final Map<String, String> _paintingToFrameMap = {
    AppImages.uncoloredelephante: AppImages.uncoloredelephantfram,
    AppImages.uncoloredturtle: AppImages.uncoloredturtle2fram,
    AppImages.uncoloredpenguin: AppImages.uncoloredpenguinfram,
    AppImages.uncoloredelephante2: AppImages.uncoloredelephante2fram,
    AppImages.uncoloredmonkey2: AppImages.uncoloredmonkey2fram,
    AppImages.floweruncolored1: AppImages.uncoloredflower1fram,
    AppImages.floweruncolored2: AppImages.uncoloredflower2fram,
    AppImages.floweruncolored3: AppImages.uncoloredflower3fram,
    AppImages.floweruncolored4: AppImages.uncoloredflower4Fram,
  };

  static String? getColoredFrame(String uncoloredFrame) {
    return _uncoloredToColoredMap[uncoloredFrame];
  }

  static String? getFrameForPainting(String paintingImage) {
    return _paintingToFrameMap[paintingImage];
  }

  static bool isFrameColored(String frameImage) {
    return !frameImage.contains('uncolored');
  }

  // Update frame status when painting is completed
  static void updateFrameAfterPainting(String paintingImage) {
    String? frameImage = getFrameForPainting(paintingImage);
    if (frameImage != null) {
      String? coloredFrame = getColoredFrame(frameImage);
      if (coloredFrame != null) {
        // We'll use the painting's key to track the frame status
        PaintingProgress.markItemAsPainted(frameImage);
      }
    }
  }
}