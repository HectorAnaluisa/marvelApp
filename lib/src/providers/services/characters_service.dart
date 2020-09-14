import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:inhered_widget/src/models/characters_model.dart';
import 'package:http/http.dart' as http;

class CharactersService {
  String _apiKey = 'efc2f4b901224f213af16918ff76ef43';
  String _url = 'gateway.marvel.com';
  String _hash = 'ba66be8bac5e1992676abcac896a6e1c';
  int _limit = 20;
  int _offset = 0;
  // bool _loadData = false;

  CharactersService() {
    Random rand = Random();
    this._offset = rand.nextInt(1453);
  }

  List<CharactersModel> _characters = new List();

  final _chractersStream = StreamController<List<CharactersModel>>.broadcast();

  Function(List<CharactersModel>) get charactersSink => _chractersStream.sink.add;

  Stream<List<CharactersModel>> get charactersSteam => _chractersStream.stream; 

  void disposeStreams() {
    _chractersStream?.close();
  }

  Future<List<CharactersModel>> getCharacters() async {
    _offset = _offset + 20;
    final url = Uri.https(_url, '/v1/public/characters', {
      'ts' : '1',
      'apikey' : _apiKey,
      'hash' : _hash,
      'limit' : _limit.toString(),
      'offset' : _offset.toString(),
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final characters = new Characters.fromJsonList(decodedData['data']['results']);

    _characters.addAll(characters.items);
    charactersSink(_characters);

    return characters.items;
  }

}