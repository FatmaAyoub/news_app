import 'package:news_app/data/datasource/sources_dao.dart';
import 'package:news_app/data/model/sources/Sources_response.dart';
import 'package:news_app/repository/sources_repo.dart';

class SourcesRepoImpl implements SourcesRepo{
  SourcesDao sourcesDao;
  SourcesRepoImpl(this.sourcesDao);
  @override
  Future<SourcesResponse> FetchSources(String categoryId) {
    return sourcesDao.FetchSources(categoryId);
  }

}