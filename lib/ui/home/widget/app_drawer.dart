import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/core/resources/assets_manager.dart';
import 'package:news_app/core/resources/colors_manager.dart';
import 'package:news_app/core/resources/strings_manage.dart';

class AppDrawer extends StatelessWidget {
  final void Function() unSelectCategory;
  const AppDrawer({super.key,required this.unSelectCategory});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 269.w,
      backgroundColor: ColorsManager.lightPrimaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero
      ),
      child: Column(
        children: [
          Container(
              color: ColorsManager.lightSecondaryColor,
              width: double.infinity,
              alignment: Alignment.center,
              padding: REdgeInsets.symmetric(
                vertical: 65
              ),
              child: Text(StringsManager.appTitle,style:Theme.of(context).textTheme.headlineMedium,)),
          SizedBox(height: 16.h,),
          InkWell(
            onTap: (){
              unSelectCategory();
            },
            child: Padding(
              padding: REdgeInsetsDirectional.only(
                start: 16
              ),
              child: Row(
                spacing: 8.w,
                children: [
                  SvgPicture.asset(AssetsManager.home,height: 24.h,width: 24.w,),
                  Text(StringsManager.goToHome,style: Theme.of(context).textTheme.titleMedium,)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
