import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/data/model/articles/Article.dart';
import 'package:news_app/repository/articles_repo.dart';

class ArticlesListViewModel extends Cubit<ArticlesListStates> {
  ArticlesListViewModel(this._articlesRepo) : super(LoadingState());

  static const int _pageSize = 10;

  final ArticlesRepo _articlesRepo;
  final List<Article> _articles = [];
  String _sourceId = "";
  int _page = 1;
  bool _hasMore = true;
  bool _isFetching = false;

  Future<void> getArticlesList(String sourceId) async {
    _sourceId = sourceId;
    _articles.clear();
    _page = 1;
    _hasMore = true;
    emit(LoadingState());
    await _fetchPage();
  }

  Future<void> loadMore() async {
    if (_isFetching || !_hasMore) return;
    emit(SuccessState(List.of(_articles), isLoadingMore: true));
    await _fetchPage();
  }

  Future<void> _fetchPage() async {
    _isFetching = true;
    try {
      var response = await _articlesRepo.FetchArticles(
        _sourceId,
        page: _page,
        pageSize: _pageSize,
      );
      if (response.status == "error") {
        _handleFailure(response.message ?? "Something went wrong");
        return;
      }
      var newArticles = response.articles ?? [];
      _articles.addAll(newArticles);
      _page++;
      _hasMore = newArticles.length == _pageSize &&
          _articles.length < (response.totalResults ?? 0);
      emit(SuccessState(List.of(_articles)));
    } catch (e) {
      _handleFailure("No Internet Connection");
    } finally {
      _isFetching = false;
    }
  }


  void _handleFailure(String message) {
    if (_articles.isEmpty) {
      emit(ErrorState(message));
    } else {
      _hasMore = false;
      emit(SuccessState(List.of(_articles)));
    }
  }
}

sealed class ArticlesListStates {}

class LoadingState extends ArticlesListStates {}

class SuccessState extends ArticlesListStates {
  List<Article> articlesList;
  bool isLoadingMore;
  SuccessState(this.articlesList, {this.isLoadingMore = false});
}

class ErrorState extends ArticlesListStates {
  String errorMessage;
  ErrorState(this.errorMessage);
}