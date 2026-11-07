import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/remote/network/api_manager.dart';
import 'package:news_app/data/datasource_impl/articles/articles_api_dao_impl.dart';
import 'package:news_app/data/repository_impl/articles_repo_impl.dart';
import 'package:news_app/ui/home/widget/articles_widget/widget/article_item.dart';
import 'package:news_app/ui/search/viewmodel/search_view_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final SearchViewModel viewModel;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    viewModel = SearchViewModel(
      ArticlesRepoImpl(ArticlesApiDaoImpl(ApiManager())),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    viewModel.close();
    super.dispose();
  }

  void clearSearch() {
    searchController.clear();
    viewModel.onQueryChanged("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          autofocus: true,
          onChanged: viewModel.onQueryChanged,
          decoration: InputDecoration(
            hintText: "Search",
            prefixIcon: Icon(Icons.search),
            suffixIcon: IconButton(
              onPressed: clearSearch,
              icon: Icon(Icons.close),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
        ),
      ),
      body: BlocBuilder<SearchViewModel, SearchStates>(
        bloc: viewModel,
        builder: (context, state) {
          switch (state) {
            case SearchInitialState():
              return Center(
                child: Text(
                  "Search for news",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              );
            case SearchLoadingState():
              return Center(child: CircularProgressIndicator());
            case SearchSuccessState():
              if (state.articles.isEmpty) {
                return Center(
                  child: Text(
                    "No results found",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                );
              }
              return ListView.separated(
                padding: REdgeInsets.all(16),
                itemBuilder: (context, index) =>
                    ArticleItem(article: state.articles[index]),
                separatorBuilder: (context, index) => SizedBox(height: 16.h),
                itemCount: state.articles.length,
              );
            case SearchErrorState():
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.errorMessage),
                    ElevatedButton(
                      onPressed: () =>
                          viewModel.onQueryChanged(searchController.text),
                      child: Text("Try Again"),
                    ),
                  ],
                ),
              );
          }
        },
      ),
    );
  }
}