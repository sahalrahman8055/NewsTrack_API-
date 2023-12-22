import 'package:flutter/material.dart';
import 'package:newstrack/model/article_model.dart';
import 'package:newstrack/services/category_news.dart';


class CategoryController extends ChangeNotifier {
  bool loading = true;

  List<ArticleModel> articlnews = [];

  getCategoryNews(category) async {
    CategoryNewsServices newsServices = CategoryNewsServices();
    await newsServices.fetchCategoryNews(category);
    articlnews = newsServices.news;

    loading = false;

    notifyListeners();
  }
}
