import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/components/custom_appbar.dart';
import 'package:base_flutter/components/custom_view.dart';
import 'package:base_flutter/components/paging_list.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:base_flutter/ui/screen/home/dash_board/message/components/message_group.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'message_controller.dart';

class MessagePage extends GetView<MessageController> {
  const MessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Responsive(
        mobile: MessageMobilePage(controller: controller),
        desktop: MessageMobilePage(controller: controller),
      ),
    );
  }
}

class MessageMobilePage extends StatelessWidget {
  const MessageMobilePage({super.key, required this.controller});

  final MessageController controller;

  Widget _buildSearchView() {
    return TextFormField(
      style: tNormalTextStyle.copyWith(color: kTextColorSecond),
      cursorColor: getColorPrimary(),
      onChanged: controller.onChanged,
      decoration: InputDecoration(
        hintText: 'search'.tr,
        filled: true,
        fillColor: kTextFieldBackground,
        hintStyle: tNormalTextStyle.copyWith(color: kHintColor),
        disabledBorder: defaultBorderRounded,
        errorBorder: errorBorderRounded,
        focusedBorder: focusedBorderRounded,
        enabledBorder: defaultBorderRounded,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        isDense: true,
        suffixIcon: const Icon(
          Icons.search_rounded,
          color: kTextColorSecond,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: user.value?.isAdminAccount() == true
          ? null
          : appbarCustom(
              title: Text('message_list'.tr),
              automaticallyImplyLeading: false,
            ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (user.value?.isAdminAccount() != true) _buildSearchView(),
            Obx(() {
              if (controller.list.isEmpty) {
                return textEmpty();
              }

              return Expanded(
                child: PagingListCustom(
                    onRefresh: controller.onRefresh,
                    onScrollDown: controller.onScrollDown,
                    isEmpty: controller.checkEmpty(),
                    childWidget: controller.list
                        .map((element) => InkWell(
                              onTap: () {
                                controller.onSwitchMessageDetail(element.id);
                              },
                              child: MessageGroupItem(model: element),
                            ))
                        .toList()),
              );
            })
          ],
        ),
      ),
    );
  }
}
