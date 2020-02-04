import 'package:flutter/cupertino.dart';
import 'package:popflix/CORE/Models/ApiRM/GetAnimeDetailsRM.dart';
import 'package:popflix/CORE/Repository/Repository.dart';

class AnimeDetailsPM extends ChangeNotifier {
  AnimeDetailsRm singleAnimeDetail;
  int currentSeasonToDisplay = 1;
  List<Episode> episodesToDisplay;

  getShowDetails(String id) async {
    Repository.fetchAnimeDetails(id).then((response) {
      print("Response : " + response.body.toString());
      singleAnimeDetail = (animeDetailsRmFromJson(response.body.toString()));
      currentSeasonToDisplay = 1;
      episodesToDisplay = singleAnimeDetail.episodes.where((test) {
        if (test.season == currentSeasonToDisplay.toString())
          return true;
        else
          return false;
      }).toList();
      notifyListeners();
    });
  }

  changeCurrentSeasonDisplay(int i) {
    currentSeasonToDisplay = i;
    episodesToDisplay = singleAnimeDetail.episodes.where((test) {
      if (test.season == currentSeasonToDisplay.toString())
        return true;
      else
        return false;
    }).toList();
    notifyListeners();
  }
}
