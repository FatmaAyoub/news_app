import 'package:dio/dio.dart';
import 'package:news_app/core/resources/app_constants.dart';
import 'package:news_app/data/model/articles/ArticlesResponse.dart';
import 'package:news_app/data/model/sources/Sources_response.dart';

class ApiManager {
  static Dio dio = Dio(BaseOptions(baseUrl: "https://newsapi.org"));
  //
  static Future<SourcesResponse> getSources(String categoryId) async {
   
    var response = await dio.get(
      "/v2/top-headlines/sources",
      queryParameters: {
        "apiKey": AppConstants.apiKey,
        "category": categoryId,
      
      },
    );
    var sourcesResponse = SourcesResponse.fromJson(response.data);
    return sourcesResponse;
  }

  static Future<ArticlesResponse> getArticles(String sourceId) async {
    var response = await dio.get(
      "/v2/everything",
      queryParameters: {"apiKey": AppConstants.apiKey, "sources": sourceId},
    );
    var articlesResponse = ArticlesResponse.fromJson(response.data);
    return articlesResponse;
  }
}
