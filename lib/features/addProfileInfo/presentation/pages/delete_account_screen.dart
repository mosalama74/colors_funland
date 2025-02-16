import 'package:color_funland/core/components/custom_text_field.dart';
import 'package:color_funland/core/components/elevated_btn.dart';
import 'package:color_funland/core/constants/app_common_padding.dart';
import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/core/constants/app_strings.dart';
import 'package:color_funland/core/utils/app_colors.dart';
import 'package:color_funland/core/utils/text_styles.dart';
import 'package:color_funland/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:color_funland/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({
    super.key,
  });

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  final _deleteController = TextEditingController();
  final _confirmDeleteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _deleteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
         if (state is DeleteAccountSuccess){
          Navigator.pushReplacementNamed(context,'/' );
         }
         
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: Padding(
                  padding: AppCommonPadding.screenOuterPadding,
                  child: SingleChildScrollView(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.r),
                      ),
                      color: AppColors.cWhiteColor,
                      elevation: 5,
                      child: Padding(
                        padding: AppCommonPadding.screenInnerPadding,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Logo
                              logoImage,
                              SizedBox(height: 42.h),
                              Text(
                                AppStrings.deleteAccount,
                                style: ts52Black400,
                              ),
                              SizedBox(height: 24.h),
                              Text(
                                AppStrings.deleteAccountText,
                                style: ts16Grey700,
                              ),
                              SizedBox(height: 32.h),

                              Text(
                                AppStrings.confirmDelete,
                                style: ts18Purble700,
                              ),
                              SizedBox(height: 17.h),
                              CustomTextField(
                                controller: _confirmDeleteController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Type  DELETE is required';
                                  }
                                  return null;
                                },
                              ),
                           
                              SizedBox(height: 32.h),

                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: ElevatedBtn(
                                      isDelete: true,
                                      text: AppStrings.delete,
                                      onPressed: () {
                                        if (_formKey.currentState!.validate() && _confirmDeleteController.text == "DELETE"){
                                                  context.read<AuthCubit>().deleteAccount();
                                                }
                                      },
                                      width: double.infinity,
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    flex: 1,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 12.h),
                                        backgroundColor: AppColors.cWhiteColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0.r)),
                                      ),
                                      child: Text(
                                        AppStrings.cancel,
                                        style: ts17Black700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 46.h),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
