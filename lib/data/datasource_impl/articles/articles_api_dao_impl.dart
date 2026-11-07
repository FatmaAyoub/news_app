import 'package:news_app/core/remote/network/api_manager.dart';
import 'package:news_app/data/datasource/articles_dao.dart';
import 'package:news_app/data/model/articles/ArticlesResponse.dart';

class ArticlesApiDaoImpl implements ArticlesDao {
  ApiManager apiManager;
  ArticlesApiDaoImpl(this.apiManager);

  @override
  Future<ArticlesResponse> FetchArticles(
    String sourceId, {
    required int page,
    required int pageSize,
  }) {
    return ApiManager.getArticles(sourceId, page: page, pageSize: pageSize);
  }

  @override
  Future<ArticlesResponse> searchArticles(String query) {
    return ApiManager.searchArticles(query);
  }
}