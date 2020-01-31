import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popflix/CORE/ProviderModels/UIUpdatesPM.dart';
import 'package:popflix/UI/Shared/MovieItemCard.dart';
import 'package:popflix/UI/Shared/PopularSearchItem.dart';
import 'package:provider/provider.dart';

class SearchTabScreen extends StatefulWidget {
  @override
  _SearchTabScreenState createState() => _SearchTabScreenState();
}

class _SearchTabScreenState extends State<SearchTabScreen> {
  @override
  void didChangeDependencies() {
    Provider.of<UIUpdatePM>(context).randomPopularSearches();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    final model = Provider.of<UIUpdatePM>(context);
    return SafeArea(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
              child: Container(
                color: Colors.grey.withOpacity(.5),
                width: size.width,
                child: TextField(
                  controller: model.searchMoviesController,
                  onChanged: model.searchMovies,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: 'Search for Show, Movie or Anime...'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(
                model
                    .getSearchText()
                    .isNotEmpty
                    ? "Movies and Shows"
                    : "Popular Searches",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                margin: EdgeInsets.all(10),
                height: size.height / 1.5,
                child: model.getSearchText() != null &&
                    model
                        .getSearchText()
                        .isNotEmpty
                    ? GridView.builder(
                    itemCount: model.searchedItems.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 5,
                        crossAxisCount: 3,
                        childAspectRatio: 0.7),
                    itemBuilder: (context, index) {
                      return MovieItemCard(
                        item: model.searchedItems[index],
                      );
                    })
                    : ListView.separated(
                    separatorBuilder: (context, te) {
                      return Divider(height: 2,);
                    },
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return PopularSearchItem(
                        item: model.popularSearches[index],
                      );
                    })),
          ],
        ),
      ),
    );
  }
}
