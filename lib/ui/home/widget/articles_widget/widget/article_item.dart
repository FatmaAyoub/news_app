import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/resources/colors_manager.dart';
import '../../../../../data/model/articles/Article.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'article_bottom_sheet.dart';

class ArticleItem extends StatelessWidget {
  final Article article;
  const ArticleItem({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ArticleBottomSheet.show(context, article),
      child: Container(
        padding: REdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: ColorsManager.lightPrimaryColor),
        ),
        child: Column(
          spacing: 10.h,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.network(
                article.urlToImage ?? "",
                height: 220.h,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              article.title ?? "",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: 16.sp,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "By : ${article.author ?? ""}",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                Text(
                  timeago.format(DateTime.parse(article.publishedAt ?? "")),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}