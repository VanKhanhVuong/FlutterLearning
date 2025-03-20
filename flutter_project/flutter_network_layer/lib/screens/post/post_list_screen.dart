import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_network_layer/notifier/post/post_get_list_notifier.dart';
import 'package:flutter_network_layer/screens/post/post_detail_screen.dart';
import 'package:flutter_network_layer/shared/styled_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostListScreen extends HookWidget {
  const PostListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = useState<bool>(false);
    final errorFeedback = useState<String?>(null);

    return Scaffold(
      appBar: AppBar(
        title: const StyledAppBarText('Post List'),
        backgroundColor: Colors.blue[500],
        centerTitle: true,
        actions: [
          Consumer(
            builder: (context, ref, child) {
              return IconButton(
                icon: const Icon(Icons.refresh),
                onPressed:
                    isLoading.value
                        ? null
                        : () => _handleGetPost(ref, isLoading, errorFeedback),
              );
            },
          ),
        ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final postState = ref.watch(postGetListProvider);

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                if (errorFeedback.value != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      errorFeedback.value!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                Expanded(
                  child: postState.when(
                    data: (postResponse) {
                      if (postResponse == null || postResponse.data.isEmpty) {
                        return const Center(child: Text("Không có dữ liệu"));
                      }
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        clipBehavior: Clip.antiAlias,
                        itemCount: postResponse.data.length,
                        itemBuilder: (context, index) {
                          final post = postResponse.data[index];
                          return _buildPostItem(context, post);
                        },
                      );
                    },
                    loading:
                        () => const Center(child: CircularProgressIndicator()),
                    error: (error, stack) => Center(child: Text("Lỗi: $error")),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: Consumer(
        builder: (context, ref, child) {
          return FloatingActionButton(
            onPressed:
                isLoading.value
                    ? null
                    : () => _handleGetPost(ref, isLoading, errorFeedback),
            backgroundColor: isLoading.value ? Colors.grey : Colors.blue,
            child:
                isLoading.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Icon(Icons.download),
          );
        },
      ),
    );
  }

  void _handleGetPost(
    WidgetRef ref,
    ValueNotifier<bool> isLoading,
    ValueNotifier<String?> errorFeedback,
  ) async {
    final postNotifier = ref.read(postGetListProvider.notifier);

    errorFeedback.value = null;
    isLoading.value = true;

    try {
      await postNotifier.getPosts();
    } catch (error) {
      errorFeedback.value = error.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Widget _buildPostItem(BuildContext context, dynamic post) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PostDetailScreen(post: post)),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: CachedNetworkImage(
                  imageUrl: post.image,
                  placeholder:
                      (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                  errorWidget:
                      (context, url, error) => const Center(
                        child: Icon(Icons.error, color: Colors.red),
                      ),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 180,
                ),
              ),
              const SizedBox(height: 8.0),
              StyledBodyText(post.name),
            ],
          ),
        ),
      ),
    );
  }
}
