import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Location Finder",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
