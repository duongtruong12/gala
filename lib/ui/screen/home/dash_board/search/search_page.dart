import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/components/paging_grid.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:base_flutter/ui/screen/home/dash_board/search/components/item_target.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components/app_bar_search.dart';
import 'search_controller.dart' as search;

class SearchPage extends GetView<search.SearchController> {
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

  final search.SearchController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(() {
          return AppBarSearch(
            onPressed: controller.onSwitchSearchDetail,
            femaleGender: casterAccount.value,
          );
        }),
        Expanded(
          child: Obx(() {
            return Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: PagingGridCustom(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  onScrollDown: controller.onScrollDown,
                  onRefresh: controller.onRefresh,
                  childWidget: controller.list
                      .map((element) => ItemTarget(
                            model: element,
                            femaleGender: casterAccount.value,
                            onPressed: () {
                              controller.onSwitchFemaleDetail(element.id);
                            },
                          ))
                      .toList()),
            );
          }),
        ),
      ],
    );
  }
}
