import 'package:base_flutter/components/custom_button.dart';
import 'package:base_flutter/components/date_picker_dropdown.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/validate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const listCity = [
  "Tokyo",
  "Ōsaka",
  "Nagoya",
  "Yokohama",
  "Fukuoka",
  "Sapporo",
  "Kyōto",
  "Kōbe",
  "Kawanakajima",
  "Saitama",
  "Hiroshima",
  "Sendai",
  "Kitaku",
  "Chiba",
  "Niigata",
  "Hamamatsu",
  "Kumamoto",
  "Sagamihara",
  "Okayama",
  "Edogawa",
  "Shizuoka",
  "Adachi",
  "Kagoshima",
  "Hachiōji",
  "Utsunomiya",
  "Matsuyama",
  "Matsudo",
  "Higashi-ōsaka",
  "Nishinomiya-hama",
  "Ōita",
  "Kanazawa",
  "Fukuyama",
  "Machida",
  "Toyota",
  "Takamatsu",
  "Toyama",
  "Nagasaki",
  "Gifu",
  "Miyazaki",
  "Okazaki",
  "Ichinomiya",
  "Toyohashi",
  "Nagano",
  "Wakayama",
  "Nara",
  "Koshigaya",
  "Ōtsu",
  "Tokorozawa",
  "Tamuramachi-moriyama",
  "Kawagoe",
  "Iwaki",
  "Maebashi",
  "Asahikawa",
  "Kōchi",
  "Naha",
  "Yokkaichi",
  "Kasugai",
  "Akita",
  "Ōakashichō",
  "Toshima",
  "Morioka",
  "Fukushima",
  "Tsu",
  "Aomori",
  "Mito",
  "Ichihara",
  "Fuchū",
  "Fukui",
  "Minato",
  "Hiratsuka",
  "Tokushima",
  "Shinozaki",
  "Hakodate",
  "Sōka",
  "Yamagata",
  "Tsukuba-kenkyūgakuen-toshi",
  "Fuji",
  "Chigasaki",
  "Chōfugaoka",
  "Yato",
  "Hachimanchō",
  "Sato",
  "Saga",
  "Neya",
  "Ageoshimo",
  "Minamiōzuma",
  "Arakawa",
  "Kure",
  "Taitō",
  "Matsue",
  "Yachiyo",
  "Ashino",
  "Higashi-Hiroshima",
  "Naka",
  "Suzuka",
  "Kamirenjaku",
  "Kumagaya",
  "Hino",
  "Anjōmachi",
  "Tottori",
  "Jōetsu",
  "Kōfu",
  "Izuo",
  "Tachikawa",
  "Narashino",
  "Ōbiraki",
  "Takaoka",
  "Beppuchō",
  "Hitachi",
  "Izumo",
  "Nishio",
  "Takaoka",
  "Iwata",
  "Niiza",
  "Ube",
  "Matsuzaka",
  "Ōgaki",
  "Hitachi-Naka",
  "Tochigi",
  "Kariya",
  "Ueda",
  "Higashimurayama",
  "Kukichūō",
  "Sayama",
  "Komaki",
  "Tama",
  "Yonago",
  "Iruma",
  "Kakamigahara",
  "Kusatsu",
  "Shimotoda",
  "Misato",
  "Fukayachō",
  "Ishizaki",
  "Kuwana",
  "Koga",
  "Kisarazu",
  "Yaizu",
  "Inazawa",
  "Ōme",
  "Zama",
  "Narita",
  "Abiko",
  "Onomichi",
  "Kokubunji",
  "Seto",
  "Ōmiyachō",
  "Iizuka",
  "Ise",
  "Kashiwara",
  "Tsuruoka",
  "Ebetsu",
  "Daitōchō",
  "Kadoma",
  "Nobeoka",
  "Kōnosu",
  "Honchō",
  "Ikoma",
  "Beppu",
  "Nasushiobara",
  "Kōenchō",
  "Niihama",
  "Sano",
  "Hatsukaichi",
  "Hikone",
  "Hōfu",
  "Fujimino",
  "Higashiōmi",
  "Otaru",
  "Ōshū",
  "Akishima",
  "Kasuga",
  "Shirayamamachi",
  "Kamagaya",
  "Sandachō",
  "Tondabayashichō",
  "Habikino",
  "Mineshita",
  "Tajimi",
  "Ikeda",
  "Toride",
  "Saijō",
  "Inzai",
  "Isehara",
  "Shibuya",
  "Sakado",
  "Chikusei",
  "Kani",
  "Ginowan",
  "Sakata",
  "Saku",
  "Kōnan",
  "Iida",
  "Kamisu",
  "Kanuma",
  "Azumino",
  "Yashio",
  "Yotsukaidō",
  "Nisshin",
  "Hanamaki Onsen",
  "Ōbu",
  "Higashi-Matsuyama",
  "Kitakami",
  "Imizuchō",
  "Mihara",
  "Fukuroi",
  "Mobara",
  "Gotenba",
  "Kitanagoya",
  "Sekimachi",
  "Yokotemachi",
  "Ushiku",
  "Higashiyamato",
  "Kitakōriyamachō",
  "Chita",
  "Moriyama",
  "Nakatsu",
  "Owariasahi",
  "Kaneyama",
  "Muroran",
  "Ōmihachiman",
  "Kimitsu",
  "Nagaoka",
  "Akiruno",
  "Iwamizawa",
  "Natori-shi",
  "Hannō",
  "Maizuru",
  "Mooka",
  "Gyōda",
  "Nikkō",
  "Daisen",
  "Ryūgasaki",
  "Fukuchiyama",
  "Nakatsugawa",
  "Kunitachi",
  "Tatebayashi",
  "Tatsunochō-tominaga",
  "Yurihonjō",
  "Kasama",
  "Shibukawa",
  "Ōtawara",
  "Hekinan",
  "Yoshikawa",
  "Chiryū",
  "Ishioka",
  "Musashimurayama",
  "Yawata-shimizui",
  "Tsurugashima",
  "Uwajima",
  "Rittō",
  "Toyoake",
  "Kashima",
  "Saiki",
  "Yachimata",
  "Hashima",
  "Ina",
  "Kitamoto",
  "Tomigusuku",
  "Kurihara",
  "Asahi",
  "Nago",
  "Tendō",
  "Tago",
  "Shiroi",
  "Hasuda",
  "Hatogaya-honchō",
  "Aisai",
  "Tsushima",
  "Itoman",
  "Shimotsuke",
  "Koga",
  "Jōsō",
  "Chichibu",
  "Tahara",
  "Koja",
  "Ishikari",
  "Kosai",
  "Tōgane",
  "Tokoname",
  "Minokamo",
  "Zushi",
  "Fussa",
  "Kudamatsu",
  "Tama",
  "Mukōchō",
  "Nōgata",
  "Toki",
  "Chino",
  "Hidaka",
  "Annaka",
  "Sakurai",
  "Hamura",
  "Funato",
  "Minami-Sōma",
  "Shiraoka",
  "Tomiya",
  "Bandō",
  "Tsukubamirai",
  "Sakaidechō",
  "Arao",
  "Yūki",
  "Yasu",
  "Miyoshi",
  "Satte",
  "Nichinan",
  "Tōkamachi",
  "Tomisato",
  "Suzaka",
  "Hikari",
  "Nomimachi",
  "Takahama",
  "Omitama",
  "Suzukawa",
  "Suwa",
  "Ishigaki",
  "Sanmu",
  "Ami",
  "Ena",
  "Iwakura",
  "Higashine",
  "Shimotsuchō-kominami",
  "Tonami",
  "Hitachi-ota",
  "Tomioka",
  "Noboribetsu",
  "Nakai",
  "Kurayoshi",
  "Takashima",
  "Shimeo",
  "Kasaoka",
  "Tamagawa",
  "Hokota",
  "Shima",
  "Hokuto",
  "Kariya",
  "Inuma",
  "Masuda",
  "Hagi",
  "Otofuke",
  "Sugito",
  "Himi",
  "Shinshiro",
  "Kobayashi",
  "Taketoyo",
  "Makinohara",
  "Taniyama-chūō",
  "Futtsu",
  "Yuzawa",
  "Shimotsuma",
  "Kitaibaraki",
  "Obita",
  "Nanbei",
  "Katsuren-haebaru",
  "Komono",
  "Ōzu",
  "Itoigawa",
  "Kasumigaura",
  "Kurobeshin",
  "Nakama",
  "Takikawa",
  "Mibu",
  "Ōmagari",
  "Higashimatsushima",
  "Inashiki",
  "Hitachiomiya",
  "Gujō",
  "Sakuragawa",
  "Miyoshidai",
  "Ibara",
  "Umi",
  "Katsuragi",
  "Kanie",
  "Tsubata",
  "Kannan",
  "Komatsushimachō",
  "Kanada",
  "Usuki",
  "Miyajima",
  "Rifu",
  "Minami-Bōsō",
  "Morohongō",
  "Kamata",
  "Ōzu",
  "Kahoku",
  "Iyo",
  "Abashiri",
  "Uonuma",
  "Minamishiro",
  "Shōbara",
  "Kamaishi",
  "Wakabadai",
  "Shingū",
  "Kuji",
  "Mashiki",
  "Sakaiminato",
  "Nagato",
  "Ōdachō-ōda",
  "Yorii",
  "Namegata",
  "Komagane",
  "Shimizuchō",
  "Zentsujichó",
  "Kuroishi",
  "Katagami",
  "Ayabe",
  "Yawatahama-shi",
  "Shimotoba",
  "Yaita",
  "Ōiso",
  "Sasaguri",
  "Tawaramoto",
  "Kaminokawa",
  "Hirakawachō",
  "Motomiya",
  "Tsuruno",
  "Kaita",
  "Masaki",
  "Togitsu",
  "Hanawa",
  "Oyabe",
  "Matsubushi",
  "Izu",
  "Sue",
  "Ogawa",
  "Aioi",
  "Chatan",
  "Obama",
  "Ikata-chō",
  "Yamaguchi",
  "Kozakai-chō",
  "Uchimaru",
  "Onagawa Chō",
  "Hirado",
  "Furudate"
];

class CustomInput extends StatefulWidget {
  const CustomInput(
      {Key? key,
      required this.myValueSetter,
      required this.label,
      required this.initText,
      this.validate,
      this.hint,
      this.minLines = 1})
      : super(key: key);
  final ValueSetter<String> myValueSetter;
  final String label;
  final String initText;
  final String? hint;
  final int minLines;
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
    textEditingController.text = widget.initText;
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
            Form(
              key: formKey,
              child: TextFormField(
                controller: textEditingController,
                minLines: widget.minLines,
                maxLines: null,
                autofocus: true,
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
                    widget.myValueSetter(textEditingController.text);
                  }
                },
                color: getColorPrimary(),
                widget: Text(
                  'save_card'.tr,
                  style: tButtonWhiteTextStyle.copyWith(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ))
          ],
        ),
      ),
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
    return Validate.oldPasswordValidate(str, '111111');
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
                  'save_card'.tr,
                  style: tButtonWhiteTextStyle.copyWith(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ))
          ],
        ),
      ),
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
                  'save_card'.tr,
                  style: tButtonWhiteTextStyle.copyWith(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ))
          ],
        ),
      ),
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
  final ValueSetter<String?> myValueSetter;
  final String label;
  final String? init;

  @override
  _CustomInputCity createState() => _CustomInputCity();
}

class _CustomInputCity extends State<CustomInputCity>
    with SingleTickerProviderStateMixin {
  String? city;

  @override
  void initState() {
    super.initState();
    city = widget.init;
  }

  Widget _buildDropdown() {
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
            value: item.toString(),
            child: Text(
              item.toString(),
              style: tNormalTextStyle.copyWith(),
            ),
          );
        }).toList());
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
            const Divider(color: kTextColorDark),
            _buildDropdown(),
            const SizedBox(height: 16),
            CustomButton(
                onPressed: () async {
                  widget.myValueSetter(city);
                  Get.back();
                },
                color: getColorPrimary(),
                widget: Text(
                  'save_card'.tr,
                  style: tButtonWhiteTextStyle.copyWith(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ))
          ],
        ),
      ),
    );
  }
}
