import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/components/gradient_text.dart';
import 'package:base_flutter/components/paging_grid.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:base_flutter/ui/screen/home/dash_board/search/components/item_target.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'search_controller.dart';

class SearchPage extends GetView<SearchController> {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Responsive(
      mobile: SearchMobilePage(controller: controller),
      desktop: SearchMobilePage(controller: controller),
    ));
  }
}

class SearchMobilePage extends StatelessWidget {
  const SearchMobilePage({super.key, required this.controller});

  final SearchController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GradientText(
            'home_label'.tr,
            gradient: kButtonBackground,
            style: tNormalTextStyle.copyWith(
                fontSize: 19, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: kDefaultPadding),
          InkWell(
            onTap: controller.onSwitchSearchDetail,
            child: Container(
              decoration: const BoxDecoration(
                color: kTextColorSecond,
                borderRadius: radiusBorder,
              ),
              padding: const EdgeInsets.symmetric(
                  vertical: kSmallPadding, horizontal: kDefaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      getSvgImage('ic_soft'),
                      const SizedBox(width: 8),
                      Text(
                        'search'.tr,
                        style: tNormalTextStyle.copyWith(color: kTextColorDark),
                      ),
                    ],
                  ),
                  getSvgImage('ic_search')
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Obx(() {
              return PagingGridCustom(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  childWidget: controller.list
                      .map((element) => ItemTarget(
                            model: element,
                            onPressed: () {
                              controller.onSwitchFemaleDetail(element.age ?? 0);
                            },
                          ))
                      .toList());
            }),
          ),
        ],
      ),
    );
  }
}
