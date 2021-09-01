import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Cek Ongkir Indonesia",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
