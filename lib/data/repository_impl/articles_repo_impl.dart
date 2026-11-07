import 'package:news_app/data/datasource/articles_dao.dart';
import 'package:news_app/data/model/articles/ArticlesResponse.dart';
import 'package:news_app/repository/articles_repo.dart';

class ArticlesRepoImpl implements ArticlesRepo{
  ArticlesDao articlesDao;
  ArticlesRepoImpl(this.articlesDao);
  @override
  Future<ArticlesResponse> FetchArticles(String sourceId) {
    return articlesDao.FetchArticles(sourceId);
  }

}