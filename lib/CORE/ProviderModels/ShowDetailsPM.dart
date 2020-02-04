import 'package:flutter/cupertino.dart';
import 'package:popflix/CORE/Models/ApiRM/GetShowDetailsRM.dart';
import 'package:popflix/CORE/Repository/Repository.dart';

class ShowDetailsPM extends ChangeNotifier {
  ShowDetailsRm singleShowDetail;
  int currentSeasonToDisplay = 1;
  List<Episode> episodesToDisplay;

  getShowDetails(String imdbId) async {
    Repository.fetchShowDetails(imdbId).then((response) {
      singleShowDetail = (showDetailsRmFromJson(response.body.toString()));
      currentSeasonToDisplay = 1;
      episodesToDisplay = singleShowDetail.episodes.where((test) {
        if (test.season == currentSeasonToDisplay)
          return true;
        else
          return false;
      }).toList();
      notifyListeners();
    });
  }

  changeCurrentSeasonDisplay(int i) {
    currentSeasonToDisplay = i;
    episodesToDisplay = singleShowDetail.episodes.where((test) {
      if (test.season == currentSeasonToDisplay)
        return true;
      else
        return false;
    }).toList();
    notifyListeners();
  }
}
