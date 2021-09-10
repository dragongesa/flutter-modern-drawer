import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsblogger/controller.dart';
import 'package:newsblogger/models/categorymodel.dart';

class LabelListScreen extends StatelessWidget {
  final Controller controller = Get.find();
  @override
  Widget build(BuildContext context) {
    List<Category> labelList = controller.category.value.feed.category;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Categories",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () => Get.back(),
          tooltip: "Kembali ke beranda",
        ),
      ),
      body: ListView.builder(
        cacheExtent: 99999,
        itemCount: (labelList.length / 9).ceil(),
        itemBuilder: (c, i) {
          return LabelListPattern(i, labelList);
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class LabelListPattern extends StatelessWidget {
  final int rootIndex;
  final List<Category> labelList;
  final Controller controller = Get.find();

  LabelListPattern(this.rootIndex, this.labelList);

  @override
  Widget build(BuildContext context) {
    int patternBegin = rootIndex * 9;
    int secondSectionBegin = patternBegin + 1;
    int thirdSectionBegin = patternBegin + 4;
    int fourthSectionBegin = patternBegin + 5;
    // print("P Length  : ${rootIndex + 1} / ${(labelList.length / 9).ceil()}");
    // print("P  Begin  : $patternBegin");
    // print("S2 Begin  : $secondSectionBegin");
    // print("Sisa child: ${labelList.length - secondSectionBegin}");
    // print("---------------------");
    return FutureBuilder(
        future: controller.fetchLabelImages(),
        builder: (context, snapshot) {
          return GetBuilder<Controller>(
            id: "labelImages",
            builder: (controller) {
            
            return Container(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      controller.fetchPostByLabel(labelList[patternBegin].term);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: controller.imagesLink.length != 0 &&
                                    controller.imagesLink.length - 1 >=
                                        patternBegin
                                ? NetworkImage(
                                    controller.imagesLink[patternBegin])
                                : AssetImage(
                                    "assets/images/loading.gif",
                                  ),
                          ),
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(16)),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.amber,
                              gradient: LinearGradient(
                                  begin: FractionalOffset.topCenter,
                                  end: FractionalOffset.bottomCenter,
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
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  labelList[patternBegin].term,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (labelList.length - secondSectionBegin >= 1)
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                controller.fetchPostByLabel(
                                    labelList[secondSectionBegin].term);
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 200,
                                margin: EdgeInsets.only(
                                  right:
                                      (labelList.length - secondSectionBegin >=
                                              2)
                                          ? 10
                                          : 0,
                                ),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: controller.imagesLink.length !=
                                                  0 &&
                                              controller.imagesLink.length -
                                                      1 >=
                                                  secondSectionBegin
                                          ? NetworkImage(controller
                                              .imagesLink[secondSectionBegin])
                                          : AssetImage(
                                              "assets/images/loading.gif"),
                                    ),
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(16)),
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: Colors.amber,
                                        gradient: LinearGradient(
                                            begin: FractionalOffset.topCenter,
                                            end: FractionalOffset.bottomCenter,
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
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            labelList[secondSectionBegin].term,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          if (labelList.length - secondSectionBegin >= 2)
                            Expanded(
                              child: Container(
                                height: 200,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          controller.fetchPostByLabel(
                                              labelList[secondSectionBegin + 1]
                                                  .term);
                                        },
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          margin: EdgeInsets.all(0),
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: controller.imagesLink
                                                                .length !=
                                                            0 &&
                                                        controller.imagesLink
                                                                    .length -
                                                                1 >=
                                                            secondSectionBegin +
                                                                1
                                                    ? NetworkImage(
                                                        controller.imagesLink[
                                                            secondSectionBegin +
                                                                1],
                                                      )
                                                    : AssetImage(
                                                        "assets/images/loading.gif"),
                                              ),
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          child: Stack(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
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
                                                    const EdgeInsets.all(20.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      labelList[
                                                              secondSectionBegin +
                                                                  1]
                                                          .term,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 16,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (labelList.length - secondSectionBegin >=
                                        3)
                                      SizedBox(
                                        height: 10,
                                      ),
                                    if (labelList.length - secondSectionBegin >=
                                        3)
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            controller.fetchPostByLabel(
                                                labelList[
                                                        secondSectionBegin + 2]
                                                    .term);
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            margin: EdgeInsets.all(0),
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: controller.imagesLink
                                                                  .length !=
                                                              0 &&
                                                          controller.imagesLink
                                                                      .length -
                                                                  1 >=
                                                              secondSectionBegin +
                                                                  2
                                                      ? NetworkImage(
                                                          controller.imagesLink[
                                                              secondSectionBegin +
                                                                  2],
                                                        )
                                                      : AssetImage(
                                                          "assets/images/loading.gif"),
                                                ),
                                                color: Colors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(16)),
                                            child: Stack(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
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
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        labelList[
                                                                secondSectionBegin +
                                                                    2]
                                                            .term,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 16,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  if (labelList.length - thirdSectionBegin >= 1)
                    InkWell(
                      onTap: () {
                        controller.fetchPostByLabel(
                            labelList[thirdSectionBegin].term);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: controller.imagesLink.length != 0 &&
                                      controller.imagesLink.length - 1 >=
                                          thirdSectionBegin
                                  ? NetworkImage(
                                      controller.imagesLink[thirdSectionBegin])
                                  : AssetImage("assets/images/loading.gif"),
                            ),
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(16)),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.amber,
                                gradient: LinearGradient(
                                    begin: FractionalOffset.topCenter,
                                    end: FractionalOffset.bottomCenter,
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
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    labelList[thirdSectionBegin].term,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (labelList.length - fourthSectionBegin >= 1)
                    Container(
                      height: 180,
                      margin: EdgeInsets.fromLTRB(20, 10, 0, 10),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: (labelList.length - fourthSectionBegin >= 4)
                            ? 4
                            : (labelList.length - fourthSectionBegin),
                        itemBuilder: (c, i) {
                          return InkWell(
                            onTap: (){
                              controller.fetchPostByLabel(labelList[fourthSectionBegin + i].term);
                            },
                            child: Container(
                              width: 150,
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: controller.imagesLink.length != 0 &&
                                            controller.imagesLink.length - 1 >=
                                                fourthSectionBegin + i
                                        ? NetworkImage(controller
                                            .imagesLink[fourthSectionBegin + i])
                                        : AssetImage("assets/images/loading.gif"),
                                  ),
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(16)),
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.amber,
                                      gradient: LinearGradient(
                                          begin: FractionalOffset.topCenter,
                                          end: FractionalOffset.bottomCenter,
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
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          labelList[fourthSectionBegin + i].term,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                ],
              ),
            );
          });
        });
  }
}
