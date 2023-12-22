import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newstrack/controller/category_provider.dart';
import 'package:newstrack/controller/home_provider.dart';
import 'package:newstrack/helper/data.dart';
import 'package:newstrack/view/article/article_view.dart';
import 'package:newstrack/view/category/category_news.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List<ArticleModel> article = [];

  @override
  void initState() {
    super.initState();

   final provider = Provider.of<HomeControl>(context, listen: false);
    provider.getNews();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("News"),
            Text(
              "Track",
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
      body: Consumer<HomeControl>(
        builder: (context, value, child) {
          return value.loading
              ? Center(
                  child: Container(
                    child: CircularProgressIndicator(),
                  ),
                )
              : SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Container(
                          height: 80,
                          child: ListView.builder(
                            itemCount: categories.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return CategoryTile(
                                  imageUrl: categories[index].imageUrl,
                                  categoryName:
                                      categories[index].categoryName);
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 16),
                          child: Consumer<HomeControl>(
                            builder: (context, newsProvider, child) {
                              return ListView.builder(
                                itemCount: newsProvider.articles.length,
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return BlogTile(
                                    imageUrl:
                                        newsProvider.articles[index].urlToImage,
                                    title: newsProvider.articles[index].title,
                                    desc: newsProvider
                                        .articles[index].description,
                                    url: newsProvider.articles[index].url,
                                  );
                                },
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final imageUrl, categoryName;
  const CategoryTile({super.key, this.imageUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CategoryScreen(category: categoryName.toLowerCase()),
            ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: CachedNetworkImage(
                imageUrl: imageUrl ?? 'Image Not Found',
                width: 120,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.black26,
              ),
              width: 120,
              height: 60,
              child: Text(
                categoryName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  const BlogTile(
      {super.key,
      required this.imageUrl,
      required this.desc,
      required this.title,
      required this.url});
  final imageUrl, title, desc, url;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleView(blogUrl: url),
            ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(imageUrl ??
                  "https://www.smaroadsafety.com/wp-content/uploads/2022/06/no-pic.png")),
            Text(
              title ?? "Text Note Found",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
               desc ?? "Text Not Found",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
