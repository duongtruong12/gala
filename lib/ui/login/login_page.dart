import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/components/custom_button.dart';
import 'package:base_flutter/components/gradient_text.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/validate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_controller.dart';

const radiusLoginBorder = BorderRadius.all(Radius.circular(99.0));

const defaultBorderLoginRounded = OutlineInputBorder(
    borderRadius: radiusLoginBorder,
    borderSide: BorderSide(color: kTextColorDarkLight));
const focusedBorderLoginRounded = OutlineInputBorder(
    borderRadius: radiusLoginBorder,
    borderSide: BorderSide(color: kGradientLogin1));
const errorBorderLoginRounded = OutlineInputBorder(
    borderRadius: radiusLoginBorder,
    borderSide: BorderSide(color: kErrorColor));

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Responsive(
      mobile: LoginMobilePage(controller: controller),
      desktop: LoginMobilePage(controller: controller),
    ));
  }
}

class LoginMobilePage extends StatelessWidget {
  const LoginMobilePage({super.key, required this.controller});

  final LoginController controller;

  Widget _buildEmail() {
    return TextFormField(
      controller: controller.emailController,
      validator: Validate.emailValidate,
      decoration: InputDecoration(
          hintText: 'email'.tr,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          border: defaultBorderLoginRounded,
          focusedBorder: focusedBorderLoginRounded,
          enabledBorder: defaultBorderLoginRounded,
          errorBorder: errorBorderLoginRounded,
          focusedErrorBorder: errorBorderLoginRounded),
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      controller: controller.passController,
      validator: Validate.passwordValidate,
      obscureText: true,
      onFieldSubmitted: (value) {
        controller.onLogin();
      },
      decoration: InputDecoration(
          hintText: 'password'.tr,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          border: defaultBorderLoginRounded,
          focusedBorder: focusedBorderLoginRounded,
          enabledBorder: defaultBorderLoginRounded,
          errorBorder: errorBorderLoginRounded,
          focusedErrorBorder: errorBorderLoginRounded),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: ListView(
          children: [
            SizedBox(
              height: Get.height / 2,
              child: Center(
                child: GradientText(
                  'Claha',
                  style: tNormalTextStyle.copyWith(fontSize: 68),
                  gradient: kLoginGradient,
                ),
              ),
            ),
            Form(
              key: controller.formKey,
              child: Column(
                children: [
                  _buildEmail(),
                  const SizedBox(height: kDefaultPadding),
                  _buildPassword(),
                  const SizedBox(height: kDefaultPadding * 2),
                  CustomButton(
                      onPressed: controller.onLogin,
                      borderRadius: kSmallPadding,
                      gradient: kLoginGradient,
                      loginPage: true,
                      widget: Text(
                        'login'.tr,
                        style: tButtonWhiteTextStyle.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
