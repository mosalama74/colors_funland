import 'package:color_funland/core/components/elevated_btn.dart';
import 'package:color_funland/core/constants/app_common_padding.dart';
import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/core/constants/app_strings.dart';
import 'package:color_funland/core/utils/text_styles.dart';
import 'package:color_funland/core/services/message_service.dart';
import 'package:color_funland/features/addProfileInfo/presentation/cubit/profile_info_cubit.dart';
import 'package:color_funland/features/addProfileInfo/presentation/cubit/profile_info_state.dart';
import 'package:color_funland/features/addProfileInfo/presentation/pages/child_progress_scareen.dart';
import 'package:color_funland/features/addProfileInfo/presentation/widgets/add_photo_widget.dart';
import 'package:color_funland/features/addProfileInfo/presentation/widgets/input_child_info_widget.dart';
import 'package:color_funland/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:color_funland/features/auth/presentation/cubit/auth_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddProfileInfoScreen extends StatefulWidget {
  const AddProfileInfoScreen({super.key});

  @override
  State<AddProfileInfoScreen> createState() => _AddProfileInfoScreenState();
}

class _AddProfileInfoScreenState extends State<AddProfileInfoScreen> {
  final TextEditingController childNameController = TextEditingController();
  final TextEditingController childAgeController = TextEditingController();
  final MessageService _messageService = ToastMessageService();

  bool _isBtnPressed = true;

  @override
  void dispose() {
    childNameController.dispose();
    childAgeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.gradientBg),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: AppCommonPadding.screenOuterPadding,
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        _isBtnPressed
                            ? AppImages.curvedBtmCardBg
                            : AppImages.cardBg,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 58.w,
                      right: 57.w,
                      top: 46.h,
                      bottom: 46.23.h,
                    ),
                    child: BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state is AuthSuccess) {
                            context.read<AuthCubit>().getCurrentChildData();
                          }
                        },
                        builder: (context, state) {
                          String username = '';
                         
                          if (state is AuthSuccess) {
                            username = state.user.firstName;
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Logo
                              Padding(
                                padding: EdgeInsets.only(left: 10.w, top: 10.h),
                                child: logoImage,
                              ),
                              SizedBox(height: 10.h),

                              Padding(
                                padding: EdgeInsets.only(left: 10.w),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(AppStrings.welcome,
                                        style: ts32Black400),
                                    Text(username, style: ts64Purple400),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.h),

                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: const AddPhotoWidget(),
                              ),
                              SizedBox(height: 32.h),

                              InputChildInfoWidget(
                                nameController: childNameController,
                                ageController: childAgeController,
                              ),
                              SizedBox(height: 32.h),

                              // Next Button
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 93.5.w),
                                child: BlocConsumer<ProfileInfoCubit,
                                    ProfileInfoState>(
                                  listener: (context, state) {
                                    if (state is SaveChildInfoSuccessState) {
                                      _messageService.showMessage(
                                        'Profile saved successfully',
                                        MessageType.success,
                                      );
                                      // Get child data after saving
                                      context
                                          .read<ProfileInfoCubit>()
                                          .getCurrentChild();
                                      Navigator.pushReplacementNamed(
                                          context, '/gameBoard');
                                    } else if (state
                                        is SaveChildInfoErrorState) {
                                      _messageService.showMessage(
                                        state.errorMessage ??
                                            'Failed to save profile',
                                        MessageType.error,
                                      );
                                    } else if (state
                                        is UploadImageSuccessState) {
                                      _messageService.showMessage(
                                        'Image uploaded successfully',
                                        MessageType.success,
                                      );
                                    } else if (state is UploadImageErrorState) {
                                      _messageService.showMessage(
                                        state.errorMessage ??
                                            'Failed to upload image',
                                        MessageType.error,
                                      );
                                    } else if (state
                                        is UpdateChildDataSuccessState) {
                                      _messageService.showMessage(
                                        'Child data updated successfully',
                                        MessageType.success,
                                      );
                                    } else if (state
                                        is UpdateChildDataErrorState) {
                                      _messageService.showMessage(
                                        state.errorMessage ??
                                            'Failed to update child data',
                                        MessageType.error,
                                      );
                                    }
                                  },
                                  builder: (context, state) {
                                    return ElevatedBtn(
                                      text: _isBtnPressed
                                          ? AppStrings.letsstart
                                          : AppStrings.saveandlogin,
                                      onPressed: _isBtnPressed
                                          ? () async {
                                              await context
                                                  .read<ProfileInfoCubit>()
                                                  .uploadSelectedImage();
                                              setState(() {
                                                _isBtnPressed = false;
                                              });
                                            }
                                          : () async {
                                              // Validate inputs
                                              if (childNameController
                                                      .text.isEmpty ||
                                                  childAgeController
                                                      .text.isEmpty) {
                                                _messageService.showMessage(
                                                  'Please fill in all fields',
                                                  MessageType.warning,
                                                );
                                                return;
                                              }

                                              String? imageUrl;
                                              if (state
                                                  is UploadImageSuccessState) {
                                                imageUrl = state.imageUrl;
                                              }

                                              if (imageUrl == null) {
                                                _messageService.showMessage(
                                                  'Please select and upload a profile image',
                                                  MessageType.warning,
                                                );
                                                return;
                                              }

                                              await context
                                                  .read<ProfileInfoCubit>()
                                                  .saveChildData(
                                                    childName:
                                                        childNameController
                                                            .text,
                                                    childAge:
                                                        childAgeController.text,
                                                    imageUrl: imageUrl,
                                                    paintingGameCounter: PaintingProgress.gamesCounter,
                                                    paintingLevelCounter: PaintingProgress.levelsCounter,
                                                    colorMatchGameCounter: ColorMatchProgress.gamesCounter,
                                                    colorMatchLevelCounter:  ColorMatchProgress.levelsCounter,
                                                    colorMixingGameCounter:  ColorMatchProgress.gamesCounter,
                                                    colorMixingLevelCounter:  ColorMatchProgress.levelsCounter,
                                                    learningColorsGameCounter: LearningColorsProgress.gamesCounter,
                                                    learningColorsLevelCounter: LearningColorsProgress.levelsCounter,
                                                  );
                                            },
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
