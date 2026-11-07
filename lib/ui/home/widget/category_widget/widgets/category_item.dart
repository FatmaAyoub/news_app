import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/core/resources/assets_manager.dart';
import 'package:news_app/core/resources/colors_manager.dart';
import 'package:news_app/core/resources/strings_manage.dart';
import 'package:news_app/data/model/category_model.dart';

class CategoryItem extends StatelessWidget {
  final int index;
  final CategoryModel category;
  final void Function(CategoryModel) onCategoryClicked;
  const CategoryItem({super.key,required this.onCategoryClicked,required this.index,required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onCategoryClicked(category);
      },
      child: Directionality(
        textDirection: index.isEven?TextDirection.ltr:TextDirection.rtl,
        child: Container(
          height: 198.h,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.r),
            color: ColorsManager.lightPrimaryColor,
          ),
          child: Row(
            children: [
              Expanded(
                  child: Image.asset(category.imagePath,
                    height: 198.h,fit: BoxFit.cover,)),

              Expanded(
                child: Column(
                  crossAxisAlignment: index.isOdd?CrossAxisAlignment.end:CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      category.title,
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(fontSize: 30.sp),
                    ),
                    Container(
                      padding: REdgeInsetsDirectional.only(
                        start: 16
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(84.r),
                        color: ColorsManager.lightSecondaryColor.withValues(
                          alpha: 0.5
                        )
                      ),
                      child: Row(
                        spacing: 10.w,
                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                        children: [
                          Text(StringsManager.viewAll,style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w500
                          ),),
                          CircleAvatar(
                            radius: 27.r,
                            backgroundColor: ColorsManager.lightSecondaryColor,
                            child: SvgPicture.asset(
                              AssetsManager.arrow,
                              matchTextDirection: true,
                              height: 24.h,
                              width: 24.w,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(width: 16.w,),
            ],
          ),
        ),
      ),
    );
  }
}
