import '../data/model/articles/ArticlesResponse.dart';

abstract interface class ArticlesRepo {
  Future<ArticlesResponse> FetchArticles(String sourceId);
}