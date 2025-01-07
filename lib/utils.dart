import 'package:get/get.dart';
import 'package:master_of_getx/controllers/assets_controller.dart';
import 'package:master_of_getx/services/http_service.dart';

Future<void> registerServices() async {
  Get.put(
    HTTPService(),
  );
}

Future<void> registerController() async {
  Get.put(
    AssetsController(),
  );
}

String getCyptoImageURL(String name) {
  return "https://raw.githubusercontent.com/ErikThiart/cryptocurrency-icons/refs/heads/master/128/${name.toLowerCase()}.png";
}
