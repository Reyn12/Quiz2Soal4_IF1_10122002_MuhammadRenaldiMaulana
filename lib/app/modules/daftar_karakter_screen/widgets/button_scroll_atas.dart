// Identitas :
// Quiz 2 Soal 4

// Nama : Muhammad Renaldi Maulana
// NIM : 10122002
// Kelas : IF-1
// Tanggal : 28-07-2025

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/daftar_karakter_screen_controller.dart';

class ButtonScrollAtas extends GetView<DaftarKarakterScreenController> {
  const ButtonScrollAtas({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AnimatedOpacity(
        opacity: controller.showScrollToTopButton.value ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: controller.showScrollToTopButton.value
            ? FloatingActionButton(
                onPressed: () => controller.scrollToTop(),
                backgroundColor: Colors.blue,
                heroTag: "scrollToTop", // Unique hero tag
                child: const Icon(
                  Icons.keyboard_arrow_up,
                  color: Colors.white,
                  size: 28,
                ),
              )
            : const SizedBox.shrink(),
      );
    });
  }
}