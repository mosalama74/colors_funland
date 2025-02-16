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

  // Future<void> _showImageSourceDialog(BuildContext context) async {
  //   final bool isLoading = context.read<ProfileInfoCubit>().state.status ==
  //       ProfileInfoStatus.loading;
  //   if (isLoading) return;

  //   final cubit = context.read<ProfileInfoCubit>();

  //   showDialog(
  //     context: context,
  //     builder: (dialogContext) {
  //       return AlertDialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(15.r),
  //         ),
  //         title: Text(
  //           'Choose Image Source',
  //           style: ts18Purble700,
  //         ),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             ListTile(
  //               leading: const Icon(Icons.photo_library),
  //               title: const Text('Gallery'),
  //               onTap: () {
  //                 Navigator.pop(dialogContext);
  //                 cubit.pickImageFromGallery();
  //               },
  //             ),
  //             ListTile(
  //               leading: const Icon(Icons.camera_alt),
  //               title: const Text('Camera'),
  //               onTap: () {
  //                 Navigator.pop(dialogContext);
  //                 cubit.pickImageFromCamera();
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileInfoCubit, ProfileInfoState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == ProfileInfoStatus.failure,
      listener: (context, state) {
        if (state.status == ProfileInfoStatus.failure) {
          ToastMessageService().showMessage(
            state.errorMessage ?? 'An error occurred',
            MessageType.error,
          );
        }
      },
      builder: (context, state) {
        final bool isLoading = state.status == ProfileInfoStatus.loading;

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
                      onTap:  isLoading
                          ? null
                          : () => context
                              .read<ProfileInfoCubit>()
                              .pickImageFromGallery(),
                      // onTap: (state.localImagePath != null &&
                      //         state.imageUrl == null)
                      //     ? () => context
                      //         .read<ProfileInfoCubit>()
                      //         .uploadSelectedImage()
                      //     : null,
                    ),
                    SizedBox(width: 10.w),
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
                  height: 180.h,
                  width: 180.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: _getImageProvider(state),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (isLoading)
                  Container(
                    height: 180.h,
                    width: 180.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(0.5),
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

  ImageProvider _getImageProvider(ProfileInfoState state) {
    if (state.localImagePath != null) {
      return FileImage(File(state.localImagePath!));
    }
    if (state.imageUrl != null) {
      return NetworkImage(state.imageUrl!);
    }
    return const AssetImage(AppImages.defaultUploadImage);
  }
}
