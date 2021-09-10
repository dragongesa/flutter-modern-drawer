import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:newsblogger/controller.dart';
import 'package:newsblogger/models/searchresultmodel.dart' as model;

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final Controller controller = Get.find();
  model.SearchResultModel searchResult;
  bool loading = false;
  int ok;
  String message = "Ketikkan pencarian diatas";
  String userInput;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xffe4e6eb),
        body: Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top: 100 + 60.0),
                  child: Column(
                    children: [
                      GetBuilder<Controller>(
                        id: "searchId",
                        assignId: false,
                        // ignore: missing_return
                        builder: (controller) {
                          if (loading == true) {
                            return ListTile(
                              title: Center(child: CircularProgressIndicator()),
                            );
                          }

                          if (loading == false) {
                            if (searchResult == null) {
                              return Center(
                                child: Text(message),
                              );
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox(),
                                    ),
                                    Text("Menampilkan " +
                                        searchResult.items.length.toString() +
                                        " hasil"),
                                    SizedBox(
                                      width: 20,
                                    )
                                  ],
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: searchResult == null
                                      ? 0
                                      : searchResult.items.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        print(searchResult.items[index].id);
                                        String url = controller.baseUrl +
                                            "posts/" +
                                            searchResult.items[index].id +
                                            controller.apiKey;
                                        controller.fetchSinglePost(url);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: ListTile(
                                            trailing: Material(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: InkWell(
                                                child: Icon(Icons
                                                    .bookmark_outline_rounded),
                                                onTap: () {},
                                              ),
                                            ),
                                            title: Text(searchResult
                                                .items[index].title),
                                            subtitle: Text(searchResult
                                                .items[index]
                                                .author
                                                .displayName),
                                            tileColor: Colors.white,
                                            dense: true,
                                            horizontalTitleGap: 20,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Color(0xffe4e6eb),
                        Color(0xffe4e6eb),
                        Color(0xffe4e6eb).withOpacity(0),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0, .7, 1])),
            ),
            SafeArea(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      onChanged: (value) {
                        userInput = value;
                        if (value == "") {
                          message = "Ketik pencarianmu diatas";
                          searchResult.items.clear();
                        } else {
                          searchResult = null;
                        }
                        controller.update(["searchId"]);
                      },
                      style: TextStyle(
                          fontSize: 18, decoration: TextDecoration.none),
                      cursorWidth: 1,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(8)),
                        fillColor: Colors.grey.withOpacity(.2),
                        filled: true,
                      ),
                    )),
                    Material(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xff5767a7),
                      child: InkWell(
                          onTap: () async {
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            String query = userInput;
                            String url = controller.baseUrl +
                                "posts/search" +
                                controller.apiKey +
                                "&q=title:$query";
                            // print(url);
                            loading = true;
                            searchResult == null
                                ? ok = 0
                                : searchResult.items.clear();
                            controller.update();
                            await http.get(url).then((value) {
                              loading = false;
                              // print(value.body);
                              if (jsonDecode(value.body)['items'] == null) {
                                // ignore: unnecessary_statements
                                message = "Pencarian tidak ada";
                              } else {
                                searchResult =
                                    model.searchResultModelFromJson(value.body);
                              }
                              controller.update(["searchId"]);
                            });
                          },
                          child: Container(
                              height: 100 - 40.0,
                              width: 100 - 40.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(Icons.search, color: Colors.white))),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                top: MediaQuery.of(context).padding.top,
                right: 0,
                child: Material(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(200),
                    bottomLeft: Radius.circular(200),
                  ),
                  child: IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.close_rounded),
                    onPressed: ()=>Get.back()
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
