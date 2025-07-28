import 'package:get/get.dart';

import '../modules/daftar_karakter_screen/bindings/daftar_karakter_screen_binding.dart';
import '../modules/daftar_karakter_screen/views/daftar_karakter_screen_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.DAFTAR_KARAKTER_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.DAFTAR_KARAKTER_SCREEN,
      page: () => const DaftarKarakterScreenView(),
      binding: DaftarKarakterScreenBinding(),
    ),
  ];
}
