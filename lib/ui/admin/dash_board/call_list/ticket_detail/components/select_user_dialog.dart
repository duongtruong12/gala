import 'package:base_flutter/components/custom_button.dart';
import 'package:base_flutter/components/custom_circle_image.dart';
import 'package:base_flutter/components/custom_network_image.dart';
import 'package:base_flutter/components/paging_list.dart';
import 'package:base_flutter/model/user_model.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class SelectUserDialog extends StatefulWidget {
  const SelectUserDialog(
      {super.key,
      required this.setter,
      required this.maxUser,
      required this.switchUserDetail,
      required this.switchMessageDetail});

  final ValueSetter<List<String?>> setter;
  final ValueSetter<String?> switchUserDetail;
  final ValueSetter<String?> switchMessageDetail;
  final int? maxUser;

  @override
  SelectUserDialogState createState() => SelectUserDialogState();
}

class SelectUserDialogState extends State<SelectUserDialog> {
  final list = <UserModel>[];
  final mapSelect = <String?, bool>{};
  DocumentSnapshot? lastDoc;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getData();
    });
  }

  Future<void> getData() async {
    final listDoc = await fireStoreProvider.getListUser(
        lastDocument: lastDoc,
        sort: TypeAccount.caster,
        sortPeopleApprove: true);
    if (listDoc.isNotEmpty) {
      lastDoc = listDoc.last;
      for (var value in listDoc) {
        if (value.data() != null) {
          final userModel = UserModel.fromJson(value.data()!);
          list.add(userModel);
        }
      }
    }
    if (mounted) setState(() {});
  }

  Widget _buildAppBar() {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        InkWell(onTap: Get.back, child: getSvgImage('ic_close')),
        Center(
          child: Text(
            'people_approve'.tr,
            style: tNormalTextStyle.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildItemUser(UserModel userData) {
    return Column(
      children: [
        const SizedBox(height: kSmallPadding),
        Row(
          children: [
            Checkbox(
                value: mapSelect[userData.id] == true,
                onChanged: (value) {
                  if (mapSelect[userData.id] == true) {
                    mapSelect.remove(userData.id);
                  } else {
                    if (widget.maxUser == null ||
                        widget.maxUser == mapSelect.length) {
                      return;
                    }
                    mapSelect.putIfAbsent(userData.id, () => true);
                  }
                  if (mounted) setState(() {});
                }),
            const SizedBox(width: kSmallPadding),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomCircleImage(
                      radius: 99,
                      image: CustomNetworkImage(
                        url: userData.avatar,
                        fit: BoxFit.cover,
                        height: 78,
                        width: 78,
                      )),
                  const SizedBox(width: kSmallPadding),
                  Text(
                    '${userData.getAge()} ${userData.displayName ?? ''}',
                    style: tNormalTextStyle.copyWith(
                        fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(width: kDefaultPadding),
            Padding(
              padding: const EdgeInsets.all(kSmallPadding),
              child: CustomButton(
                width: 120,
                height: 40,
                onPressed: () async {
                  widget.switchMessageDetail(userData.id);
                },
                borderColor: kTextColorDark,
                color: Colors.white,
                borderRadius: kSmallPadding,
                widget: Text(
                  'message'.tr,
                  style: tNormalTextStyle,
                ),
              ),
            ),
            const SizedBox(width: kDefaultPadding),
            Padding(
              padding: const EdgeInsets.all(kSmallPadding),
              child: CustomButton(
                width: 120,
                height: 40,
                onPressed: () async {
                  widget.switchUserDetail(userData.id);
                },
                borderColor: kTextColorDark,
                color: Colors.white,
                borderRadius: kSmallPadding,
                widget: Text(
                  'detail'.tr,
                  style: tNormalTextStyle,
                ),
              ),
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.7,
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(),
            Expanded(
                child: list.isEmpty
                    ? const Center(
                        child: SizedBox(
                        width: 32,
                        height: 32,
                        child: CircularProgressIndicator(),
                      ))
                    : PagingListCustom(
                        onRefresh: (_) {
                          list.clear();
                          lastDoc = null;
                          getData();
                        },
                        onScrollDown: (_) {
                          getData();
                        },
                        childWidget:
                            list.map((e) => _buildItemUser(e)).toList(),
                      )),
            CustomButton(
                color: kPrimaryColor,
                borderColor: kPrimaryColor,
                onPressed: () async {
                  Get.back(closeOverlays: true);
                  widget.setter(mapSelect.keys.toList());
                },
                widget: Text(
                  'confirm'.tr,
                  style: tButtonWhiteTextStyle.copyWith(color: kTextColorDark),
                ))
          ],
        ),
      ),
    );
  }
}
