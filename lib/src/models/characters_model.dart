
import 'dart:convert';


CharactersModel charactersModelFromJson(String str) => CharactersModel.fromJson(json.decode(str));

String charactersModelToJson(CharactersModel data) => json.encode(data.toJson());


class Characters {
  List<CharactersModel> items = new List();
  Characters();
  Characters.fromJsonList( List<dynamic> jsonList) {
    if(jsonList == null) return;
    for ( var item in jsonList) {
      final charactersModel = new CharactersModel.fromJson(item);
      items.add(charactersModel);
    }
  }
}

class CharactersModel {
    CharactersModel({
        this.id,
        this.name,
        this.description,
        this.modified,
        this.thumbnail,
    });

    int id;
    String name;
    String description;
    String modified;
    Thumbnail thumbnail;

    factory CharactersModel.fromJson(Map<String, dynamic> json) => CharactersModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        modified: json["modified"],
        thumbnail: Thumbnail.fromJson(json["thumbnail"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "modified": modified,
        "thumbnail": thumbnail.toJson(),
    };
}

class Thumbnail {
    Thumbnail({
        this.path,
        this.extention,
    });

    String path;
    String extention;

    factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        path: json["path"],
        extention: json["extension"],
    );

    Map<String, dynamic> toJson() => {
        "path": path,
        "extention": extention,
    };
}