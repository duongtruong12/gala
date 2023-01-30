import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage(
      {Key? key,
      required this.url,
      this.height,
      this.width,
      this.color,
      this.borderRadius = 8,
      this.enableRefresh = false,
      this.fit = BoxFit.cover})
      : super(key: key);
  final bool enableRefresh;
  final String? url;
  final BoxFit fit;
  final Color? color;
  final double? height;
  final double? width;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      child: url == null || url!.isEmpty
          ? getSvgImage('ic_default_avatar',
              height: height, width: width, boxFit: fit)
          : ExtendedImage.network(
              url!,
              width: width,
              height: height,
              fit: fit,
              cache: true,
              loadStateChanged: (ExtendedImageState state) {
                switch (state.extendedImageLoadState) {
                  case LoadState.loading:
                    return const Center(
                      child: SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator()),
                    );
                  case LoadState.failed:
                    return enableRefresh
                        ? IconButton(
                            onPressed: () {
                              state.reLoadImage();
                            },
                            icon: Icon(
                              Icons.refresh,
                              color: getColorPrimary(),
                            ))
                        : const Center(
                            child: Icon(
                              Icons.error_outline_rounded,
                              size: 32,
                            ),
                          );
                  case LoadState.completed:
                    break;
                }
                return null;
              },
            ),
    );
  }
}
