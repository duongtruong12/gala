import 'package:base_flutter/components/custom_button.dart';
import 'package:base_flutter/model/user_model.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/validate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterUserDialog extends StatefulWidget {
  const RegisterUserDialog({
    super.key,
    required this.setter,
    required this.typeAccount,
  });

  final ValueSetter<UserModel> setter;
  final TypeAccount typeAccount;

  @override
  RegisterUserDialogState createState() => RegisterUserDialogState();
}

class RegisterUserDialogState extends State<RegisterUserDialog> {
  final _formKey = GlobalKey<FormState>();
  final _realNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _displayNameController = TextEditingController();

  Widget _buildAppBar() {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        InkWell(onTap: Get.back, child: getSvgImage('ic_close')),
        Center(
          child: Text(
            'create_user'.tr,
            style: tNormalTextStyle.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String? Function(String?)? validator,
    required String label,
  }) {
    return TextFormField(
      controller: controller,
      style:
          tNormalTextStyle.copyWith(fontSize: 12, color: kTextColorDarkLight),
      validator: validator,
      decoration: InputDecoration(
          labelText: label,
          labelStyle: tNormalTextStyle.copyWith(
              fontSize: 12, fontWeight: FontWeight.w500),
          enabledBorder: defaultBorder.copyWith(
              borderSide: const BorderSide(color: kTextColorDark, width: 1))),
    );
  }

  String? _validatorNickName(String? str) {
    return Validate.emptyValidate(str: str, field: 'nick_name'.tr);
  }

  String? _validatorRealName(String? str) {
    return Validate.emptyValidate(str: str, field: 'real_name'.tr);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width / 2,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(),
            const SizedBox(height: kDefaultPadding * 2),
            _buildTextFormField(
              controller: _displayNameController,
              label: 'nick_name'.tr,
              validator: _validatorNickName,
            ),
            const SizedBox(height: kDefaultPadding),
            _buildTextFormField(
              controller: _realNameController,
              label: 'real_name'.tr,
              validator: _validatorRealName,
            ),
            const SizedBox(height: kDefaultPadding),
            _buildTextFormField(
              controller: _emailController,
              label: 'email'.tr,
              validator: Validate.emailValidate,
            ),
            const SizedBox(height: kDefaultPadding),
            _buildTextFormField(
              controller: _passwordController,
              label: 'password'.tr,
              validator: Validate.passwordValidate,
            ),
            const SizedBox(height: kDefaultPadding),
            CustomButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() == true) {
                    widget.setter(UserModel(
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim(),
                      displayName: _displayNameController.text.trim(),
                      realName: _realNameController.text.trim(),
                      previewImage: [],
                      tagInformation: [],
                      typeAccount: widget.typeAccount.name,
                      currentPoint: 0,
                      createdDate: DateTime.now(),
                      applyTickets: [],
                    ));
                  }
                },
                color: kPurchaseColor,
                widget: Text(
                  'confirm'.tr,
                  style: tNormalTextStyle.copyWith(
                      color: kTextColorSecond, fontWeight: FontWeight.w500),
                )),
            const SizedBox(height: kDefaultPadding),
          ],
        ),
      ),
    );
  }
}
