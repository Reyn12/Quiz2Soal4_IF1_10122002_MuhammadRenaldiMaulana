import 'package:get/get.dart';
import '../models/karakter_model.dart';
import '../../../utils/endpoints.dart';

class KarakterService extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = Endpoints.baseUrl;
    httpClient.timeout = const Duration(seconds: 30);
    super.onInit();
  }

  Future<CharacterResponse> getCharacters({int page = 1}) async {
    try {
      final response = await get('/character?page=$page');

      if (response.hasError) {
        throw Exception('Failed to load characters: ${response.statusText}');
      }

      return CharacterResponse.fromJson(response.body);
    } catch (e) {
      throw Exception('Error fetching characters: $e');
    }
  }
}