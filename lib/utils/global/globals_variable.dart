import 'dart:math';

import 'package:base_flutter/data/api/api_provider.dart';
import 'package:base_flutter/data/repositories/default_repository.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

final listImage = [
  'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/640px-Image_created_with_a_mobile_phone.png',
  'https://bestwriting.com/images/blog/free-photos-for-blogs.jpg',
  'https://media.istockphoto.com/id/1327801797/photo/young-woman-sitting-on-the-pier-near-the-water-at-sunny-day.jpg?s=170667a&w=0&k=20&c=fxbhjR-SHTpUUl0uKnAiqWWUik0H1gZR1K4W_Z079fM=',
  'https://media.istockphoto.com/id/450253181/photo/mountains-and-villages-in-northwest-vietnam.jpg?b=1&s=612x612&w=0&k=20&c=rrL609fvOzS4OpR6dz3s43q4xc4dwm5_mfxhlBb5sN0=',
  'https://st.depositphotos.com/2004245/1938/i/600/depositphotos_19389909-stock-photo-tortoise-tower-is-on-an.jpg',
  'https://static.vecteezy.com/packs/media/photos/term-bg-3-f6a12264.jpg',
];

Random r = Random();

RxBool loading = RxBool(false);
RxBool casterAccount = RxBool(false);
final picker = ImagePicker();
final logger = Logger(
    printer:
        PrettyPrinter(methodCount: 1, printTime: false, printEmojis: true));
final DefaultRepository repository =
    DefaultRepository(apiProvider: ApiProvider());
