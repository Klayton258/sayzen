import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:gudeza_music/Paginas/Reprodutor.dart';

class Lista extends StatefulWidget {
  Lista({Key key}) : super(key: key);

  @override
  _ListaState createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  final GlobalKey<ReprodutorState> key = GlobalKey<ReprodutorState>();
  List<SongInfo> songs = [];
  int currentIndex = 0;
  void initState() {
    super.initState();
    getTracks();
  }

  void getTracks() async {
    songs = await audioQuery.getSongs();
    setState(() {
      songs = songs;
    });
  }

  void changeTrack(bool isNext) {
    if (isNext) {
      if (currentIndex != songs.length - 1) {
        currentIndex++;
      }
    } else {
      if (currentIndex != 0) {
        currentIndex--;
      }
    }
    key.currentState.setsong(songs[currentIndex]);
  }

  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        itemCount: songs.length,
        itemBuilder: (context, index) => ListTile(
              leading: CircleAvatar(
                  backgroundImage: songs[index].albumArtwork == null
                      ? AssetImage('assets/images/Back.jpg')
                      : FileImage(File(songs[index].albumArtwork))),
              title: Text(songs[index].title),
              subtitle: Text(songs[index].artist),
              trailing: Icon(Icons.monetization_on),
              onTap: () {
                currentIndex = index;
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Reprodutor(
                          changeTrack: changeTrack,
                          songInfo: songs[currentIndex],
                          key: key,
                        )));
              },
            ));
  }
}
