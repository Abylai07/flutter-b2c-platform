import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:b2c_platform/src/application.dart';
import 'package:b2c_platform/src/common/utils/firebase_api/notifications.dart';
import 'package:b2c_platform/src/get_it_sl.dart' as service_locator;

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await service_locator.init();
  await GetStorage.init();
  runApp(Application());
}

