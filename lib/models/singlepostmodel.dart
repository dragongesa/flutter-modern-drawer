// To parse this JSON data, do
//
//     final singlePostModel = singlePostModelFromJson(jsonString);

import 'dart:convert';

SinglePostModel singlePostModelFromJson(String str) =>
    SinglePostModel.fromJson(json.decode(str));

String singlePostModelToJson(SinglePostModel data) =>
    json.encode(data.toJson());

class SinglePostModel {
  SinglePostModel({
    this.kind,
    this.id,
    this.blog,
    this.published,
    this.updated,
    this.url,
    this.selfLink,
    this.title,
    this.content,
    this.images,
    this.author,
    this.replies,
    this.labels,
    this.etag,
  });

  final String kind;
  final String id;
  final Blog blog;
  final DateTime published;
  final DateTime updated;
  final String url;
  final String selfLink;
  final String title;
  final String content;
  final List<Image> images;
  final Author author;
  final Replies replies;
  final List<String> labels;
  final String etag;

  factory SinglePostModel.fromJson(Map<String, dynamic> json) =>
      SinglePostModel(
        kind: json["kind"],
        id: json["id"],
        blog: Blog.fromJson(json["blog"]),
        published: DateTime.parse(json["published"]),
        updated: DateTime.parse(json["updated"]),
        url: json["url"],
        selfLink: json["selfLink"],
        title: json["title"],
        content: json["content"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        author: Author.fromJson(json["author"]),
        replies: Replies.fromJson(json["replies"]),
        labels: List<String>.from(json["labels"].map((x) => x)),
        etag: json["etag"],
      );

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "id": id,
        "blog": blog.toJson(),
        "published": published.toIso8601String(),
        "updated": updated.toIso8601String(),
        "url": url,
        "selfLink": selfLink,
        "title": title,
        "content": content,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
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
