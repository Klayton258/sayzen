import 'dart:ui';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:just_audio/just_audio.dart';

class Reprodutor extends StatefulWidget {
  SongInfo songInfo;
  Function changeTrack;
  final GlobalKey<ReprodutorState> key;
  Reprodutor({this.songInfo, this.changeTrack, this.key}) : super(key: key);

  @override
  ReprodutorState createState() => ReprodutorState();
}

class ReprodutorState extends State<Reprodutor> {
  bool isPlaying = false;
  bool isRepeat = false;
  bool isShuffle = false;
  Color colormode, colormodeshuffle;
  double minimuValor = 0.0, maximoValor = 0.0, correnteValor = 0.0;
  String correntTime = '', endTime = '';
  final AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    setsong(widget.songInfo);
  }

  @override
  void dispose() {
    super.dispose();
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

  playsong() {
    setState(() {
      isPlaying = !isPlaying;
    });
    if (isPlaying) {
      player.play();
    } else {
      player.pause();
    }
  }

  repeatSong() async {
    setState(() {
      isRepeat = !isRepeat;
    });
    if (isRepeat) {
      await player.setLoopMode(LoopMode.all);
      colormode = Colors.orange;
    } else {
      await player.setLoopMode(LoopMode.off);
      colormode = Colors.white;
    }
  }

  shuffleSong() async{
    setState(() {
      isShuffle = !isShuffle;
    });
    if (isShuffle) {
     await player.setShuffleModeEnabled(true);
      colormodeshuffle = Colors.orange;
    } else {
     await player.setShuffleModeEnabled(false);
      colormodeshuffle = Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
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
                CircleAvatar(
                    radius: 200,
                    backgroundImage: widget.songInfo.albumArtwork == null
                        ? AssetImage('assets/images/sayzen.png')
                        : FileImage(File(widget.songInfo.albumArtwork))),
                Text(
                  'Now Playing',
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  widget.songInfo.title,
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  widget.songInfo.artist,
                  style: TextStyle(fontSize: 15),
                ),
                Slider(
                  inactiveColor: Colors.orange,
                  activeColor: Colors.white,
                  min: minimuValor,
                  max: maximoValor,
                  value: correnteValor,
                  onChanged: (value) {
                    correnteValor = value;
                    player.seek(Duration(milliseconds: correnteValor.round()));
                  },
                ),
                Container(
                  transform: Matrix4.translationValues(0, -7, 0),
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
                      GestureDetector(
                        child: Icon(isPlaying ? Icons.pause : Icons.play_arrow,
                            size: 40),
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          playsong();
                        },
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
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          child: Icon(
                            isRepeat ? Icons.repeat_one : Icons.repeat,
                            color: colormode,
                          ),
                          onTap: () {
                            repeatSong();
                          },
                        ),
                      ),
                      SizedBox(
                        width: 260,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          child: Icon(
                            isShuffle ? Icons.shuffle : Icons.shuffle,
                            color: colormodeshuffle,
                          ),
                          onTap: () {
                            shuffleSong();
                          },
                        ),
                      )
                    ],
                  ),
                )

                //!         LISTA DE MUSICAS                                              /
              ],
            )),
      ),
    );
  }
}
