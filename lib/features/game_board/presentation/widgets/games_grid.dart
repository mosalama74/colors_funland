import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/core/constants/app_strings.dart';
import 'package:color_funland/core/utils/text_styles.dart';
import 'package:color_funland/core/services/feature_management_service.dart';
import 'package:color_funland/features/game_board/presentation/widgets/feature_aware_game_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Games extends StatelessWidget {
  final FeatureManagementService featureService;

  const Games({
    Key? key,
    required this.featureService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<bool>>(
      stream: featureService.getAllFeatureStatuses(),
      initialData: const [
        true,
        true,
        true,
        true
      ], // Default all features to enabled
      builder: (context, AsyncSnapshot<List<bool>> snapshot) {
        final enabledFeatures =
            snapshot.data?.where((enabled) => enabled).length ?? 4;

        return Padding(
          padding: EdgeInsets.only(left: 46.w, right: 52.w),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                image: AssetImage(AppImages.cardBoard),
                fit: BoxFit.contain,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: enabledFeatures <= 2 ? 120.w : 20.w,
                vertical: 20.h,
              ),
              child:
               Row(
                mainAxisAlignment: enabledFeatures <= 2
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: _buildGameItems(context),
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildGameItems(BuildContext context) {
    return [
      FeatureAwareGameItem(
        featureId: 'my_painting',
        featureService: featureService,
        onTap: () => Navigator.pushNamed(context, '/mypaintingScreen'),
        child: _buildGameItemContent(
          image: AppImages.myPainting,
          title: AppStrings.myPainting,
        ),
      ),
      FeatureAwareGameItem(
        featureId: 'color_mixing',
        featureService: featureService,
        onTap: () => Navigator.pushNamed(context, '/colorMixingScreen'),
        child: _buildGameItemContent(
          image: AppImages.colorMixing,
          title: AppStrings.colorMixing,
        ),
      ),
      FeatureAwareGameItem(
        featureId: 'color_match',
        featureService: featureService,
        onTap: () => Navigator.pushNamed(context, '/colorMatchScreen'),
        child: _buildGameItemContent(
          image: AppImages.matchColors,
          title: AppStrings.matchColors,
        ),
      ),
      FeatureAwareGameItem(
        featureId: 'learning_colors',
        featureService: featureService,
        onTap: () {},
        child: _buildGameItemContent(
          image: AppImages.learningColors,
          title: AppStrings.learningColors,
        ),
      ),
    ];
  }

  Widget _buildGameItemContent({
    required String image,
    required String title,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          image,
          width: 233.w,
        ),
        Text(
          title,
          style: ts24minnie400,
        ),
      ],
    );
  }
}
