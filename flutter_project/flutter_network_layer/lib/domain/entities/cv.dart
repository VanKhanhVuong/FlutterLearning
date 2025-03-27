import 'dart:convert';

class CvModel {
  final String content;

  CvModel({required this.content});

  factory CvModel.fromJson(Map<String, dynamic> json) {
    String formattedContent = json["content"] ?? "";

    // Loại bỏ khoảng trắng dư thừa & format nội dung
    formattedContent =
        formattedContent
            .replaceAll("\n ", "\n") // Loại bỏ ký tự xuống dòng + khoảng trắng
            .replaceAll(" ", " ") // Loại bỏ ký tự khoảng trắng không chuẩn
            .replaceAll("\n\n", "\n") // Loại bỏ dòng trống thừa
            .trim();

    return CvModel(content: formattedContent);
  }

  Map<String, dynamic> toJson() {
    return {"content": content};
  }
}

// Chuyển JSON string thành đối tượng CvModel
CvModel cvModelFromJson(String str) => CvModel.fromJson(json.decode(str));

// Chuyển đối tượng CvModel thành JSON string
String cvModelToJson(CvModel data) => json.encode(data.toJson());
