import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/resources/colors_manager.dart';
import 'package:news_app/data/model/articles/Article.dart';
import 'package:news_app/ui/article_details/screen/article_web_view_screen.dart';

class ArticleBottomSheet extends StatelessWidget {
  final Article article;
  const ArticleBottomSheet({super.key, required this.article});

  static void show(BuildContext context, Article article) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ArticleBottomSheet(article: article),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: REdgeInsets.all(16),
        padding: REdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: ColorsManager.lightPrimaryColor),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 10.h,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  article.urlToImage ?? "",
                  height: 220.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                article.content ?? article.description ?? "",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => openFullArticle(context),
                  child: Text("View Full Article"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void openFullArticle(BuildContext context) {
    var navigator = Navigator.of(context);
    navigator.pop();
    navigator.push(
      MaterialPageRoute(
        builder: (_) => ArticleWebViewScreen(article: article),
      ),
    );
  }
}