import 'package:dio/dio.dart';
import 'package:flutter_network_layer/data/respositories/post_repository.dart';
import 'package:flutter_network_layer/domain/entities/post.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postGetListProvider =
    StateNotifierProvider<PostGetListNotifier, AsyncValue<PostResponse?>>((
      ref,
    ) {
      final dio = Dio();
      return PostGetListNotifier(PostRepository(dio));
    });

class PostGetListNotifier extends StateNotifier<AsyncValue<PostResponse?>> {
  final PostRepository _postRepository;
  PostGetListNotifier(this._postRepository)
    : super(const AsyncValue.data(null));

  Future<void> getPosts() async {
    state = const AsyncValue.loading();

    try {
      final response = await _postRepository.getPosts();
      state = AsyncValue.data(response);
    } on Exception catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
