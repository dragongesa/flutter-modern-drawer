import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:newsblogger/controller.dart';
import 'package:newsblogger/screens/searchscreen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeago/timeago.dart' as timeAgo;

// ignore: unused_import
import 'labellistscreen.dart';
import 'testscreen.dart';

class MainScreen extends StatelessWidget {
  final Controller controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0, .5, 1],
          colors: [
            Colors.white,
            Color(0xffF2F2F2),
            Color(0xffF2F2F2),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).padding.top + 40),
              child:
                    Obx(
                      () => LazyLoadScrollView(
                        onEndOfPage: () async {
                          print("end");
                          controller.fetchNextPost();
                        },
                        isLoading: controller.isLoading.value,
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Obx(
                              () => Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                margin: EdgeInsets.only(left: 15),
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      controller.category.value.feed == null
                                          ? 1
                                          : controller.category.value.feed
                                              .category.length,
                                  itemBuilder: (c, i) {
                                    if (controller.category.value.feed ==
                                        null) {
                                      return Center(
                                          child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  30,
                                              child: LinearProgressIndicator(
                                                  minHeight: 2)));
                                    }
                                    if (i + 1 ==
                                        controller.category.value.feed.category
                                            .length) {
                                      return Center(
                                        child: Padding(
                                          padding: i + 1 ==
                                                  controller.category.value.feed
                                                      .category.length
                                              ? const EdgeInsets.fromLTRB(
                                                  10, 10, 15, 10)
                                              : const EdgeInsets.fromLTRB(
                                                  10, 10, 10, 10),
                                          child: Text(controller.category.value
                                              .feed.category[i].term),
                                        ),
                                      );
                                    }
                                    return Center(
                                      child: InkWell(
                                        onTap: () => controller
                                            .fetchPostByLabel(controller
                                                .category
                                                .value
                                                .feed
                                                .category[i]
                                                .term),
                                        child: Container(
                                          margin: EdgeInsets.only(right: 10),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(controller.category
                                                .value.feed.category[i].term),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 180,
                              margin: EdgeInsets.only(left: 15),
                              child: Obx(
                                () => ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        controller.featuredPost.value.feed ==
                                                null
                                            ? 3
                                            : controller.featuredPost.value.feed
                                                .entry.length,
                                    itemBuilder: (c, i) {
                                      // ignore: unrelated_type_equality_checks
                                      if (controller.featuredPost.value.feed ==
                                          null) {
                                        return Shimmer.fromColors(
                                          baseColor:
                                              Colors.grey.withOpacity(.2),
                                          highlightColor:
                                              Colors.grey.withOpacity(.1),
                                          enabled: true,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Colors.black,
                                            ),
                                            width: 130,
                                            height: 180,
                                            margin: EdgeInsets.only(right: 10),
                                          ),
                                        );
                                      } else {
                                        String featuredTanggal = DateTime.parse(
                                                    controller
                                                        .featuredPost
                                                        .value
                                                        .feed
                                                        .entry[i]
                                                        .published
                                                        .t)
                                                .day
                                                .toString() +
                                            " " +
                                            controller.bulan[DateTime.parse(
                                                        controller
                                                            .featuredPost
                                                            .value
                                                            .feed
                                                            .entry[i]
                                                            .published
                                                            .t)
                                                    .month -
                                                1] +
                                            " " +
                                            DateTime.parse(controller.featuredPost.value.feed.entry[i].published.t)
                                                .year
                                                .toString();
                                        bool featuredlebih3hari;
                                        if (DateTime.parse(controller
                                                    .featuredPost
                                                    .value
                                                    .feed
                                                    .entry[i]
                                                    .published
                                                    .t)
                                                .millisecondsSinceEpoch >=
                                            DateTime.now()
                                                .subtract(Duration(days: 3))
                                                .millisecondsSinceEpoch) {
                                          featuredlebih3hari = false;
                                        } else {
                                          featuredlebih3hari = true;
                                        }
                                        return InkWell(
                                          onTap: () async {
                                            String start = "post-";
                                            int startIndex = controller
                                                .featuredPost
                                                .value
                                                .feed
                                                .entry[i]
                                                .id
                                                .t
                                                .indexOf(start);
                                            String url = controller.baseUrl +
                                                "posts/" +
                                                controller.featuredPost.value
                                                    .feed.entry[i].id.t
                                                    .substring(startIndex +
                                                        start.length) +
                                                controller.apiKey;
                                            controller.fetchSinglePost(url);
                                          },
                                          child: Container(
                                            width: 130,
                                            height: 180,
                                            margin: EdgeInsets.only(
                                                right: i + 1 ==
                                                        controller
                                                            .featuredPost
                                                            .value
                                                            .feed
                                                            .entry
                                                            .length
                                                    ? 15
                                                    : 10),
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(controller
                                                      .featuredPost
                                                      .value
                                                      .feed
                                                      .entry[i]
                                                      .mediaThumbnail
                                                      .url
                                                      .replaceFirst(
                                                          "s72-c", "w1200")),
                                                  fit: BoxFit.cover),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Colors.amber,
                                            ),
                                            child: Stack(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color: Colors.amber,
                                                    gradient: LinearGradient(
                                                        begin: FractionalOffset
                                                            .topCenter,
                                                        end: FractionalOffset
                                                            .bottomCenter,
                                                        colors: [
                                                          Colors.transparent,
                                                          Color(0xCC000000),
                                                        ],
                                                        stops: [
                                                          0.0,
                                                          1.0
                                                        ]),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        controller
                                                            .featuredPost
                                                            .value
                                                            .feed
                                                            .entry[i]
                                                            .title
                                                            .t,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 14,
                                                          color: Colors.white,
                                                          height: 1.5,
                                                        ),
                                                        maxLines: 3,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        featuredlebih3hari
                                                            ? featuredTanggal
                                                            : timeAgo.format(
                                                                DateTime.parse(
                                                                    controller
                                                                        .featuredPost
                                                                        .value
                                                                        .feed
                                                                        .entry[
                                                                            i]
                                                                        .published
                                                                        .t),
                                                                allowFromNow:
                                                                    true,
                                                              ),
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    .5)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                    }),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Obx(
                              () => ListView.builder(
                                addRepaintBoundaries: true,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: controller.posts.value.items == null
                                    ? 1
                                    : controller.posts.value.items.length,
                                itemBuilder: (context, index) {
                                  if (controller.posts.value.items == null) {
                                    return ListTile(
                                      title: LinearProgressIndicator(),
                                    );
                                  }
                                  String tanggal = controller.posts.value
                                          .items[index].published.day
                                          .toString() +
                                      " " +
                                      controller.bulan[controller.posts.value
                                              .items[index].published.month -
                                          1] +
                                      " " +
                                      controller.posts.value.items[index]
                                          .published.year
                                          .toString();
                                  bool lebih3hari;
                                  if (controller.posts.value.items[index]
                                          .published.millisecondsSinceEpoch >=
                                      DateTime.now()
                                          .subtract(Duration(days: 3))
                                          .millisecondsSinceEpoch) {
                                    lebih3hari = false;
                                  } else {
                                    lebih3hari = true;
                                  }

                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      // color: Colors.white,
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width - 40,
                                    height: (MediaQuery.of(context).size.width -
                                            40) /
                                        2.5,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white,
                                      child: Stack(
                                        children: [
                                          InkWell(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            splashColor: Colors.amber,
                                            highlightColor:
                                                Colors.amber.withOpacity(.3),
                                            onTap: () async {
                                              String url = controller.baseUrl +
                                                  "posts/" +
                                                  controller.posts.value
                                                      .items[index].id +
                                                  controller.apiKey;
                                              controller.fetchSinglePost(url);
                                              // Get.to(ViewPostScreen());
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    height:
                                                        (MediaQuery.of(context)
                                                                    .size
                                                                    .width -
                                                                40) /
                                                            2.5,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      child: Image.network(
                                                        controller
                                                            .posts
                                                            .value
                                                            .items[index]
                                                            .images[0]
                                                            .url,
                                                        width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                2 -
                                                            40,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5),
                                                      margin: EdgeInsets.only(
                                                          right: 10),
                                                      child: Column(
                                                        children: [
                                                          Expanded(
                                                            child: Column(
                                                              children: [
                                                                Text(
                                                                  controller
                                                                      .posts
                                                                      .value
                                                                      .items[
                                                                          index]
                                                                      .title,
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        14,
                                                                  ),
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                  parse(controller
                                                                          .posts
                                                                          .value
                                                                          .items[
                                                                              index]
                                                                          .content)
                                                                      .nodes[0]
                                                                      .text
                                                                      .substring(
                                                                          0,
                                                                          100),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        11,
                                                                    letterSpacing:
                                                                        .2,
                                                                    wordSpacing:
                                                                        2,
                                                                  ),
                                                                  maxLines: 3,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              CircleAvatar(
                                                                maxRadius: 9,
                                                                backgroundImage: NetworkImage("https:" +
                                                                    controller
                                                                        .posts
                                                                        .value
                                                                        .items[
                                                                            index]
                                                                        .author
                                                                        .image
                                                                        .url),
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    controller
                                                                        .posts
                                                                        .value
                                                                        .items[
                                                                            index]
                                                                        .author
                                                                        .displayName,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            10),
                                                                  ),
                                                                  Text(
                                                                      lebih3hari
                                                                          ? tanggal
                                                                          : timeAgo.format(controller
                                                                              .posts
                                                                              .value
                                                                              .items[
                                                                                  index]
                                                                              .published),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              7)),
                                                                ],
                                                              ),
                                                              Expanded(
                                                                  child:
                                                                      Container()),
                                                              Transform(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                transform: Matrix4
                                                                    .rotationY(
                                                                        pi),
                                                                child: Icon(
                                                                  Icons.reply,
                                                                  size: 12,
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: InkWell(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(50),
                                                  bottomRight:
                                                      Radius.circular(8)),
                                              onTap: () {
                                                print("jancjok");
                                              },
                                              splashColor: Colors.amber,
                                              child: Container(
                                                width: 50,
                                                height: 50,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            GetBuilder<Controller>(
                              builder: (controller) {
                                if (controller.habis)
                                  return ListTile(
                                      title: Center(
                                          child: Text(
                                    "Anda telah mencapai awal dari perjalanan kami...",
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(.3)),
                                    textAlign: TextAlign.center,
                                  )));
                                else
                                  return ListTile(
                                      title: Center(
                                          child: CircularProgressIndicator()));
                              },
                            )
                          ],
                        ),
                      ),
                    )
                  ,
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                title: Text(
                  "News",
                  style: TextStyle(color: Colors.black),
                ),
                actions: [
                  IconButton(
                      icon: Icon(Icons.search_rounded),
                      tooltip: "Cari sesuatu disini",
                      onPressed: () => Get.to(SearchScreen(),
                          transition: Transition.downToUp,
                          curve: Curves.fastLinearToSlowEaseIn))
                ],
                leading: IconButton(
                    icon: Icon(Icons.short_text_rounded),
                    onPressed: () => controller.toggleDrawer()),
              ),
            ),
            Obx(
              () => Positioned(
                  top: MediaQuery.of(context).padding.top,
                  left: 0,
                  child: Transform.translate(
                    offset: Offset(-(MediaQuery.of(context).size.width),
                        -(MediaQuery.of(context).size.width)),
                    child: InkWell(
                      onTap: () => controller.toggleDrawer(),
                      child: AnimatedContainer(
                        curve: Curves.easeInOutCubic,
                        duration: Duration(milliseconds: 800),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.7),
                          shape: BoxShape.circle,
                          // borderRadius: BorderRadius.circular(1000)
                        ),
                        width: controller.isDrawerOpen.value
                            ? MediaQuery.of(context).size.height * 2 + 100
                            : 10,
                        height: controller.isDrawerOpen.value
                            ? MediaQuery.of(context).size.height * 2 + 100
                            : 10,
                      ),
                    ),
                  )),
            ),
            Obx(
              () => Positioned(
                  top: MediaQuery.of(context).padding.top,
                  left: 0,
                  child: Transform.translate(
                    offset: Offset(-(MediaQuery.of(context).size.width),
                        -(MediaQuery.of(context).size.width)),
                    child: InkWell(
                      onTap: () => controller.toggleDrawer(),
                      child: AnimatedContainer(
                        curve: Curves.easeInOutCubic,
                        duration: Duration(milliseconds: 800),
                        decoration: BoxDecoration(
                          color: Color(0xff1973d1),
                          shape: BoxShape.circle,
                          // borderRadius: BorderRadius.circular(1000)
                        ),
                        width: controller.isDrawerOpen.value
                            ? MediaQuery.of(context).size.width * 2 + 200
                            : 10,
                        height: controller.isDrawerOpen.value
                            ? MediaQuery.of(context).size.width * 2 + 110
                            : 10,
                      ),
                    ),
                  )),
            ),
            Obx(
              () => Positioned(
                top: MediaQuery.of(context).padding.top,
                left: 0,
                child: Transform.translate(
                  offset: Offset(-(MediaQuery.of(context).size.width),
                      -(MediaQuery.of(context).size.width)),
                  child: AnimatedContainer(
                      curve: Curves.easeInOutCubic,
                      duration: Duration(milliseconds: 1000),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xff03c3baa),
                              Color(0xff135cc5),
                            ]),
                        shape: BoxShape.circle,
                        // borderRadius: BorderRadius.circular(1000)
                      ),
                      width: controller.isDrawerOpen.value
                          ? MediaQuery.of(context).size.width * 2 + 100
                          : 10,
                      height: controller.isDrawerOpen.value
                          ? MediaQuery.of(context).size.width * 2 + 100
                          : 10,
                      child: ClipRRect(
                        child: Stack(
                          children: [
                            Positioned(
                              top: MediaQuery.of(context).size.width,
                              left: MediaQuery.of(context).size.width,
                              child: Material(
                                color: Colors.transparent,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width +
                                              100,
                                          child: ListView(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              padding: EdgeInsets.zero,
                                              children: [
                                                DrawerMenu(
                                                  title: 'Categories',
                                                  to: LabelListScreen(),
                                                ),
                                                DrawerMenu(
                                                  title: 'Saved',
                                                  to: TestScreen(),
                                                ),
                                                DrawerMenu(
                                                  title: 'Settings',
                                                  to: TestScreen(),
                                                ),
                                              ]),
                                        ),
                                      ),
                                      IconButton(
                                          icon: Icon(
                                            Icons.close_rounded,
                                            color: Colors.white,
                                          ),
                                          onPressed: () =>
                                              controller.toggleDrawer())
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DrawerMenu extends StatelessWidget {
  final String title;
  final Widget to;
  final Controller controller = Get.find();

  DrawerMenu({Key key, @required this.title, @required this.to})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          controller.toggleDrawer();
          Get.to(to);
        },
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            child: Text(title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700))));
  }
}
