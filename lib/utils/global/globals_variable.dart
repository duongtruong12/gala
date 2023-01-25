import 'package:base_flutter/data/api/api_provider.dart';
import 'package:base_flutter/data/repositories/default_repository.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

RxBool loading = RxBool(false);
final picker = ImagePicker();
final logger = Logger(
    printer:
        PrettyPrinter(methodCount: 1, printTime: false, printEmojis: true));
final DefaultRepository repository =
    DefaultRepository(apiProvider: ApiProvider());
