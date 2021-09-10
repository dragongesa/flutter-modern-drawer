import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:get/get.dart';
import 'package:newsblogger/controller.dart';
import 'package:newsblogger/models/singlepostmodel.dart' as postModel;
import 'package:timeago/timeago.dart' as timeAgo;
import 'package:url_launcher/url_launcher.dart';

class ViewPostScreen extends StatelessWidget {
  final Controller controller = Get.find();
  final postModel.SinglePostModel post;

  ViewPostScreen(this.post);
  @override
  Widget build(BuildContext context) {
    String tanggalPublish = post.published.day.toString() +
        " " +
        controller.bulan[post.published.month - 1] +
        " " +
        post.published.year.toString();
    bool lebih3Hari;
    if (post.published.millisecondsSinceEpoch >=
        DateTime.now().subtract(Duration(days: 3)).millisecondsSinceEpoch) {
      lebih3Hari = false;
    } else {
      lebih3Hari = true;
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () => Get.back(),
        ),
        centerTitle: false,
        title: Container(
          height: 40,
          child: Row(
            children: [
              CircleAvatar(
                maxRadius: 16,
                backgroundImage: NetworkImage("https:" + post.author.image.url),
              ),
              SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    post.author.displayName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Penulis",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
              tooltip: "Share Link Sis",
              icon: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(pi),
                child: Icon(
                  Icons.reply,
                ),
              ),
              onPressed: () {}),
          IconButton(
              tooltip: "Bookmark Halaman ini yuk!",
              icon: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(pi),
                child: Icon(
                  Icons.bookmark_outline_rounded,
                ),
              ),
              onPressed: () {})
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      post.labels[0],
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    lebih3Hari
                        ? tanggalPublish
                        : timeAgo.format(
                            post.published,
                            allowFromNow: true,
                          ),
                    style: TextStyle(
                      color: Colors.black.withOpacity(.3),
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                post.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(20),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(post.images[0].url)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Html(
                  onLinkTap: (url) {
                    final key = new GlobalKey();
                    print(url);
                    Get.dialog(AlertDialog(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      content: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Text("Ingin Mengunjungi link ini?"),
                                    SizedBox(height: 10),
                                    InkWell(
                                      onLongPress: () {
                                        Clipboard.setData(
                                            new ClipboardData(text: url));
                                        final dynamic tooltip =
                                            key.currentState;
                                        tooltip.ensureTooltipVisible();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.blue[100],
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 3),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Flexible(
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Text(
                                                  url,
                                                  textAlign: TextAlign.center,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              Icons.copy_rounded,
                                              size: 12,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Tooltip(key: key, message: "Text Copied!",preferBelow: false,)
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: InkWell(
                                      child: Text("Kunjungi"),
                                      onTap: () async {
                                        print(url);
                                        await launch(url);
                                        Get.back();
                                      },
                                    ),
                                  ),
                                  Container(
                                    color: Colors.black.withOpacity(.1),
                                    width: 1,
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: InkWell(
                                      child: Text("batal"),
                                      onTap: () {
                                        Get.back();
                                      },
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ));
                  },
                  customRender: {
                    "img": (context, child, attr, el) {
                      return Builder(builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(.5),
                                      blurRadius: 15,
                                      spreadRadius: -1,
                                      offset: Offset(0, 3))
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  attr['src'],
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                    }
                  },
                  onImageTap: (image) {
                    print("tapped $image");
                    print("babi");
                  },
                  style: {
                    "body": Style(margin: EdgeInsets.all(0),fontSize: FontSize(16)),
                    "div": Style(margin: EdgeInsets.all(0)),
                    "*": Style(
                      margin: EdgeInsets.symmetric(horizontal: 0),
                      lineHeight: 2,
                      wordSpacing: 2,
                      letterSpacing: 0.3,
                    ),
                  },
                  data: post.content),
            ),
          ],
        ),
      ),
    );
  }
}
