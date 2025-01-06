import 'package:get/get.dart';
import 'package:master_of_getx/services/http_service.dart';

Future<void> registerServices() async {
  Get.put(
    HTTPService(),
  );
}
