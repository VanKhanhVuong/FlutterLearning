import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:dio/dio.dart';
import 'dart:io';

class FilePickerScreen extends StatefulWidget {
  @override
  _FilePickerScreenState createState() => _FilePickerScreenState();
}

class _FilePickerScreenState extends State<FilePickerScreen> {
  String? fileName;
  String? filePath;
  String? fileSize;
  String? fileExtension;
  String? analysisResult;
  bool isUploading = false;

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;

      setState(() {
        fileName = file.name;
        filePath = file.path;
        fileSize = "${(file.size / 1024).toStringAsFixed(2)} KB";
        fileExtension = file.extension;
      });

      print("File đã chọn: $fileName ($fileSize)");
    } else {
      print("Người dùng đã hủy chọn file.");
    }
  }

  void openSelectedFile() {
    if (filePath != null) {
      OpenFile.open(filePath);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Vui lòng chọn file trước!")));
    }
  }

  /// Trích xuất nội dung từ PDF/DOCX
  // Future<String> extractTextFromFile(String path, String? extension) async {
  //   if (extension == "pdf") {
  //     final document = await PdfDocument.openFile(path);
  //     String text = "";
  //     for (int i = 0; i < document.pagesCount; i++) {
  //       final page = await document.getPage(i);
  //       text += await page.text;
  //       await page.close();
  //     }
  //     return text;
  //   } else if (extension == "docx") {
  //     return await MsWordToText.getText(path) ??
  //         "Không thể đọc nội dung từ file DOCX.";
  //   }
  //   return "Không hỗ trợ định dạng này.";
  // }

  /// Gửi nội dung file lên OpenAI để phân tích
  Future<void> analyzeCV() async {
    if (filePath == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Vui lòng chọn file trước!")));
      return;
    }

    setState(() {
      isUploading = true;
    });

    try {
      // String fileContent = await extractTextFromFile(filePath!, fileExtension);

      Dio dio = Dio();
      String openAiUrl = "https://api.openai.com/v1/chat/completions";

      Response response = await dio.post(
        openAiUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer ',
            'Content-Type': 'application/json',
          },
        ),
        data: {
          "model": "gpt-4-turbo",
          "messages": [
            {"role": "system", "content": "Bạn là một chuyên gia iOS."},
            {
              "role": "user",
              "content": "Hãy gợi ý một số cần thiết trong swiftUI",
            },
          ],
        },
      );

      setState(() {
        analysisResult = response.data["choices"][0]["message"]["content"];
      });

      print("Phân tích thành công: $analysisResult");
    } catch (error) {
      print("Lỗi gửi OpenAI: $error");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Lỗi khi gửi file lên OpenAI!")));
    } finally {
      setState(() {
        isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chọn & Gửi File PDF/DOCX")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(onPressed: pickFile, child: Text("Chọn File")),
            SizedBox(height: 16),

            if (fileName != null) ...[
              Text(
                "📄 Tên File: $fileName",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: openSelectedFile,
                child: Text("Mở File"),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: isUploading ? null : analyzeCV,
                child:
                    isUploading
                        ? CircularProgressIndicator()
                        : Text("Gửi lên OpenAI"),
              ),
            ],

            if (analysisResult != null) ...[
              SizedBox(height: 16),
              Text(
                "🔍 Kết Quả Phân Tích:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(analysisResult!),
            ],
          ],
        ),
      ),
    );
  }
}
