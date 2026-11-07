import 'package:news_app/data/model/sources/Sources_response.dart';

abstract interface class SourcesDao {
  Future<SourcesResponse> FetchSources(String categoryId);
}