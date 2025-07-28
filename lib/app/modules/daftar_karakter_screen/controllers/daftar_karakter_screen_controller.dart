import 'package:get/get.dart';
import '../models/karakter_model.dart';
import '../services/karakter_service.dart';

class DaftarKarakterScreenController extends GetxController {
  late final KarakterService _karakterService;
  
  // Observable variables
  final isLoading = false.obs;
  final characters = <KarakterModel>[].obs;
  final currentPage = 1.obs;
  final totalPages = 1.obs;
  final hasMoreData = true.obs;
  final errorMessage = ''.obs;
  
  @override
  void onInit() {
    super.onInit();
    _karakterService = Get.put(KarakterService());
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
}
