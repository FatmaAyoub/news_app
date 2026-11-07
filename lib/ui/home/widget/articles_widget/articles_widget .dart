import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:news_app/core/resources/app_constants.dart';
import 'package:news_app/ui/home/widget/articles_widget/widget/articles_list/articles_list.dart';
// import 'package:news_app/core/remote/network/api_manager.dart';
import 'package:news_app/data/model/sources/Source.dart';

import 'package:news_app/ui/home/widget/articles_widget/widget/viewmodel/articles_view_model.dart';


class ArticlesWidget extends StatefulWidget {
  final String categoryId;
  const ArticlesWidget({super.key, required this.categoryId});

  @override
  State<ArticlesWidget> createState() => _ArticlesWidgetState();
}

class _ArticlesWidgetState extends State<ArticlesWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ArticlesViewModel()..getSources(widget.categoryId),
      child: BlocBuilder<ArticlesViewModel, ArticlesStates>(
        builder: (context, state) {
          switch (state) {
            case LoadingState():
              {
                return Center(child: CircularProgressIndicator());
              }
            case SuccessState():
              {
                List<Source> sources = state.sourcesList;
                return DefaultTabController(
                  length: sources.length,
                  child: Padding(
                    padding: REdgeInsetsDirectional.only(top: 16, start: 16),
                    child: Column(
                      spacing: 16.h,
                      children: [
                        TabBar(
                          isScrollable: true,
                          tabs: sources
                              .map((source) => Tab(text: source.name))
                              .toList(),
                        ),
                        Expanded(
                          child: Padding(
                            padding: REdgeInsetsDirectional.only(end: 16),
                            child: TabBarView(
                              children: sources
                                  .map(
                                    (source) =>
                                        ArticlesList(sourceId: source.id ?? ""),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            case ErrorState():
              {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.errorMessage),
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<ArticlesViewModel>(context)
                              .getSources(widget.categoryId);
                        },
                        child: Text("Try Again"),
                      ),
                    ],
                  ),
                );
              }
          }
         
        },
      ),
    );
  }
}
