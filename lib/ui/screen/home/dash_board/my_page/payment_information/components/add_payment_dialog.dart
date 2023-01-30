import 'package:base_flutter/components/custom_button.dart';
import 'package:base_flutter/model/payment_model.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/validate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:get/get.dart';

class AddPaymentDialog extends StatefulWidget {
  const AddPaymentDialog({super.key, required this.setter});

  final ValueSetter<PaymentModel> setter;

  @override
  AddPaymentDialogState createState() => AddPaymentDialogState();
}

class AddPaymentDialogState extends State<AddPaymentDialog> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _cardCVVController = TextEditingController();
  final _cardExpiryController = TextEditingController();

  Widget _buildAppBar() {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        InkWell(onTap: Get.back, child: getSvgImage('ic_close')),
        Center(
          child: Text(
            'add_payment_title'.tr,
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
    required TextInputFormatter inputFormatter,
    required String label,
  }) {
    return TextFormField(
      controller: controller,
      inputFormatters: [inputFormatter],
      style:
          tNormalTextStyle.copyWith(fontSize: 12, color: kTextColorDarkLight),
      validator: (str) {
        return Validate.emptyValidate(str: str, field: label);
      },
      decoration: InputDecoration(
          labelText: label,
          labelStyle: tNormalTextStyle.copyWith(
              fontSize: 12, fontWeight: FontWeight.w500),
          enabledBorder: defaultBorder.copyWith(
              borderSide: const BorderSide(color: kTextColorDark, width: 1))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding * 2),
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(),
              const SizedBox(height: kDefaultPadding * 2),
              _buildTextFormField(
                  controller: _cardNumberController,
                  inputFormatter: CreditCardNumberInputFormatter(),
                  label: 'card_number'.tr),
              const SizedBox(height: kDefaultPadding),
              _buildTextFormField(
                  controller: _cardExpiryController,
                  inputFormatter: CreditCardExpirationDateFormatter(),
                  label: 'card_expiry'.tr),
              const SizedBox(height: kDefaultPadding),
              _buildTextFormField(
                  controller: _cardCVVController,
                  inputFormatter: CreditCardCvcInputFormatter(),
                  label: 'card_cvr'.tr),
              const SizedBox(height: kDefaultPadding),
              CustomButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() == true) {
                      widget.setter(PaymentModel(
                          id: _cardNumberController.text,
                          cardNumber: _cardNumberController.text,
                          cardCVV: _cardCVVController.text,
                          cardExpiredDate: _cardExpiryController.text));
                    }
                  },
                  color: kPurchaseColor,
                  widget: Text(
                    'save_card'.tr,
                    style: tNormalTextStyle.copyWith(
                        color: kTextColorSecond, fontWeight: FontWeight.w500),
                  )),
              const SizedBox(height: kDefaultPadding),
              Text(
                'add_payment_content'.tr,
                style: tNormalTextStyle.copyWith(
                    color: kTextColorDarkLight, fontSize: 12),
              ),
              const SizedBox(height: kDefaultPadding),
            ],
          ),
        ),
      ),
    );
  }
}
