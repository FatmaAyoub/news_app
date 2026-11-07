import 'package:news_app/data/model/sources/Sources_response.dart';

abstract interface class SourcesRepo {
  Future<SourcesResponse> FetchSources(String categoryId);
}