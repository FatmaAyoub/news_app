import 'package:news_app/core/remote/network/api_manager.dart';
import 'package:news_app/data/datasource/sources_dao.dart';
import 'package:news_app/data/model/sources/Sources_response.dart';

class SourcesApiDaoImpl implements SourcesDao  {
  ApiManager apiManager;
  SourcesApiDaoImpl(this.apiManager);
  @override
  Future<SourcesResponse> FetchSources(String categoryId,) async{
    var response = await ApiManager.getSources(categoryId);
    return response;
  }

}