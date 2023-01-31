import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/components/custom_appbar.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:selectable_autolink_text/selectable_autolink_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'right_controller.dart';

class RightTermPage extends GetView<RightTermController> {
  const RightTermPage({
    Key? key,
    required this.label,
  }) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Responsive(
      mobile: MobileRightTermPage(controller: controller, label: label),
      desktop: MobileRightTermPage(controller: controller, label: label),
    ));
  }
}

class MobileRightTermPage extends StatelessWidget {
  final RightTermController controller;
  final String label;

  const MobileRightTermPage({
    super.key,
    required this.controller,
    required this.label,
  });

  Widget _buildBody() {
    final list = <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
        child: Center(
          child: Text(
            'Claha',
            style: tNormalTextStyle.copyWith(
                fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      const SizedBox(height: kDefaultPadding),
      FutureBuilder<String>(
          future: controller.getFileData(label),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.data == null || snapshot.data!.isEmpty) {
              return const Center(
                child: SizedBox(
                  height: 32,
                  width: 32,
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return SelectableAutoLinkText(
              snapshot.data ?? '',
              onTap: (link) async {
                await launchUrl(Uri.parse(link));
              },
              style: tNormalTextStyle.copyWith(fontSize: 6),
              linkStyle:
                  tNormalTextStyle.copyWith(fontSize: 6, color: Colors.blue),
            );
          }),
    ];
    return ListView.builder(
      itemCount: list.length,
      padding: const EdgeInsets.all(kDefaultPadding),
      itemBuilder: (BuildContext context, int index) {
        return list[index];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbarCustom(
          title: Text(
            label.tr,
            style: tNormalTextStyle.copyWith(
                fontSize: 12, fontWeight: FontWeight.w500),
          ),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: controller.onPressedBack,
                icon: const Icon(
                  Icons.close_rounded,
                  color: kTextColorDark,
                ))
          ],
          backgroundColor: const Color(0xFFF9F9F9)),
      body: _buildBody(),
    );
  }
}
