import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'cast_payment_manager_controller.dart';
import 'component/data_table_payment.dart';

class CastPaymentManagerPage extends GetView<CastPaymentManagerController> {
  const CastPaymentManagerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Responsive(
      mobile: CastPaymentManagerDesktopPage(controller: controller),
      desktop: CastPaymentManagerDesktopPage(controller: controller),
    ));
  }
}

class CastPaymentManagerDesktopPage extends StatelessWidget {
  const CastPaymentManagerDesktopPage({super.key, required this.controller});

  final CastPaymentManagerController controller;

  Widget _buildDropdown({required String label, required Widget dropdown}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: tButtonWhiteTextStyle.copyWith(
              fontSize: 24, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: kSmallPadding),
        dropdown,
      ],
    );
  }

  Widget _buildMinMaxDate({required bool minDate}) {
    return Obx(() {
      return InkWell(
        onTap: () {
          controller.selectDate(minDate);
        },
        child: Container(
          height: 49,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  formatDateTime(
                      date: minDate
                          ? controller.minDate.value
                          : controller.maxDate.value,
                      formatString: DateTimeFormatString.textBehind),
                  style: tNormalTextStyle,
                ),
              ),
              const Icon(Icons.date_range_rounded,
                  color: kTextColorDark, size: 18),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildDropdownTransferStatus() {
    return Obx(() {
      return Container(
        height: 49,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
              isExpanded: true,
              value: controller.transferStatus.value,
              onChanged: controller.onChangeTransferStatus,
              items: controller.listTransferStatus.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(
                    'transfer_status_$item'.tr,
                    style:
                        tButtonWhiteTextStyle.copyWith(color: kTextColorDark),
                  ),
                );
              }).toList()),
        ),
      );
    });
  }

  Widget _buildDropdownChangeStatus() {
    return Obx(() {
      return Container(
        height: 49,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                      isExpanded: true,
                      value: controller.changeStatus.value,
                      onChanged: controller.onChangeChangeStatus,
                      items: controller.listTransferStatus.map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(
                            'transfer_status_$item'.tr,
                            style: tButtonWhiteTextStyle.copyWith(
                                color: kTextColorDark),
                          ),
                        );
                      }).toList()),
                ),
              ),
            ),
            InkWell(
              onTap: controller.onTapChangeStatus,
              child: Container(
                height: 49,
                decoration: const BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(4),
                        bottomRight: Radius.circular(4))),
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Text(
                  'change'.tr,
                  style: tButtonWhiteTextStyle.copyWith(fontSize: 14),
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  Widget _buildSearchView() {
    return Container(
      height: 49,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      padding: const EdgeInsets.only(left: kDefaultPadding),
      alignment: Alignment.center,
      child: TextField(
        controller: controller.searchController,
        style: tNormalTextStyle,
        textAlignVertical: TextAlignVertical.center,
        cursorColor: getColorPrimary(),
        onChanged: controller.onChanged,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          hintText: 'search'.tr,
          filled: true,
          fillColor: Colors.white,
          hintStyle: tNormalTextStyle.copyWith(color: kHintColor),
          disabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          isDense: true,
          suffixIcon: const Icon(
            Icons.search_rounded,
            color: kTextColorDark,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: _buildDropdown(
                      label: 'transfer_status'.tr,
                      dropdown: _buildDropdownTransferStatus()),
                ),
                const SizedBox(width: kDefaultPadding),
                Expanded(
                  flex: 4,
                  child: _buildDropdown(
                      label: 'min_date'.tr,
                      dropdown: _buildMinMaxDate(minDate: true)),
                ),
                const SizedBox(width: kDefaultPadding),
                Expanded(
                  flex: 4,
                  child: _buildDropdown(
                      label: 'max_date'.tr,
                      dropdown: _buildMinMaxDate(minDate: false)),
                ),
                const SizedBox(width: kDefaultPadding),
                Expanded(
                  flex: 6,
                  child: _buildDropdown(
                      label: 'search_short'.tr, dropdown: _buildSearchView()),
                ),
                const SizedBox(width: kDefaultPadding),
                _buildDropdown(
                  label: '',
                  dropdown: Container(
                    height: 49,
                    width: 49,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.file_download_outlined),
                      onPressed: controller.exportExcel,
                    ),
                  ),
                ),
                const SizedBox(width: kDefaultPadding),
              ],
            ),
            const SizedBox(height: kDefaultPadding),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: _buildDropdown(
                      label: 'change_status'.tr,
                      dropdown: _buildDropdownChangeStatus()),
                ),
                const Expanded(flex: 7, child: SizedBox()),
              ],
            ),
            const SizedBox(height: kDefaultPadding),
            Expanded(
              child: Obx(() {
                return DataTablePayment(
                  list: controller.list.toList(),
                  onScrollDown: controller.onScrollDown,
                  isEmpty: controller.checkEmpty(),
                  onCheckBox: controller.onCheckBox,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
