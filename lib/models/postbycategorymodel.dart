// To parse this JSON data, do
//
//     final postByCategoryModel = postByCategoryModelFromJson(jsonString);

import 'dart:convert';

PostByCategoryModel postByCategoryModelFromJson(String str) => PostByCategoryModel.fromJson(json.decode(str));

String postByCategoryModelToJson(PostByCategoryModel data) => json.encode(data.toJson());

class PostByCategoryModel {
    PostByCategoryModel({
        this.version,
        this.encoding,
        this.feed,
    });

    final String version;
    final String encoding;
    final Feed feed;

    factory PostByCategoryModel.fromJson(Map<String, dynamic> json) => PostByCategoryModel(
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
        this.entry,
    });

    final String xmlns;
    final String xmlnsOpenSearch;
    final String xmlnsBlogger;
    final String xmlnsGeorss;
    final String xmlnsGd;
    final String xmlnsThr;
    final Id id;
    final Id updated;
    final List<FeedCategory> category;
    final Subtitle title;
    final Subtitle subtitle;
    final List<Link> link;
    final List<Author> author;
    final Generator generator;
    final Id openSearchTotalResults;
    final Id openSearchStartIndex;
    final Id openSearchItemsPerPage;
    final List<Entry> entry;

    factory Feed.fromJson(Map<String, dynamic> json) => Feed(
        xmlns: json["xmlns"],
        xmlnsOpenSearch: json["xmlns\u0024openSearch"],
        xmlnsBlogger: json["xmlns\u0024blogger"],
        xmlnsGeorss: json["xmlns\u0024georss"],
        xmlnsGd: json["xmlns\u0024gd"],
        xmlnsThr: json["xmlns\u0024thr"],
        id: Id.fromJson(json["id"]),
        updated: Id.fromJson(json["updated"]),
        category: List<FeedCategory>.from(json["category"].map((x) => FeedCategory.fromJson(x))),
        title: Subtitle.fromJson(json["title"]),
        subtitle: Subtitle.fromJson(json["subtitle"]),
        link: List<Link>.from(json["link"].map((x) => Link.fromJson(x))),
        author: List<Author>.from(json["author"].map((x) => Author.fromJson(x))),
        generator: Generator.fromJson(json["generator"]),
        openSearchTotalResults: Id.fromJson(json["openSearch\u0024totalResults"]),
        openSearchStartIndex: Id.fromJson(json["openSearch\u0024startIndex"]),
        openSearchItemsPerPage: Id.fromJson(json["openSearch\u0024itemsPerPage"]),
        entry: List<Entry>.from(json["entry"].map((x) => Entry.fromJson(x))),
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
        "entry": List<dynamic>.from(entry.map((x) => x.toJson())),
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
        uri: json["uri"] == null ? null : Id.fromJson(json["uri"]),
        email: Id.fromJson(json["email"]),
        gdImage: GdImage.fromJson(json["gd\u0024image"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name.toJson(),
        "uri": uri == null ? null : uri.toJson(),
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

class FeedCategory {
    FeedCategory({
        this.term,
    });

    final String term;

    factory FeedCategory.fromJson(Map<String, dynamic> json) => FeedCategory(
        term: json["term"],
    );

    Map<String, dynamic> toJson() => {
        "term": term,
    };
}

class Entry {
    Entry({
        this.id,
        this.published,
        this.updated,
        this.category,
        this.title,
        this.summary,
        this.link,
        this.author,
        this.mediaThumbnail,
    });

    final Id id;
    final Id published;
    final Id updated;
    final List<EntryCategory> category;
    final Subtitle title;
    final Subtitle summary;
    final List<Link> link;
    final List<Author> author;
    final MediaThumbnail mediaThumbnail;

    factory Entry.fromJson(Map<String, dynamic> json) => Entry(
        id: Id.fromJson(json["id"]),
        published: Id.fromJson(json["published"]),
        updated: Id.fromJson(json["updated"]),
        category: List<EntryCategory>.from(json["category"].map((x) => EntryCategory.fromJson(x))),
        title: Subtitle.fromJson(json["title"]),
        summary: Subtitle.fromJson(json["summary"]),
        link: List<Link>.from(json["link"].map((x) => Link.fromJson(x))),
        author: List<Author>.from(json["author"].map((x) => Author.fromJson(x))),
        mediaThumbnail: json["media\u0024thumbnail"] == null ? null : MediaThumbnail.fromJson(json["media\u0024thumbnail"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id.toJson(),
        "published": published.toJson(),
        "updated": updated.toJson(),
        "category": List<dynamic>.from(category.map((x) => x.toJson())),
        "title": title.toJson(),
        "summary": summary.toJson(),
        "link": List<dynamic>.from(link.map((x) => x.toJson())),
        "author": List<dynamic>.from(author.map((x) => x.toJson())),
        "media\u0024thumbnail": mediaThumbnail == null ? null : mediaThumbnail.toJson(),
    };
}

class EntryCategory {
    EntryCategory({
        this.scheme,
        this.term,
    });

    final String scheme;
    final String term;

    factory EntryCategory.fromJson(Map<String, dynamic> json) => EntryCategory(
        scheme: json["scheme"],
        term: json["term"],
    );

    Map<String, dynamic> toJson() => {
        "scheme": scheme,
        "term": term,
    };
}

class Link {
    Link({
        this.rel,
        this.type,
        this.href,
        this.title,
    });

    final String rel;
    final LinkType type;
    final String href;
    final String title;

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        rel: json["rel"],
        type: json["type"] == null ? null : linkTypeValues.map[json["type"]],
        href: json["href"],
        title: json["title"] == null ? null : json["title"],
    );

    Map<String, dynamic> toJson() => {
        "rel": rel,
        "type": type == null ? null : linkTypeValues.reverse[type],
        "href": href,
        "title": title == null ? null : title,
    };
}

enum LinkType { APPLICATION_ATOM_XML, TEXT_HTML }

final linkTypeValues = EnumValues({
    "application/atom+xml": LinkType.APPLICATION_ATOM_XML,
    "text/html": LinkType.TEXT_HTML
});

class MediaThumbnail {
    MediaThumbnail({
        this.url,
        this.height,
        this.width,
        this.xmlnsMedia,
    });

    final String url;
    final String height;
    final String width;
    final String xmlnsMedia;

    factory MediaThumbnail.fromJson(Map<String, dynamic> json) => MediaThumbnail(
        url: json["url"] == null ? null : json["url"],
        height: json["height"],
        width: json["width"],
        xmlnsMedia: json["xmlns\u0024media"] == null ? null : json["xmlns\u0024media"],
    );

    Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "height": height,
        "width": width,
        "xmlns\u0024media": xmlnsMedia == null ? null : xmlnsMedia,
    };
}

class Subtitle {
    Subtitle({
        this.type,
        this.t,
    });

    final SubtitleType type;
    final String t;

    factory Subtitle.fromJson(Map<String, dynamic> json) => Subtitle(
        type: subtitleTypeValues.map[json["type"]],
        t: json["\u0024t"],
    );

    Map<String, dynamic> toJson() => {
        "type": subtitleTypeValues.reverse[type],
        "\u0024t": t,
    };
}

enum SubtitleType { TEXT, HTML }

final subtitleTypeValues = EnumValues({
    "html": SubtitleType.HTML,
    "text": SubtitleType.TEXT
});

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
