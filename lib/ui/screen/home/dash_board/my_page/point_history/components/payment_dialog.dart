import 'dart:convert';

import 'package:base_flutter/components/custom_button.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import 'package:get/get.dart';

class PaymentDialog extends StatefulWidget {
  const PaymentDialog({super.key, required this.cost, required this.point});

  final int? cost;
  final int? point;

  @override
  PaymentDialogState createState() => PaymentDialogState();
}

class PaymentDialogState extends State<PaymentDialog> {
  final _formKey = GlobalKey<FormState>();
  late final stripe.CardEditController controller = stripe.CardEditController();
  late stripe.CardFieldInputDetails? details;

  Widget _buildAppBar() {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        InkWell(onTap: Get.back, child: getSvgImage('ic_close')),
        Center(
          child: Text(
            'payment_information'.tr,
            style: tNormalTextStyle.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
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
              stripe.CardField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: 'payment_information'.tr,
                  labelStyle: tNormalTextStyle.copyWith(
                      fontSize: 12, fontWeight: FontWeight.w500),
                  enabledBorder: defaultBorder.copyWith(
                    borderSide:
                        const BorderSide(color: kTextColorDark, width: 1),
                  ),
                ),
                onCardChanged: (card) {
                  details = card;
                },
                dangerouslyGetFullCardDetails: true,
                autofocus: true,
                style: tButtonWhiteTextStyle,
              ),
              const SizedBox(height: kDefaultPadding),
              CustomButton(
                  onPressed: () async {
                    if (controller.complete) {
                      try {
                        final response = await apiProvider.stripePayment(json
                            .encode({
                          'email': user.value?.email,
                          'amount': widget.cost.toString()
                        }));

                        if (response['success'] == true) {
                          final paymentIntent =
                              await stripe.Stripe.instance.confirmPayment(
                            paymentIntentClientSecret:
                                response['paymentIntent'],
                            data: const stripe.PaymentMethodParams.card(
                              paymentMethodData: stripe.PaymentMethodData(),
                            ),
                            options: const stripe.PaymentMethodOptions(
                              setupFutureUsage:
                                  stripe.PaymentIntentsFutureUsage.OnSession,
                            ),
                          );
                          if (paymentIntent.status ==
                              stripe.PaymentIntentsStatus.Succeeded) {
                            await fireStoreProvider.addPoint(
                                point: widget.point);
                            showInfo('payment_successfully'.tr);
                          } else {
                            showError('payment_failed'.tr);
                          }
                        } else {
                          showError('payment_failed'.tr);
                        }
                      } catch (e) {
                        if (e is stripe.StripeException) {
                          showError(e.error.localizedMessage ?? '');
                        } else {
                          showError('payment_failed'.tr);
                        }
                      } finally {
                        Get.back(closeOverlays: true);
                      }
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
