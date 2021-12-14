import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:gudeza_music/Paginas/Lista.dart';
import 'package:just_audio/just_audio.dart';

class MusicList extends StatefulWidget {
  SongInfo songInfo;
  Function changeTrack;
  final GlobalKey<MusicListState> key;
  MusicList({this.songInfo, this.changeTrack, this.key}) : super(key: key);

  @override
  MusicListState createState() => MusicListState();
}

class MusicListState extends State<MusicList> with TickerProviderStateMixin {
  AnimationController animController;
  AnimationController playController;
  Animation<double> animList;
  Animation<double> animImage;
  Animation<double> animImageBlur;
  bool isAnimatedComplete = false;
  bool isPlaying = false;
  double minimuValor = 0.0, maximoValor = 0.0, correnteValor = 0.0;
  String correntTime = '', endTime = '';
  final AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    animController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    animList = Tween<double>(begin: -200, end: 0.0).animate(
        CurvedAnimation(parent: animController, curve: Curves.easeInOut));
    animImage = Tween<double>(begin: 1.0, end: 0.5).animate(
        CurvedAnimation(parent: animController, curve: Curves.easeInOut));
    animImageBlur = Tween<double>(begin: 0.0, end: 4.0).animate(
        CurvedAnimation(parent: animController, curve: Curves.easeInOut));
    playController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    setsong(widget.songInfo);
  }

  @override
  void dispose() {
    super.dispose();
    animController.dispose();
    player?.dispose();
  }

  void setsong(SongInfo songInfo) async {
    widget.songInfo = songInfo;
    await player.setUrl(widget.songInfo.uri);
    correnteValor = minimuValor;
    maximoValor = player.duration.inMilliseconds.toDouble();
    setState(() {
      correntTime = getDuration(correnteValor);
      endTime = getDuration(maximoValor);
    });
    isPlaying = false;
    playsong();
    player.positionStream.listen((duration) {
      correnteValor = duration.inMilliseconds.toDouble();
      setState(() {
        correntTime = getDuration(correnteValor);
      });
    });
  }

  String getDuration(double value) {
    Duration duration = Duration(milliseconds: value.round());
    return [duration.inMinutes, duration.inSeconds]
        .map((element) => element.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }

  animationInit() {
    if (isAnimatedComplete) {
      animController.reverse();
    } else {
      animController.forward();
    }
    isAnimatedComplete = !isAnimatedComplete;
  }

  playsong() {
    if (isPlaying) {
      playController.reverse();
    } else {
      playController.forward();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
    if (isPlaying) {
      player.play();
    } else {
      player.pause();
    }
  }

  //!        IMAGEM DO ALBUM                                                     /
  Widget stackbody(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        FractionallySizedBox(
          alignment: Alignment.topCenter,
          heightFactor: animImage.value,
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: ExactAssetImage('assets/images/Back.jpg'),
                    fit: BoxFit.cover)),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: animImageBlur.value, sigmaY: animImageBlur.value),
            ),
          ),
        ),

        //!          R E P R O D U T O R                                                              /

        Positioned(
          bottom: animList.value,
          child: GestureDetector(
            onTap: () {
              animationInit();
            },
            child: Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  gradient: LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black87, Colors.black.withOpacity(0.8)])),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Now Playing',
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      'Select',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      ' artistname()',
                      style: TextStyle(fontSize: 15),
                    ),
                    Slider(
                      inactiveColor: Colors.grey[600],
                      activeColor: Colors.white,
                      min: minimuValor,
                      max: maximoValor,
                      value: correnteValor,
                      onChanged: (value) {
                        correnteValor = value;
                        player.seek(
                            Duration(milliseconds: correnteValor.round()));
                      },
                    ),
                    Container(
                      transform: Matrix4.translationValues(0, -5, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            correntTime,
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                          Text(
                            endTime,
                            style: TextStyle(fontSize: 15),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            child: Icon(
                              Icons.skip_previous_sharp,
                              size: 40,
                            ),
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              widget.changeTrack(false);
                            },
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => playsong(),
                              child: AnimatedIcon(
                                  size: 40,
                                  icon: AnimatedIcons.play_pause,
                                  progress: playController),
                            ),
                          ),
                          GestureDetector(
                            child: Icon(
                              Icons.skip_next_sharp,
                              size: 40,
                            ),
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              widget.changeTrack(true);
                            },
                          )
                        ],
                      ),
                    ),

                    //!         LISTA DE MUSICAS                                              /

                    Container(
                        height: MediaQuery.of(context).size.height / 2.8,
                        width: MediaQuery.of(context).size.width,
                        child: Row())
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animController,
      builder: (BuildContext context, widget) {
        return stackbody(context);
      },
    );
  }
}
