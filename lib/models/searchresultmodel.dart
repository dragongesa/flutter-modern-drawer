// To parse this JSON data, do
//
//     final searchResultModel = searchResultModelFromJson(jsonString);

import 'dart:convert';

SearchResultModel searchResultModelFromJson(String str) =>
    SearchResultModel.fromJson(json.decode(str));

String searchResultModelToJson(SearchResultModel data) =>
    json.encode(data.toJson());

class SearchResultModel {
  SearchResultModel({
    this.kind,
    this.nextPageToken,
    this.items,
    this.etag,
  });

  final String kind;
  final String nextPageToken;
  final List<Item> items;
  final String etag;

  factory SearchResultModel.fromJson(Map<String, dynamic> json) =>
      SearchResultModel(
        kind: json["kind"],
        nextPageToken: json["nextPageToken"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        etag: json["etag"],
      );

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "nextPageToken": nextPageToken,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "etag": etag,
      };
}

class Item {
  Item({
    this.kind,
    this.id,
    this.blog,
    this.published,
    this.updated,
    this.url,
    this.selfLink,
    this.title,
    this.content,
    this.author,
    this.replies,
    this.labels,
    this.etag,
  });

  final Kind kind;
  final String id;
  final Blog blog;
  final DateTime published;
  final DateTime updated;
  final String url;
  final String selfLink;
  final String title;
  final String content;
  final Author author;
  final Replies replies;
  final List<String> labels;
  final String etag;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        kind: kindValues.map[json["kind"]],
        id: json["id"],
        blog: Blog.fromJson(json["blog"]),
        published: DateTime.parse(json["published"]),
        updated: DateTime.parse(json["updated"]),
        url: json["url"],
        selfLink: json["selfLink"],
        title: json["title"],
        content: json["content"],
        author: Author.fromJson(json["author"]),
        replies: Replies.fromJson(json["replies"]),
        labels: List<String>.from(json["labels"].map((x) => x)),
        etag: json["etag"],
      );

  Map<String, dynamic> toJson() => {
        "kind": kindValues.reverse[kind],
        "id": id,
        "blog": blog.toJson(),
        "published": published.toIso8601String(),
        "updated": updated.toIso8601String(),
        "url": url,
        "selfLink": selfLink,
        "title": title,
        "content": content,
        "author": author.toJson(),
        "replies": replies.toJson(),
        "labels": List<dynamic>.from(labels.map((x) => x)),
        "etag": etag,
      };
}

class Author {
  Author({
    this.id,
    this.displayName,
    this.url,
    this.image,
  });

  final String id;
  final String displayName;
  final String url;
  final Image image;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["id"],
        displayName: json["displayName"],
        url: json["url"],
        image: Image.fromJson(json["image"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "displayName": displayName,
        "url": url,
        "image": image.toJson(),
      };
}

class Image {
  Image({
    this.url,
  });

  final String url;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}

class Blog {
  Blog({
    this.id,
  });

  final String id;

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

enum Kind { BLOGGER_POST }

final kindValues = EnumValues({"blogger#post": Kind.BLOGGER_POST});

class Replies {
  Replies({
    this.totalItems,
    this.selfLink,
  });

  final String totalItems;
  final String selfLink;

  factory Replies.fromJson(Map<String, dynamic> json) => Replies(
        totalItems: json["totalItems"],
        selfLink: json["selfLink"],
      );

  Map<String, dynamic> toJson() => {
        "totalItems": totalItems,
        "selfLink": selfLink,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
