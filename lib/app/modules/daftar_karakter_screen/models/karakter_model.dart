// Identitas :
// Quiz 2 Soal 4

// Nama : Muhammad Renaldi Maulana
// NIM : 10122002
// Kelas : IF-1
// Tanggal : 28-07-2025

class KarakterModel {
  final int id;
  final String name;
  final String status;
  final String image;

  KarakterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.image,
  });

  factory KarakterModel.fromJson(Map<String, dynamic> json) {
    return KarakterModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      status: json['status'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'status': status, 'image': image};
  }
}

class CharacterResponse {
  final Info info;
  final List<KarakterModel> results;

  CharacterResponse({required this.info, required this.results});

  factory CharacterResponse.fromJson(Map<String, dynamic> json) {
    return CharacterResponse(
      info: Info.fromJson(json['info'] ?? {}),
      results:
          (json['results'] as List<dynamic>? ?? [])
              .map(
                (item) => KarakterModel.fromJson(item as Map<String, dynamic>),
              )
              .toList(),
    );
  }
}

class Info {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  Info({required this.count, required this.pages, this.next, this.prev});

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      count: json['count'] ?? 0,
      pages: json['pages'] ?? 0,
      next: json['next'],
      prev: json['prev'],
    );
  }
}
