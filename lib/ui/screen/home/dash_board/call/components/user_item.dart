import 'package:base_flutter/components/custom_network_image.dart';
import 'package:base_flutter/model/user_model.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:flutter/material.dart';

class UserItem extends StatelessWidget {
  final UserModel model;
  final VoidCallback onPressed;
  final bool showNickName;

  const UserItem({
    Key? key,
    required this.model,
    required this.onPressed,
    this.showNickName = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 134,
          height: 163,
          child: InkWell(
              onTap: onPressed,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CustomNetworkImage(
                    url: model.avatar,
                    width: 134,
                    height: 163,
                    borderRadius: 0,
                  ),
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(vertical: kDefaultPadding),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                          Colors.black,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0, 0.3, 0.7, 1],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (showNickName)
                          Text(
                            '${model.realName}',
                            style: tNormalTextStyle.copyWith(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: kTextColorPrimary),
                          ),
                        Text(
                          '${model.getAge()}  ${model.displayName}',
                          style: tNormalTextStyle.copyWith(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: kTextColorPrimary),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          formatCurrency(model.pointPer30Minutes,
                              symbol: CurrencySymbol.pointPerMinutes),
                          style: tNormalTextStyle.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: kTextColorSecond),
                        ),
                      ],
                    ),
                  )
                ],
              )),
        ),
        const SizedBox(width: kDefaultPadding),
      ],
    );
  }
}
