import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/core/resources/assets_manager.dart';
import 'package:news_app/core/resources/strings_manage.dart';
// import 'package:news_app/core/remote/network/api_manager.dart';
import 'package:news_app/data/model/category_model.dart';
import 'package:news_app/ui/home/widget/app_drawer.dart';
import 'package:news_app/ui/home/widget/articles_widget/articles_widget .dart';
import 'package:news_app/ui/home/widget/category_widget/categories_widget.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CategoryModel? selectedCategory;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(
        unSelectCategory: unselectCategory,
      ),
      appBar: AppBar(
        title: Text(
          selectedCategory != null
              ? selectedCategory!.title
              : StringsManager.home,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              AssetsManager.search,
              height: 24.h,
              width: 24.w,
            ),
          ),
        ],
      ),
        body: selectedCategory != null ? ArticlesWidget(categoryId: selectedCategory!.id,) : CategoriesWidget(
        onCategoryClicked: chooseCategory,
      ),
    );
  }

  void chooseCategory(CategoryModel newCategory){
    selectedCategory = newCategory;
    setState(() {

    });
  }

  void unselectCategory(){
    selectedCategory = null;
    Navigator.of(context).pop();
    setState(() {

    });
  }
}
