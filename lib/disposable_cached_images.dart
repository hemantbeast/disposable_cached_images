library disposable_cached_images;

import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import './image_info_data.dart';
import './storage/interface.dart';

import './decoded_images/image_download_platform/stub.dart'
    if (dart.library.io) './decoded_images/image_download_platform/io.dart'
    if (dart.library.html) './decoded_images/image_download_platform/web.dart';

import './image_providers/network_download_mixin/network_download_mixin_stub.dart'
    if (dart.library.io) './image_providers/network_download_mixin/network_download_mixin.dart'
    if (dart.library.html) './image_providers/network_download_mixin/network_download_mixin_web.dart';

part './image_decoder.dart';
part './image_providers/arguments.dart';
part './image_providers/base_provider.dart';
part './image_providers/providers/assets.dart';
part './image_providers/providers/local.dart';
part './image_providers/providers/network.dart';
part './image_providers/state.dart';
part './image_providers/used_image_provider.dart';
part './run_app_wrapper.dart';
part './widget/main_widget.dart';
part './widget/raw_image_widget.dart';
part './decoded_images/decoded_images.dart';
