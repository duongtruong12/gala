import 'package:base_flutter/components/custom_button.dart';
import 'package:base_flutter/components/date_picker_dropdown.dart';
import 'package:base_flutter/model/city_model.dart';
import 'package:base_flutter/ui/screen/home/dash_board/call/components/chip_item_select.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:base_flutter/utils/validate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Widget buildLabelWidget(
    {required BuildContext context,
    required List<Widget> children,
    required String label}) {
  return Padding(
    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
    child: Container(
      padding: const EdgeInsets.all(kDefaultPadding),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: tNormalTextStyle.copyWith(
                fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const Divider(color: kTextColorDark),
          ...children
        ],
      ),
    ),
  );
}

class CustomInput extends StatefulWidget {
  const CustomInput(
      {Key? key,
      required this.myValueSetter,
      required this.label,
      required this.initText,
      this.nullable = false,
      this.numeric = false,
      this.validate,
      this.hint,
      this.maxLength,
      this.minLines = 1})
      : super(key: key);
  final ValueSetter<String?> myValueSetter;
  final String label;
  final bool numeric;
  final bool nullable;
  final String? initText;
  final String? hint;
  final int minLines;
  final int? maxLength;
  final String? Function(String? str)? validate;

  @override
  _CustomInput createState() => _CustomInput();
}

class _CustomInput extends State<CustomInput>
    with SingleTickerProviderStateMixin {
  final textEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    textEditingController.text = widget.initText ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return buildLabelWidget(
      context: context,
      label: widget.label,
      children: [
        Form(
          key: formKey,
          child: TextFormField(
            controller: textEditingController,
            minLines: widget.minLines,
            maxLines: null,
            autofocus: true,
            keyboardType:
                widget.numeric ? TextInputType.number : TextInputType.multiline,
            maxLength: widget.maxLength,
            decoration: InputDecoration(
                hintMaxLines: 14,
                focusedBorder: defaultBorder,
                disabledBorder: defaultBorder,
                border: defaultBorder,
                enabledBorder: defaultBorder,
                errorBorder: errorBorder,
                focusedErrorBorder: errorBorder,
                hintText: widget.hint ?? 'please_enter'.tr,
                hintStyle: tNormalTextStyle.copyWith(
                    fontSize: 12, color: kBorderColor)),
            validator: (str) {
              if (widget.nullable && str == null || str!.isEmpty) {
                return null;
              }
              if (widget.validate != null) {
                return widget.validate!(str);
              } else {
                return null;
              }
            },
          ),
        ),
        const SizedBox(height: 16),
        CustomButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                Get.back();
                if (widget.nullable && textEditingController.text.isEmpty) {
                  widget.myValueSetter(null);
                } else {
                  widget.myValueSetter(textEditingController.text);
                }
              }
            },
            color: getColorPrimary(),
            widget: Text(
              'save'.tr,
              style: tButtonWhiteTextStyle.copyWith(
                  fontSize: 14, fontWeight: FontWeight.w500),
            ))
      ],
    );
  }
}

class CustomInputPassword extends StatefulWidget {
  const CustomInputPassword({
    Key? key,
    required this.myValueSetter,
    required this.label,
  }) : super(key: key);
  final ValueSetter<String> myValueSetter;
  final String label;

  @override
  _CustomInputPassword createState() => _CustomInputPassword();
}

class _CustomInputPassword extends State<CustomInputPassword>
    with SingleTickerProviderStateMixin {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPassController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Widget _buildTextField(
      {required TextEditingController controller,
      required String? Function(String? str) validate,
      bool autoFocus = false,
      required String hintText}) {
    return TextFormField(
      controller: controller,
      autofocus: autoFocus,
      decoration: InputDecoration(
          focusedBorder: defaultBorder,
          disabledBorder: defaultBorder,
          border: defaultBorder,
          enabledBorder: defaultBorder,
          errorBorder: errorBorder,
          focusedErrorBorder: errorBorder,
          hintText: hintText,
          hintStyle:
              tNormalTextStyle.copyWith(fontSize: 12, color: kBorderColor)),
      validator: validate,
    );
  }

  String? validateCurrentPassword(String? str) {
    final box = GetStorage();
    return Validate.oldPasswordValidate(str, box.read(SharedPrefKey.password));
  }

  String? validateNewPass(String? str) {
    return Validate.passwordValidate(str);
  }

  String? validateConfirmPass(String? str) {
    return Validate.passwordConfirmValidate(
        password: newPasswordController.text, confPass: str);
  }

  @override
  Widget build(BuildContext context) {
    return buildLabelWidget(
      context: context,
      label: widget.label,
      children: [
        Form(
          key: formKey,
          child: Column(
            children: [
              _buildTextField(
                controller: currentPasswordController,
                validate: validateCurrentPassword,
                hintText: 'current_pass'.tr,
              ),
              _buildTextField(
                controller: newPasswordController,
                validate: validateNewPass,
                hintText: 'new_pass'.tr,
              ),
              _buildTextField(
                controller: confirmPassController,
                validate: validateConfirmPass,
                hintText: 'pass_confirm'.tr,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        CustomButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                Get.back();
                widget.myValueSetter(newPasswordController.text);
              }
            },
            color: getColorPrimary(),
            widget: Text(
              'save'.tr,
              style: tButtonWhiteTextStyle.copyWith(
                  fontSize: 14, fontWeight: FontWeight.w500),
            ))
      ],
    );
  }
}

class CustomInputDate extends StatefulWidget {
  const CustomInputDate({
    Key? key,
    required this.myValueSetter,
    required this.label,
    this.initDate,
  }) : super(key: key);
  final ValueSetter<DateTime> myValueSetter;
  final String label;
  final DateTime? initDate;

  @override
  _CustomInputDate createState() => _CustomInputDate();
}

class _CustomInputDate extends State<CustomInputDate>
    with SingleTickerProviderStateMixin {
  int? year, month, day;

  @override
  void initState() {
    super.initState();
    year = widget.initDate?.year;
    month = widget.initDate?.month;
    day = widget.initDate?.day;
  }

  Widget _buildYear() {
    return DropdownDatePicker(
      isDropdownHideUnderline: false,
      startYear: 1900,
      showMonth: true,
      showDay: true,
      showYear: true,
      selectedYear: year,
      selectedMonth: month,
      selectedDay: day,
      hintTextStyle:
          tNormalTextStyle.copyWith(fontSize: 12, color: kBorderColor),
      icon: '',
      textStyle: tNormalTextStyle,
      onChangedYear: (value) => year = value == null ? null : int.parse(value),
      onChangedDay: (value) => day = value == null ? null : int.parse(value),
      onChangedMonth: (value) =>
          month = value == null ? null : int.parse(value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.all(kDefaultPadding),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.label,
              style: tNormalTextStyle.copyWith(
                  fontSize: 12, fontWeight: FontWeight.w500),
            ),
            const Divider(
              color: kTextColorDark,
            ),
            _buildYear(),
            const SizedBox(height: 16),
            CustomButton(
                onPressed: () async {
                  if (year != null && month != null && day != null) {
                    widget.myValueSetter(DateTime(year!, month!, day!));
                  }
                  Get.back();
                },
                color: getColorPrimary(),
                widget: Text(
                  'save'.tr,
                  style: tButtonWhiteTextStyle.copyWith(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ))
          ],
        ),
      ),
    );
  }
}

class CustomSelectDropdown extends StatefulWidget {
  const CustomSelectDropdown({
    Key? key,
    required this.myValueSetter,
    required this.label,
    required this.map,
    this.init,
  }) : super(key: key);
  final ValueSetter<dynamic> myValueSetter;
  final String label;
  final dynamic init;
  final Map<String, dynamic> map;

  @override
  _CustomSelectDropdown createState() => _CustomSelectDropdown();
}

class _CustomSelectDropdown extends State<CustomSelectDropdown>
    with SingleTickerProviderStateMixin {
  dynamic init;

  @override
  void initState() {
    super.initState();
    init = widget.init;
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField(
        hint: Text('please_select'.tr,
            style:
                tNormalTextStyle.copyWith(fontSize: 12, color: kBorderColor)),
        isExpanded: true,
        value: init,
        onChanged: (value) {
          init = value;
          if (mounted) setState(() {});
        },
        items: widget.map.entries.map((item) {
          return DropdownMenuItem(
            value: item.value,
            child: Text(
              item.key,
              style: tNormalTextStyle,
            ),
          );
        }).toList());
  }

  @override
  Widget build(BuildContext context) {
    return buildLabelWidget(
      context: context,
      label: widget.label,
      children: [
        _buildDropdown(),
        const SizedBox(height: 16),
        CustomButton(
            onPressed: () async {
              widget.myValueSetter(init);
              Get.back();
            },
            color: getColorPrimary(),
            widget: Text(
              'save'.tr,
              style: tButtonWhiteTextStyle.copyWith(
                  fontSize: 14, fontWeight: FontWeight.w500),
            ))
      ],
    );
  }
}

class CustomInputCity extends StatefulWidget {
  const CustomInputCity({
    Key? key,
    required this.myValueSetter,
    required this.label,
    this.init,
  }) : super(key: key);
  final ValueSetter<CityModel?> myValueSetter;
  final String label;
  final String? init;

  @override
  _CustomInputCity createState() => _CustomInputCity();
}

class _CustomInputCity extends State<CustomInputCity>
    with SingleTickerProviderStateMixin {
  String? city;
  final listCity = <CityModel>[];

  @override
  void initState() {
    super.initState();
    city = widget.init;
    getListCity();
  }

  Future<void> getListCity() async {
    listCity.addAll(await fireStoreProvider.getListCityModel());
    if (mounted) setState(() {});
  }

  Widget _buildDropdown() {
    if (listCity.isEmpty) {
      return const Center(
        child: SizedBox(
          height: 32,
          width: 32,
          child: CircularProgressIndicator(),
        ),
      );
    }
    return DropdownButtonFormField<String>(
        hint: Text('please_select'.tr,
            style:
                tNormalTextStyle.copyWith(fontSize: 12, color: kBorderColor)),
        isExpanded: true,
        value: city == '' ? null : city,
        onChanged: (value) {
          if (mounted) setState(() {});
          city = value;
        },
        items: listCity.map((item) {
          return DropdownMenuItem<String>(
            value: item.name,
            child: Text(
              item.name ?? '',
              style: tNormalTextStyle.copyWith(),
            ),
          );
        }).toList());
  }

  @override
  Widget build(BuildContext context) {
    return buildLabelWidget(
      context: context,
      label: widget.label,
      children: [
        _buildDropdown(),
        const SizedBox(height: 16),
        CustomButton(
            onPressed: () async {
              final index =
                  listCity.indexWhere((element) => city == element.name);
              if (index != -1) {
                widget.myValueSetter(listCity[index]);
              }
              Get.back();
            },
            color: getColorPrimary(),
            widget: Text(
              'save'.tr,
              style: tButtonWhiteTextStyle.copyWith(
                  fontSize: 14, fontWeight: FontWeight.w500),
            ))
      ],
    );
  }
}

class CustomSelectAddress extends StatefulWidget {
  const CustomSelectAddress({
    Key? key,
    required this.myValueSetter,
    required this.label,
    this.init,
    this.initState,
  }) : super(key: key);
  final ValueSetter<Map?> myValueSetter;
  final String label;
  final int? init;
  final int? initState;

  @override
  _CustomSelectAddress createState() => _CustomSelectAddress();
}

class _CustomSelectAddress extends State<CustomSelectAddress>
    with SingleTickerProviderStateMixin {
  final listCity = <CityModel>[];
  final listState = <StateModel>[];
  int? cityId;
  int? stateId;

  @override
  void initState() {
    super.initState();
    cityId = widget.init;
    stateId = widget.initState;
    getListCity();
    getListState();
  }

  Future<void> getListCity() async {
    listCity.addAll(await fireStoreProvider.getListCityModel());
    if (mounted) setState(() {});
  }

  Future<void> getListState() async {
    listState.clear();
    if (cityId != null) {
      listState.addAll(await fireStoreProvider.getListState(cityId: cityId));
    }
    if (mounted) setState(() {});
  }

  Widget _buildStateDropDown() {
    if (listState.isEmpty) {
      return const SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'meeting_place'.tr,
          style: tNormalTextStyle.copyWith(
              fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: kSmallPadding),
        DropdownButtonFormField<int>(
            hint: Text('please_select'.tr,
                style: tNormalTextStyle.copyWith(
                    fontSize: 12, color: kBorderColor)),
            isExpanded: true,
            value: stateId,
            onChanged: (value) {
              if (mounted) setState(() {});
              stateId = value;
            },
            items: listState.map((item) {
              return DropdownMenuItem<int>(
                value: item.id,
                child: Text(
                  item.name ?? '',
                  style: tNormalTextStyle.copyWith(),
                ),
              );
            }).toList()),
      ],
    );
  }

  Widget _buildDropdown() {
    if (listCity.isEmpty) {
      return const Center(
        child: SizedBox(
          height: 32,
          width: 32,
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'area'.tr,
          style: tNormalTextStyle.copyWith(
              fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: kSmallPadding),
        DropdownButtonFormField<int>(
            hint: Text('please_select'.tr,
                style: tNormalTextStyle.copyWith(
                    fontSize: 12, color: kBorderColor)),
            isExpanded: true,
            value: cityId,
            onChanged: (value) async {
              if (cityId == value) return;
              cityId = value;
              stateId = null;
              getListState();
            },
            items: listCity.map((item) {
              return DropdownMenuItem<int>(
                value: item.id,
                child: Text(
                  item.name ?? '',
                  style: tNormalTextStyle.copyWith(),
                ),
              );
            }).toList()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildLabelWidget(
      context: context,
      label: widget.label,
      children: [
        _buildDropdown(),
        const SizedBox(height: kDefaultPadding),
        _buildStateDropDown(),
        const SizedBox(height: kDefaultPadding),
        CustomButton(
            onPressed: () async {
              if (cityId != null && stateId != null) {
                final index =
                    listCity.indexWhere((element) => element.id == cityId);
                final stateIndex =
                    listState.indexWhere((element) => element.id == stateId);
                if (index != -1 && stateIndex != -1) {
                  final map = {
                    'city': listCity[index],
                    'state': listState[stateIndex]
                  };
                  widget.myValueSetter(map);
                }
              }
              Get.back();
            },
            color: getColorPrimary(),
            widget: Text(
              'save'.tr,
              style: tButtonWhiteTextStyle.copyWith(
                  fontSize: 14, fontWeight: FontWeight.w500),
            ))
      ],
    );
  }
}

class CustomInputState extends StatefulWidget {
  const CustomInputState({
    Key? key,
    required this.myValueSetter,
    required this.label,
    required this.cityId,
    this.init,
  }) : super(key: key);
  final ValueSetter<StateModel?> myValueSetter;
  final String label;
  final int? cityId;
  final String? init;

  @override
  _CustomInputState createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInputState>
    with SingleTickerProviderStateMixin {
  String? state;
  final list = <StateModel>[];

  @override
  void initState() {
    super.initState();
    state = widget.init;
    getListState();
  }

  Future<void> getListState() async {
    list.addAll(await fireStoreProvider.getListState(cityId: widget.cityId));
    if (mounted) setState(() {});
  }

  Widget _buildDropdown() {
    if (list.isEmpty) {
      return const Center(
        child: SizedBox(
          height: 32,
          width: 32,
          child: CircularProgressIndicator(),
        ),
      );
    }
    return DropdownButtonFormField<String>(
        hint: Text('please_select'.tr,
            style:
                tNormalTextStyle.copyWith(fontSize: 12, color: kBorderColor)),
        isExpanded: true,
        value: state == '' ? null : state,
        onChanged: (value) {
          if (mounted) setState(() {});
          state = value;
        },
        items: list.map((item) {
          return DropdownMenuItem<String>(
            value: item.name,
            child: Text(
              item.name ?? '',
              style: tNormalTextStyle.copyWith(),
            ),
          );
        }).toList());
  }

  @override
  Widget build(BuildContext context) {
    return buildLabelWidget(
      context: context,
      label: widget.label,
      children: [
        _buildDropdown(),
        const SizedBox(height: 16),
        CustomButton(
            onPressed: () async {
              final index = list.indexWhere((element) => state == element.name);
              if (index != -1) {
                widget.myValueSetter(list[index]);
              }
              Get.back();
            },
            color: getColorPrimary(),
            widget: Text(
              'save'.tr,
              style: tButtonWhiteTextStyle.copyWith(
                  fontSize: 14, fontWeight: FontWeight.w500),
            ))
      ],
    );
  }
}

class CustomSelectChip extends StatefulWidget {
  const CustomSelectChip({
    Key? key,
    required this.myValueSetter,
    required this.label,
    required this.listChips,
    this.init,
  }) : super(key: key);
  final ValueSetter<String?> myValueSetter;
  final String label;
  final String? init;
  final List<String> listChips;

  @override
  _CustomSelectChip createState() => _CustomSelectChip();
}

class _CustomSelectChip extends State<CustomSelectChip>
    with SingleTickerProviderStateMixin {
  String? initValue;

  @override
  void initState() {
    super.initState();
    initValue = widget.init;
  }

  void onSelectedChip(String e) {
    initValue = e;
    if (mounted) setState(() {});
  }

  Widget _buildDropdown() {
    if (widget.listChips.isEmpty) {
      return const Center(
        child: SizedBox(
          height: 32,
          width: 32,
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.start,
            children: widget.listChips
                .map((e) => ChipItemSelect(
                      value: e,
                      label: e.tr,
                      isSelect: initValue == e,
                      borderColor: Colors.black,
                      selectedBackgroundColor: Colors.black,
                      selectedTextColor: Colors.white,
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      onPress: onSelectedChip,
                    ))
                .toList()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildLabelWidget(
      context: context,
      label: widget.label,
      children: [
        _buildDropdown(),
        const SizedBox(height: 16),
        CustomButton(
            onPressed: () async {
              widget.myValueSetter(initValue);
              Get.back(closeOverlays: true);
            },
            color: getColorPrimary(),
            widget: Text(
              'save'.tr,
              style: tButtonWhiteTextStyle.copyWith(
                  fontSize: 14, fontWeight: FontWeight.w500),
            ))
      ],
    );
  }
}
