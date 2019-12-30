// Copyright 2018, Devoxx
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Displays a network-loaded image, with a placeholder during the load and an
/// error icon in case of failure. If a null value is provided for [imageUrl],
/// [placeholderIcon] is displayed.
class Avatar extends StatelessWidget {
  final String imageUrl;
  final IconData placeholderIcon;
  final IconData errorIcon;
  final double width;
  final double height;
  final bool square;

  const Avatar({
    @required this.imageUrl,
    @required this.placeholderIcon,
    @required this.errorIcon,
    @required this.width,
    @required this.height,
    this.square = false,
  });

  @override
  Widget build(BuildContext context) {
    final content = imageUrl != null
        ? CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder: (context, url) => Container(
              color: Color(0x40000000),
              child: Icon(
                placeholderIcon,
                color: Colors.grey,
              ),
            ),
            errorWidget: (context, url, error) => Container(
              color: Color(0x40000000),
              child: Icon(
                errorIcon,
                color: Colors.grey,
              ),
            ),
            height: height,
            width: width,
            fit: BoxFit.cover,
          )
        : Container(
            color: Color(0x40000000),
            child: Icon(
              placeholderIcon,
              color: Colors.grey,
            ),
          );

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(),
        shape: square ? BoxShape.rectangle : BoxShape.circle,
      ),
      padding: const EdgeInsets.all(2.0),
      child: square
          ? content
          : ClipOval(
              child: content,
            ),
    );
  }
}
