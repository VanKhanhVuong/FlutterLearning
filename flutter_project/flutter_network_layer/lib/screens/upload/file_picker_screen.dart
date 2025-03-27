import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_network_layer/notifier/open_ai/generate_completion.dart';
import 'package:flutter_network_layer/notifier/uploadfile/upload_file_notifier.dart';
import 'package:flutter_network_layer/utils/secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_file/open_file.dart';

class FilePickerScreen extends HookWidget {
  const FilePickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fileName = useState<String?>(null);
    final filePath = useState<String?>(null);
    final fileSize = useState<String?>(null);
    final fileExtension = useState<String?>(null);
    final isUploading = useState<bool>(false);

    return Consumer(
      builder: (context, ref, child) {
        final uploadFileState = ref.watch(uploadFileProvider);
        final uploadFileNotifier = ref.read(uploadFileProvider.notifier);

        final generateCompletionState = ref.watch(generateCompletionProvider);
        final generateCompletionNotifier = ref.read(
          generateCompletionProvider.notifier,
        );

        // Mở file đã chọn
        void openSelectedFile() {
          if (filePath.value != null) {
            OpenFile.open(filePath.value);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Vui lòng chọn file trước!")),
            );
          }
        }

        // Chọn file từ thiết bị
        Future<void> pickFile() async {
          FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['pdf', 'docx'],
          );

          if (result != null) {
            PlatformFile file = result.files.first;
            fileName.value = file.name;
            filePath.value = file.path;
            fileSize.value = "${(file.size / 1024).toStringAsFixed(2)} KB";
            fileExtension.value = file.extension;
            print("📄 File đã chọn: ${fileName.value} (${fileSize.value})");
          } else {
            print("⛔ Người dùng đã hủy chọn file.");
          }
        }

        // Upload file lên server để lấy text
        Future<void> extractTextFromFile() async {
          final secureStorage = SecureStorage();
          if (filePath.value == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Vui lòng chọn file trước!")),
            );
            return;
          }

          isUploading.value = true;

          try {
            final file = File(filePath.value!); // Chuyển thành File
            final accessToken = await secureStorage.readSecureData(
              'accessToken',
            );
            if (accessToken.isEmpty) {
              throw Exception("Access token is missing");
            }
            await uploadFileNotifier.upload(accessToken, file);
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Tải file lên thành công!")));
          } catch (e) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Lỗi khi tải file lên: $e")));
          } finally {
            isUploading.value = false;
          }
        }

        return Scaffold(
          appBar: AppBar(title: Text("Chọn & Gửi File PDF/DOCX")),
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: pickFile,
                    child: Text("📂 Chọn File"),
                  ),
                  SizedBox(height: 16),

                  if (fileName.value != null) ...[
                    Text(
                      "📄 Tên File: ${fileName.value}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: openSelectedFile,
                      child: Text("📖 Mở File"),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: isUploading.value ? null : extractTextFromFile,
                      child:
                          isUploading.value
                              ? CircularProgressIndicator()
                              : Text("⬆️ Gửi lên Server"),
                    ),
                  ],

                  uploadFileState.when(
                    data: (response) {
                      if (response != null) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                generateCompletionNotifier.generateCompletion(
                                  "Bạn là một chuyên gia phân tích CV và trả lời bằng tiếng việt nhé.",
                                  response.content,
                                  "sk-1234567890",
                                );
                                ref.invalidate(uploadFileProvider);
                              },
                              child: Text("🚀 Phân tích CV từ nội dung"),
                            ),
                            generateCompletionState.when(
                              data: (response) {
                                if (response != null) {
                                  return SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 16),
                                        const Text(
                                          "📄 Kết quả phân tích:",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Text(
                                            response
                                                .choices
                                                .first
                                                .message
                                                .content
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                              loading:
                                  () => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                              error:
                                  (error, stack) =>
                                      Text("Lỗi: ${error.toString()}"),
                            ),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    },
                    loading:
                        () => const Center(child: CircularProgressIndicator()),
                    error: (error, stack) => Text("Error: ${error.toString()}"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
