// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({
    this.version,
    this.encoding,
    this.feed,
  });

  final String version;
  final String encoding;
  final Feed feed;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        version: json["version"],
        encoding: json["encoding"],
        feed: Feed.fromJson(json["feed"]),
      );

  Map<String, dynamic> toJson() => {
        "version": version,
        "encoding": encoding,
        "feed": feed.toJson(),
      };
}

class Feed {
  Feed({
    this.xmlns,
    this.xmlnsOpenSearch,
    this.xmlnsBlogger,
    this.xmlnsGeorss,
    this.xmlnsGd,
    this.xmlnsThr,
    this.id,
    this.updated,
    this.category,
    this.title,
    this.subtitle,
    this.link,
    this.author,
    this.generator,
    this.openSearchTotalResults,
    this.openSearchStartIndex,
    this.openSearchItemsPerPage,
  });

  final String xmlns;
  final String xmlnsOpenSearch;
  final String xmlnsBlogger;
  final String xmlnsGeorss;
  final String xmlnsGd;
  final String xmlnsThr;
  final Id id;
  final Id updated;
  final List<Category> category;
  final Title title;
  final Title subtitle;
  final List<Link> link;
  final List<Author> author;
  final Generator generator;
  final Id openSearchTotalResults;
  final Id openSearchStartIndex;
  final Id openSearchItemsPerPage;

  factory Feed.fromJson(Map<String, dynamic> json) => Feed(
        xmlns: json["xmlns"],
        xmlnsOpenSearch: json["xmlns\u0024openSearch"],
        xmlnsBlogger: json["xmlns\u0024blogger"],
        xmlnsGeorss: json["xmlns\u0024georss"],
        xmlnsGd: json["xmlns\u0024gd"],
        xmlnsThr: json["xmlns\u0024thr"],
        id: Id.fromJson(json["id"]),
        updated: Id.fromJson(json["updated"]),
        category: List<Category>.from(
            json["category"].map((x) => Category.fromJson(x))),
        title: Title.fromJson(json["title"]),
        subtitle: Title.fromJson(json["subtitle"]),
        link: List<Link>.from(json["link"].map((x) => Link.fromJson(x))),
        author:
            List<Author>.from(json["author"].map((x) => Author.fromJson(x))),
        generator: Generator.fromJson(json["generator"]),
        openSearchTotalResults:
            Id.fromJson(json["openSearch\u0024totalResults"]),
        openSearchStartIndex: Id.fromJson(json["openSearch\u0024startIndex"]),
        openSearchItemsPerPage:
            Id.fromJson(json["openSearch\u0024itemsPerPage"]),
      );

  Map<String, dynamic> toJson() => {
        "xmlns": xmlns,
        "xmlns\u0024openSearch": xmlnsOpenSearch,
        "xmlns\u0024blogger": xmlnsBlogger,
        "xmlns\u0024georss": xmlnsGeorss,
        "xmlns\u0024gd": xmlnsGd,
        "xmlns\u0024thr": xmlnsThr,
        "id": id.toJson(),
        "updated": updated.toJson(),
        "category": List<dynamic>.from(category.map((x) => x.toJson())),
        "title": title.toJson(),
        "subtitle": subtitle.toJson(),
        "link": List<dynamic>.from(link.map((x) => x.toJson())),
        "author": List<dynamic>.from(author.map((x) => x.toJson())),
        "generator": generator.toJson(),
        "openSearch\u0024totalResults": openSearchTotalResults.toJson(),
        "openSearch\u0024startIndex": openSearchStartIndex.toJson(),
        "openSearch\u0024itemsPerPage": openSearchItemsPerPage.toJson(),
      };
}

class Author {
  Author({
    this.name,
    this.uri,
    this.email,
    this.gdImage,
  });

  final Id name;
  final Id uri;
  final Id email;
  final GdImage gdImage;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        name: Id.fromJson(json["name"]),
        uri: Id.fromJson(json["uri"]),
        email: Id.fromJson(json["email"]),
        gdImage: GdImage.fromJson(json["gd\u0024image"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name.toJson(),
        "uri": uri.toJson(),
        "email": email.toJson(),
        "gd\u0024image": gdImage.toJson(),
      };
}

class Id {
  Id({
    this.t,
  });

  final String t;

  factory Id.fromJson(Map<String, dynamic> json) => Id(
        t: json["\u0024t"],
      );

  Map<String, dynamic> toJson() => {
        "\u0024t": t,
      };
}

class GdImage {
  GdImage({
    this.rel,
    this.width,
    this.height,
    this.src,
  });

  final String rel;
  final String width;
  final String height;
  final String src;

  factory GdImage.fromJson(Map<String, dynamic> json) => GdImage(
        rel: json["rel"],
        width: json["width"],
        height: json["height"],
        src: json["src"],
      );

  Map<String, dynamic> toJson() => {
        "rel": rel,
        "width": width,
        "height": height,
        "src": src,
      };
}

class Category {
  Category({
    this.term,
  });

  final String term;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        term: json["term"],
      );

  Map<String, dynamic> toJson() => {
        "term": term,
      };
}

class Generator {
  Generator({
    this.version,
    this.uri,
    this.t,
  });

  final String version;
  final String uri;
  final String t;

  factory Generator.fromJson(Map<String, dynamic> json) => Generator(
        version: json["version"],
        uri: json["uri"],
        t: json["\u0024t"],
      );

  Map<String, dynamic> toJson() => {
        "version": version,
        "uri": uri,
        "\u0024t": t,
      };
}

class Link {
  Link({
    this.rel,
    this.type,
    this.href,
  });

  final String rel;
  final String type;
  final String href;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        rel: json["rel"],
        type: json["type"] == null ? null : json["type"],
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "rel": rel,
        "type": type == null ? null : type,
        "href": href,
      };
}

class Title {
  Title({
    this.type,
    this.t,
  });

  final String type;
  final String t;

  factory Title.fromJson(Map<String, dynamic> json) => Title(
        type: json["type"],
        t: json["\u0024t"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "\u0024t": t,
      };
}
