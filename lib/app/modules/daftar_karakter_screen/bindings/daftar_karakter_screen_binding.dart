import 'package:get/get.dart';

import '../controllers/daftar_karakter_screen_controller.dart';

class DaftarKarakterScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DaftarKarakterScreenController>(
      () => DaftarKarakterScreenController(),
    );
  }
}
