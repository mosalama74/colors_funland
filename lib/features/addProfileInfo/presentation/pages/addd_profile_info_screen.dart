import 'package:color_funland/core/components/elevated_btn.dart';
import 'package:color_funland/core/constants/app_common_padding.dart';
import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/core/constants/app_strings.dart';
import 'package:color_funland/core/utils/text_styles.dart';
import 'package:color_funland/core/services/message_service.dart';
import 'package:color_funland/features/addProfileInfo/presentation/cubit/profile_info_cubit.dart';
import 'package:color_funland/features/addProfileInfo/presentation/cubit/profile_info_state.dart';
import 'package:color_funland/features/addProfileInfo/presentation/widgets/add_photo_widget.dart';
import 'package:color_funland/features/addProfileInfo/presentation/widgets/input_child_info_widget.dart';
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

  void _handleSaveAndLogin(ProfileInfoState state) {
    if (childNameController.text.isEmpty || childAgeController.text.isEmpty) {
      _messageService.showMessage(
        'Please fill in all fields',
        MessageType.warning,
      );
      return;
    }

    if (state.imageUrl == null) {
      _messageService.showMessage(
        'Please select and upload a profile image',
        MessageType.warning,
      );
      return;
    }

    context.read<ProfileInfoCubit>().saveChildData(
      childNameController.text,
      childAgeController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileInfoCubit(),
      child: Container(
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
                      child: Column(
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
                                Text(AppStrings.welcome, style: ts32Black400),
                                Text("Sarah", style: ts64Purple400),
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
                            padding: EdgeInsets.symmetric(horizontal: 93.5.w),
                            child: BlocConsumer<ProfileInfoCubit, ProfileInfoState>(
                              listenWhen: (previous, current) =>
                                  previous.status != current.status &&
                                  (current.status == ProfileInfoStatus.success ||
                                      current.status == ProfileInfoStatus.failure),
                              listener: (context, state) {
                                if (state.status == ProfileInfoStatus.failure) {
                                  _messageService.showMessage(
                                    state.errorMessage ?? 'An error occurred',
                                    MessageType.error,
                                  );
                                } else if (state.status == ProfileInfoStatus.success &&
                                    !_isBtnPressed) {
                                  _messageService.showMessage(
                                    'Profile updated successfully',
                                    MessageType.success,
                                  );
                                  Navigator.pushReplacementNamed(context, '/gameBoard');
                                }
                              },
                              builder: (context, state) {
                                final bool isLoading =
                                    state.status == ProfileInfoStatus.loading;

                                return ElevatedBtn(
                                  text: _isBtnPressed
                                      ? AppStrings.letsstart
                                      : AppStrings.saveandlogin,
                                  onPressed:(){ Navigator.pushReplacementNamed(context, '/gameBoard');}
                                  //  ()=>
                                  //  isLoading
                                  //     ? null
                                  //     : () {
                                  //         if (_isBtnPressed) {
                                  //           setState(() {
                                  //             _isBtnPressed = false;
                                  //           });
                                  //         } else {
                                  //           _handleSaveAndLogin(state);
                                  //         }
                                  //       },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
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
