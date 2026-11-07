import 'package:news_app/data/datasource_impl/articles/articles_api_dao_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/remote/network/api_manager.dart';
import 'package:news_app/data/datasource_impl/articles/articles_api_dao_impl.dart';
import 'package:news_app/data/model/articles/Article.dart';
import 'package:news_app/data/repository_impl/articles_repo_impl.dart';
import 'package:news_app/ui/home/widget/articles_widget/widget/article_item.dart';
import 'package:news_app/ui/home/widget/articles_widget/widget/articles_list/viewmodel/articles_list_view_model.dart';

class ArticlesList extends StatefulWidget {
  final String sourceId;
  const ArticlesList({super.key, required this.sourceId});

  @override
  State<ArticlesList> createState() => _ArticlesListState();
}

class _ArticlesListState extends State<ArticlesList> {
  late final ArticlesListViewModel viewModel;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    viewModel = ArticlesListViewModel(
      ArticlesRepoImpl(ArticlesApiDaoImpl(ApiManager())),
    )..getArticlesList(widget.sourceId);
    scrollController.addListener(onScroll);
  }

  void onScroll() {
    var position = scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 200.h) {
      viewModel.loadMore();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    viewModel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticlesListViewModel, ArticlesListStates>(
      bloc: viewModel,
      builder: (context, state) {
        switch (state) {
          case LoadingState():
            return Center(child: CircularProgressIndicator());
          case SuccessState():
            List<Article> articles = state.articlesList;
            if (articles.isEmpty) {
              return Center(
                child: Text(
                  "No articles found",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              );
            }
            return ListView.separated(
              controller: scrollController,
              itemBuilder: (context, index) {
                if (index == articles.length) {
                  return Center(child: CircularProgressIndicator());
                }
                return ArticleItem(article: articles[index]);
              },
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemCount: articles.length + (state.isLoadingMore ? 1 : 0),
            );
          case ErrorState():
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.errorMessage),
                  ElevatedButton(
                    onPressed: () => viewModel.getArticlesList(widget.sourceId),
                    child: Text("Try Again"),
                  ),
                ],
              ),
            );
        }
      },
    );
  }
}