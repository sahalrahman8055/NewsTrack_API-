import 'package:flutter/material.dart';
import 'package:newstrack/model/article_model.dart';
import 'package:newstrack/services/news.dart';

class NewsProvider extends ChangeNotifier {
  List<ArticleModel> articles = <ArticleModel>[];
  bool loading = true;

  void changeLoading() {
    loading = !loading;
  }

  void getAllNews() async {
    News newsClass = News();
    articles = await newsClass.getNews();
    notifyListeners();
  }

  void getAllCategoryNews(String category) async {
    CategoryNewsClass categoryNewsClass = CategoryNewsClass();

    articles = await categoryNewsClass.getCategoryNews(category);
    notifyListeners();
  }
}
