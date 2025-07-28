import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/karakter_model.dart';
import '../services/karakter_service.dart';

class DaftarKarakterScreenController extends GetxController {
  late final KarakterService _karakterService;
  late final ScrollController scrollController;
  
  // Observable variables
  final isLoading = false.obs;
  final characters = <KarakterModel>[].obs;
  final currentPage = 1.obs;
  final totalPages = 1.obs;
  final hasMoreData = true.obs;
  final errorMessage = ''.obs;
  final showScrollToTopButton = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    _karakterService = Get.put(KarakterService());
    scrollController = ScrollController();
    
    // Listen to scroll changes
    scrollController.addListener(() {
      // Show/hide scroll to top button
      if (scrollController.offset >= 400) {
        showScrollToTopButton.value = true;
      } else {
        showScrollToTopButton.value = false;
      }
      
      // Load more data when reached bottom
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent &&
          hasMoreData.value &&
          !isLoading.value) {
        loadMoreCharacters();
      }
    });
    
    loadCharacters();
  }

  Future<void> loadCharacters({bool isLoadMore = false}) async {
    if (isLoading.value) return;
    
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      final response = await _karakterService.getCharacters(page: currentPage.value);
      
      totalPages.value = response.info.pages;
      
      if (isLoadMore) {
        characters.addAll(response.results);
      } else {
        characters.value = response.results;
      }
      
      hasMoreData.value = currentPage.value < totalPages.value;
      
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        'Error',
        'Gagal memuat data karakter',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
  
  Future<void> loadMoreCharacters() async {
    if (hasMoreData.value && !isLoading.value) {
      currentPage.value++;
      await loadCharacters(isLoadMore: true);
    }
  }
  
  Future<void> refreshCharacters() async {
    currentPage.value = 1;
    hasMoreData.value = true;
    await loadCharacters();
  }
  
  void scrollToTop() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }
  
  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
