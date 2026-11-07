import '../data/model/articles/ArticlesResponse.dart';

abstract interface class ArticlesRepo {
  Future<ArticlesResponse> FetchArticles(
    String sourceId, {
    required int page,
    required int pageSize,
  });

  Future<ArticlesResponse> searchArticles(String query);
}