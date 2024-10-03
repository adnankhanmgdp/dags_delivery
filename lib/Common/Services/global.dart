// import 'package:dags_delivery_app/Common/Services/storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// class Global {
//    static late StorageServices storageServices;
//
//   static Future init() async {
//     WidgetsFlutterBinding.ensureInitialized();
//     // this is for initialising the storage services
//     storageServices = await StorageServices().init();
//     if (kDebugMode) {
//       print('successfully initialized all the services');
//     }
//   }
// }


import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../utils/storage.dart';
class Global {
  static late StorageServices storageServices;

  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    // this is for initialising the storage services
    storageServices = await StorageServices().init();
    if (kDebugMode) {
      print('successfully initialized all the services');
    }
  }
}

