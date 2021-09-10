import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:newsblogger/models/categorymodel.dart';
import 'package:newsblogger/models/postbycategorymodel.dart';
import 'package:newsblogger/models/postmodel.dart';
import 'package:newsblogger/models/singlepostmodel.dart';
import 'package:newsblogger/screens/postbylabelscreen.dart';
import 'package:newsblogger/screens/viewpostscreen.dart';

class Controller extends GetxController {
  final isDrawerOpen=false.obs;
  String featuredPostLabel = "Adsense";
  String baseUrl =
      "https://www.googleapis.com/blogger/v3/blogs/5090721423576840680/";
  String apiKey =
      "?key=AIzaSyCULoy2LGUrsFVUtRVdn-id73GPfWkEK2I&fetchImages=true";
  String categoryUrl =
      "https://www.mastimon.com/feeds/posts/summary/-/LABEL?alt=json";
  String postByCategoryUrl = "https://www.mastimon.com/feeds/posts/summary/-/";
  final category = CategoryModel(feed: null).obs;
  final featuredPost= PostByCategoryModel(feed: null).obs;
  final posts = PostModel(items: null).obs;
  final nextPageToken = "".obs;
  List<String> bulan = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  @override
  void onInit() {
    openApp();
    super.onInit();
    
    // SystemChrome.setSystemUIOverlayStyle(
    //     SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.white));
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
  openApp(){
    try {
      fetchCategory();
    fetchFeaturedPost();
    fetchPost();
    } on SocketException catch(e){
      print("Gaada internet $e");
    }
  }
toggleDrawer(){
  isDrawerOpen.value = !isDrawerOpen.value;
}
  fetchPost() async {
    String url = baseUrl + "posts" + apiKey;
    final resp = await http.get(url);
    PostModel parsedResp = postModelFromJson(resp.body);
    posts.value = parsedResp;
    nextPageToken.value = parsedResp.nextPageToken;
    print(nextPageToken.value);
  }

  fetchNextPost() async {
    isLoading.value = true;
    String url = nextPageToken.value != ""
        ? baseUrl + "posts" + apiKey + "&pageToken=" + nextPageToken.value
        : baseUrl + "posts" + apiKey;
    final resp = await http.get(url);
    PostModel parsedResp = postModelFromJson(resp.body);
    posts.value.items.addAll(parsedResp.items);
    nextPageToken.value = parsedResp.nextPageToken;
    print(nextPageToken.value);
    isLoading.value = false;
    if (nextPageToken.value == null) {
      habis = true;
    }
  }

  fetchCategory() async {
    String url = categoryUrl;
    final resp = await http.get(url);
    final parsedResp = resp.body;
    category.value = categoryModelFromJson(parsedResp);
  }

  fetchFeaturedPost() async {
    String url = postByCategoryUrl;
    final resp =
        await http.get(url + featuredPostLabel + "?max-results=4&alt=json");
    final parsedResp = resp.body;
    featuredPost.value = postByCategoryModelFromJson(parsedResp);
    print(featuredPost);
  }

  bool habis = false;
  PostByCategoryModel postByCategories;
  fetchPostByLabel(String label) async {
    Get.dialog(AlertDialog());
    String url = postByCategoryUrl;
    final resp = await http.get(url + label + "?max-results=8&alt=json");
    final parsedResp = resp.body;
    postByCategories = postByCategoryModelFromJson(parsedResp);
    Get.back();
    Get.to(PostByLabelScreen(label));
  }

  fetchSinglePost(String url) async {
    Get.dialog(AlertDialog());
    print(url);
    await http.get(url).then((value) {
      final SinglePostModel resp = singlePostModelFromJson(value.body);
      Get.back();
      Get.to(ViewPostScreen(resp));
    });
  }

  List<String> imagesLink = [];
  // ignore: missing_return
  Future<List<String>> fetchLabelImages() async {
    List<String> images = [];
    for (var label in category.value.feed.category) {
      String url = postByCategoryUrl;
      final resp = await http.get(url + label.term + "?max-results=1&alt=json");
      final parsedResp = resp.body;
      final data = postByCategoryModelFromJson(parsedResp);
      final image = data.feed.entry[0].mediaThumbnail != null
          ? data.feed.entry[0].mediaThumbnail.url.replaceFirst("s72-c", "w400")
          : "https://picsum.photos/id/237/200/300";
      images.add(image);
      imagesLink = images;
      update(["labelImages"]);
    }
    // return images;
  }

  final isLoading = false.obs;
}
