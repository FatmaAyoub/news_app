import 'package:dio/dio.dart';
import 'package:news_app/core/resources/app_constants.dart';
import 'package:news_app/data/model/articles/ArticlesResponse.dart';
import 'package:news_app/data/model/sources/Sources_response.dart';

class ApiManager {
  static Dio dio = Dio(BaseOptions(baseUrl: "https://newsapi.org"));

  static Future<SourcesResponse> getSources(String categoryId) async {
    var response = await dio.get(
      "/v2/top-headlines/sources",
      queryParameters: {
        "apiKey": AppConstants.apiKey,
        "category": categoryId,
      },
    );
    return SourcesResponse.fromJson(response.data);
  }

  static Future<ArticlesResponse> getArticles(
    String sourceId, {
    required int page,
    required int pageSize,
  }) async {
    var response = await dio.get(
      "/v2/everything",
      queryParameters: {
        "apiKey": AppConstants.apiKey,
        "sources": sourceId,
        "page": page,
        "pageSize": pageSize,
      },
    );
    return ArticlesResponse.fromJson(response.data);
  }

  static Future<ArticlesResponse> searchArticles(String query) async {
    var response = await dio.get(
      "/v2/everything",
      queryParameters: {
        "apiKey": AppConstants.apiKey,
        "q": query,
        "pageSize": 20,
      },
    );
    return ArticlesResponse.fromJson(response.data);
  }
}