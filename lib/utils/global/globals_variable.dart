import 'dart:math';

import 'package:base_flutter/data/api/api_provider.dart';
import 'package:base_flutter/data/repositories/default_repository.dart';
import 'package:base_flutter/firestore/firestore_provider.dart';
import 'package:base_flutter/model/user_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

final r = Random();
final loading = RxBool(false);
final user = Rxn<UserModel>();
final casterAccount = RxBool(false);
final fireStoreProvider = FireStoreProvider();
final apiProvider = ApiProvider();
final picker = ImagePicker();
final unread = 0.obs;
final logger = Logger(
    printer:
        PrettyPrinter(methodCount: 1, printTime: false, printEmojis: true));
final DefaultRepository repository =
    DefaultRepository(apiProvider: ApiProvider());

const stripePublishableKey =
    'pk_test_51McKsOIx8zBC2fSm1X8BLS7ftrvvXcAEWHM5DFiozymIY2HntE8pxgiywAjuLRbyhiXpg7uGAMhXxuxBnYpsx2Lq00TQ6dxLuO';
