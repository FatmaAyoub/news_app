import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/data/model/articles/Article.dart';
import 'package:news_app/repository/articles_repo.dart';

class SearchViewModel extends Cubit<SearchStates> {
  SearchViewModel(this._articlesRepo) : super(SearchInitialState());

  final ArticlesRepo _articlesRepo;
  Timer? _debounce;
  String _lastQuery = "";

  void onQueryChanged(String query) {
    _debounce?.cancel();
    _lastQuery = query.trim();
    if (_lastQuery.isEmpty) {
      emit(SearchInitialState());
      return;
    }
    _debounce = Timer(
      const Duration(milliseconds: 500),
      () => _search(_lastQuery),
    );
  }

  Future<void> _search(String query) async {
    emit(SearchLoadingState());
    try {
      var response = await _articlesRepo.searchArticles(query);
    
      if (isClosed || query != _lastQuery) return;
      if (response.status == "error") {
        emit(SearchErrorState(response.message ?? "Something went wrong"));
      } else {
        emit(SearchSuccessState(response.articles ?? []));
      }
    } catch (e) {
      if (isClosed || query != _lastQuery) return;
      emit(SearchErrorState("No Internet Connection"));
    }
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}

sealed class SearchStates {}

class SearchInitialState extends SearchStates {}

class SearchLoadingState extends SearchStates {}

class SearchSuccessState extends SearchStates {
  List<Article> articles;
  SearchSuccessState(this.articles);
}

class SearchErrorState extends SearchStates {
  String errorMessage;
  SearchErrorState(this.errorMessage);
}