import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widgets/flutter_widgets.dart';
import 'package:popflix/CORE/Helpers/Utils.dart';
import 'package:popflix/CORE/ProviderModels/DataFetcherPM.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerView extends StatelessWidget {
  final String youtubeId;

  const TrailerView({Key key, this.youtubeId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<DataFetcherPM>(context);
    String id;
    if (youtubeId == null) {
      id = Utils.convertUrlToId(model.getRandomYoutubeLink());
    } else
      id = youtubeId;

    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: id,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );

    return Container(
      child: VisibilityDetector(
        key: Key(id),
        onVisibilityChanged: (VisibilityInfo info) {
          if(info.visibleFraction  > 0){
            _controller.play();
          }else _controller.pause();
        },
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: false,
          bottomActions: <Widget>[],
        ),
      ),
    );
  }
}
