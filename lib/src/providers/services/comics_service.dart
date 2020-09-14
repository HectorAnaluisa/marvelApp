import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:inhered_widget/src/models/comic_model.dart';
import 'package:http/http.dart' as http;

class ComicService {
  String _apiKey = 'efc2f4b901224f213af16918ff76ef43';
  String _url = 'gateway.marvel.com';
  String _hash = 'ba66be8bac5e1992676abcac896a6e1c';
  int _limit = 20;
  int _offset = 0;

  ComicService() {
    Random rand = Random();
    this._offset = rand.nextInt(47585);
  }

  List<ComicModel> _comics = new List();

  final _comicsStream = StreamController<List<ComicModel>>.broadcast();

  Function(List<ComicModel>) get comicSink => _comicsStream.sink.add;

  Stream<List<ComicModel>> get comicStream => _comicsStream.stream; 

  void disposeStreams() {
    _comicsStream?.close();
  }

  Future<List<ComicModel>> getComics() async {
    _offset = _offset + 20;
    final url = Uri.https(_url, '/v1/public/comics', {
      'ts' : '1',
      'apikey' : _apiKey,
      'hash' : _hash,
      'limit' : _limit.toString(),
      'offset' : _offset.toString(),
    });

    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final comics = new Comics.fromJsonList(decodeData['data']['results']);

    _comics.addAll(comics.items);
    comicSink(_comics);

    return comics.items;
  }
}