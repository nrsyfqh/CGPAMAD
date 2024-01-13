import 'package:cgpa_application/core/app_export.dart';
import 'package:cgpa_application/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:cgpa_application/widgets/app_bar/appbar_title.dart';
import 'package:cgpa_application/widgets/app_bar/custom_app_bar.dart';
import 'package:cgpa_application/widgets/custom_elevated_button.dart';
import 'package:cgpa_application/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: Form(
                key: _formKey,
                child: SingleChildScrollView(
                    padding: EdgeInsets.only(top: 11.v),
                    child: Container(
                        margin: EdgeInsets.only(bottom: 5.v),
                        padding: EdgeInsets.symmetric(horizontal: 32.h),
                        child: Column(children: [
                          _buildPageHeader(context),
                          SizedBox(height: 21.v),
                          CustomTextFormField(
                              controller: emailController,
                              hintText: "Email",
                              textInputType: TextInputType.emailAddress,
                              borderDecoration: TextFormFieldStyleHelper
                                  .outlineOnPrimaryTL14),
                          SizedBox(height: 24.v),
                          CustomTextFormField(
                              controller: passwordController,
                              hintText: "Password",
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.visiblePassword,
                              obscureText: true,
                              borderDecoration: TextFormFieldStyleHelper
                                  .outlineOnPrimaryTL14),
                          SizedBox(height: 26.v),
                          CustomElevatedButton(
                              text: "Next",
                              onPressed: () {
                                onTapNext(context);
                              }),
                          SizedBox(height: 33.v),
                          GestureDetector(
                              onTap: () {
                                onTapDonTHaveAnAccount(context);
                              },
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(bottom: 1.v),
                                        child: Text("Don’t have an account?",
                                            style: theme.textTheme.labelLarge)),
                                    Padding(
                                        padding: EdgeInsets.only(left: 8.h),
                                        child: Text("SignUp",
                                            style: CustomTextStyles
                                                .labelLargeSecondaryContainerSemiBold))
                                  ]))
                        ]))))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 56.h,
        leading: AppbarLeadingIconbutton(
            imagePath: ImageConstant.imgArrowLeft,
            margin: EdgeInsets.only(left: 32.h, top: 14.v, bottom: 17.v),
            onTap: () {
              onTapArrowLeft(context);
            }),
        actions: [
          AppbarTitle(
              text: "Login",
              margin: EdgeInsets.symmetric(horizontal: 48.h, vertical: 14.v))
        ]);
  }

  /// Section Widget
  Widget _buildPageHeader(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          width: 221.h,
          margin: EdgeInsets.only(right: 89.h),
          child: Text("CGPA Application",
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.displaySmall!.copyWith(height: 1.18))),
      SizedBox(height: 1.v),
      Container(
          width: 282.h,
          margin: EdgeInsets.only(right: 28.h),
          )
    ]);
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the forgotPasswordScreen when the action is triggered.
  onTapTxtForgotPasswor(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.forgotPasswordScreen);
  }

  /// Navigates to the signupScreen when the action is triggered.
  onTapNext(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signupScreen);
  }

  /// Navigates to the signupScreen when the action is triggered.
  onTapDonTHaveAnAccount(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signupScreen);
  }
}
