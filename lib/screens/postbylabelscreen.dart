import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsblogger/controller.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:http/http.dart' as http;
import 'package:newsblogger/models/postbycategorymodel.dart';
import 'package:timeago/timeago.dart' as timeAgo;
class PostByLabelScreen extends StatelessWidget {
  final Controller controller = Get.find();
  final String label;
  PostByLabelScreen(this.label);
  @override
  Widget build(BuildContext context) {
    final post = controller.postByCategories;
    
    return Scaffold(
      backgroundColor: Color(0xffE4E6EB),
      appBar: AppBar(
        title: Text(
          label,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: GetBuilder<Controller>(builder: (controller) {
        return LazyLoadScrollView(
            onEndOfPage: () async {
              controller.habis =false;
              int start = controller.postByCategories.feed.entry.length + 1;
              controller.isLoading.value = true;
              controller.update();
              print("end");
              print(start);
              String url = controller.postByCategoryUrl;
              final resp = await http.get(url +
                  label +
                  "?max-results=8&alt=json&start-index=" +
                  start.toString());
              final parsedResp = resp.body;
              final njajal = jsonDecode(parsedResp);

              if(njajal["feed"]["entry"]!=null){
              final data = postByCategoryModelFromJson(parsedResp);
              controller.postByCategories.feed.entry.addAll(data.feed.entry);

              }else{
                controller.habis =true;
              }
print(controller.habis);
              print("loaded");
              controller.isLoading.value = false;
              controller.update();
            },
            isLoading: controller.isLoading.value,
            child:ListView(
              children: 
                [
                  GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                    padding: EdgeInsets.all(7.5),

                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: .74,
                        crossAxisCount: 2),
                    itemCount: controller.postByCategories.feed.entry.length,
                    itemBuilder: (c, i) {
                      if(i+1==int.parse(post.feed.openSearchTotalResults.t)){
                        controller.habis = true;
                      }
                      String tanggal = DateTime.parse(post.feed.entry[i].published.t)
                                            .day
                                            .toString() +
                                        " " +
                                        controller.bulan[
                                            DateTime.parse(post.feed.entry[i].published.t).month -
                                                1]+DateTime.parse(post.feed.entry[i].published.t).year
                                            .toString();
                                    bool lebih3hari;
                                    if (DateTime.parse(post.feed.entry[i].published.t)
                                            .millisecondsSinceEpoch >=
                                        DateTime.now()
                                            .subtract(Duration(days: 3))
                                            .millisecondsSinceEpoch) {
                                      lebih3hari = false;
                                    } else {
                                      lebih3hari = true;
                                    }
                      return InkWell(
                        onTap: (){
                          String start = "post-";
                                         int startIndex = post.feed.entry[i].id.t.indexOf(start);
                                          String url = controller.baseUrl +
                                              "posts/" +
                                              post.feed.entry[i].id.t.substring(startIndex+start.length)+
                                              controller.apiKey;
                                          controller.fetchSinglePost(url);
                        },
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              margin: EdgeInsets.all(7.5),
                              padding: EdgeInsets.all(7.5),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(post.feed.entry[i].mediaThumbnail!=null? post.feed.entry[i].mediaThumbnail.url.replaceFirst("s72-c", "w500"):"https://picsum.photos/id/237/200/300",width: double.infinity,
                                    fit: BoxFit.cover,
                                    
                                    height: 100,
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Expanded(
                                    child: Text(post.feed.entry[i].title.t,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      height: 1.4,
                                      letterSpacing: .1,
                                      
                                    ),maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        maxRadius: 12,
                                        backgroundImage: NetworkImage(post
                                                .feed.entry[i].author[0].gdImage.src
                                                .contains("https:")
                                            ? post.feed.entry[i].author[0].gdImage.src
                                            : "https:" +
                                                post.feed.entry[i].author[0].gdImage.src),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                        Text(post.feed.entry[i].author[0].name.t,
                                        
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,

                                        ),
                                        ),
                                        Text(lebih3hari?tanggal:timeAgo.format(DateTime.parse(post.feed.entry[i].published.t)),
                                        style: TextStyle(
                                          fontSize: 10,

                                        ),
                                        ),

                                      ],)
                                    ],
                                  )
                                ],
                              ),
                            ),
                        Container(
                          decoration: BoxDecoration(
                          color: Colors.amber,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                          child: Text((i+1).toString()+"/"+post.feed.openSearchTotalResults.t.toString(),style: TextStyle(fontSize: 10 , color: Colors.black ,fontWeight: FontWeight.w700),))
                          ],
                        
                        
                        ),
                      );
                    }),
               GetBuilder<Controller>(
builder: (controller) {
   if(controller.habis)
        return  ListTile(title: Center(child: Text("Anda telah mencapai awal dari perjalanan kami...",
        style: TextStyle(color: Colors.black.withOpacity(.3)),textAlign: TextAlign.center,
        )));
          else
         return ListTile(title: Center(child: CircularProgressIndicator()));
},

            )
              ],
            ));
      }),
    );
  }
}
