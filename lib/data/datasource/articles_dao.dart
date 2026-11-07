
import 'package:news_app/data/model/articles/ArticlesResponse.dart';

abstract interface class ArticlesDao {
  Future<ArticlesResponse> FetchArticles(String sourceId);
}
