
import 'dart:convert';

ComicModel comicModelFromJson(String str) => ComicModel.fromJson(json.decode(str));

String comicModelToJson(ComicModel data) => json.encode(data.toJson());

class Comics {
  List<ComicModel> items = new List();
  Comics();
  Comics.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for ( var item in jsonList ) {
      final comicModel = new ComicModel.fromJson(item);
      items.add(comicModel);
    }
  } 
}
class ComicModel {
    ComicModel({
        this.id,
        this.title,
        this.modified,
        this.format,
        this.pageCount,
        this.thumbnail,
        this.images,
    });

    int id;
    String title;
    String modified;
    String format;
    int pageCount;
    Thumbnail thumbnail;
    List<Thumbnail> images;

    factory ComicModel.fromJson(Map<String, dynamic> json) => ComicModel(
        id: json["id"],
        title: json["title"],
        modified: json["modified"],
        format: json["format"],
        pageCount: json["pageCount"],
        thumbnail: Thumbnail.fromJson(json["thumbnail"]),
        images: List<Thumbnail>.from(json["images"].map((x) => Thumbnail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "modified": modified,
        "format": format,
        "pageCount": pageCount,
        "thumbnail": thumbnail.toJson(),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
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
        "extension": extention,
    };
}