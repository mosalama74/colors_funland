import 'package:color_funland/core/constants/app_icons.dart';
import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/core/constants/app_strings.dart';
import 'package:color_funland/core/utils/text_styles.dart';
import 'package:color_funland/core/services/message_service.dart';
import 'package:color_funland/features/addProfileInfo/presentation/cubit/profile_info_cubit.dart';
import 'package:color_funland/features/addProfileInfo/presentation/cubit/profile_info_state.dart';
import 'package:color_funland/features/addProfileInfo/presentation/widgets/upload_camera_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';

class AddPhotoWidget extends StatelessWidget {
  const AddPhotoWidget({super.key});

  @override
  Widget build(BuildContext context) {
     return BlocConsumer<ProfileInfoCubit, ProfileInfoState>(
      listener: (context, state) {
        if (state is PickedImageErrorState || state is UploadImageErrorState) {
          ToastMessageService().showMessage(
            'An error occurred while processing the image',
            MessageType.error,
          );
        }
      },
      builder: (context, state) {
        final bool isLoading = state is ProfileInfoLoadingState;
        final String? imagePath = state is PickedImageSuccessState ? state.localImagePath : null;
        final String? imageUrl = state is UploadImageSuccessState ? state.imageUrl : null;

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppStrings.childPhoto, style: ts18Purble700),
                SizedBox(height: 12.h),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    UploadCameraField(
                      icon: AppIcons.upload,
                      text: "Upload",
                      onTap: isLoading
                          ? null
                          : () => context
                              .read<ProfileInfoCubit>()
                              .pickImageFromGallery(),
                    ),
                    SizedBox(width: 12.w),
                    UploadCameraField(
                      icon: AppIcons.camera,
                      text: "Camera",
                      onTap: isLoading
                          ? null
                          : () => context
                              .read<ProfileInfoCubit>()
                              .pickImageFromCamera(),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(width: 12.w),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 170.w,
                  height: 170.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: (imagePath != null || imageUrl != null)
                        ? DecorationImage(
                            image: imagePath != null
                                ? FileImage(File(imagePath)) as ImageProvider
                                : NetworkImage(imageUrl!),
                            fit: BoxFit.cover,
                          )
                        : const DecorationImage(
                            image: AssetImage(AppImages.defaultUploadImage),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                if (isLoading)
                  Container(
                    width: 170.w,
                    height: 170.h,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}
