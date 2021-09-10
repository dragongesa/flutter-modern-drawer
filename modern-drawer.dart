// //this is for controller.dart

// final isDrawerOpen = false.obs;
// toggleDrawer(){
//   isDrawerOpen.value = !isDrawerOpen.value;
// }



// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:newsblogger/controller.dart';
// class ModernDrawer extends StatelessWidget {
//   final Controller controller = Get.find();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(children: [
//         Positioned(
//               top: 0,
//               left: 0,
//               right: 0,
//               child: AppBar(
//                 title: Text(
//                   "News",
//                   style: TextStyle(color: Colors.black),
//                 ),
//                 actions: [
//                   IconButton(
//                       icon: Icon(Icons.search_rounded),
//                       tooltip: "Cari sesuatu disini",
//                       onPressed: () => Get.to(SearchScreen(),
//                           transition: Transition.downToUp,
//                           curve: Curves.fastLinearToSlowEaseIn))
//                 ],
//                 leading: IconButton(
//                     icon: Icon(Icons.short_text_rounded),
//                     onPressed: () => controller.toggleDrawer()),
//               ),
//             ),
//             Obx(
//               () => Positioned(
//                   top: MediaQuery.of(context).padding.top,
//                   left: 0,
//                   child: Transform.translate(
//                     offset: Offset(-(MediaQuery.of(context).size.width),
//                         -(MediaQuery.of(context).size.width)),
//                     child: InkWell(
//                       onTap: () => controller.toggleDrawer(),
//                       child: AnimatedContainer(
//                         curve: Curves.easeInOutCubic,
//                         duration: Duration(milliseconds: 800),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(.7),
//                           shape: BoxShape.circle,
//                           // borderRadius: BorderRadius.circular(1000)
//                         ),
//                         width: controller.isDrawerOpen.value
//                             ? MediaQuery.of(context).size.height * 2 + 100
//                             : 10,
//                         height: controller.isDrawerOpen.value
//                             ? MediaQuery.of(context).size.height * 2 + 100
//                             : 10,
//                       ),
//                     ),
//                   )),
//             ),
//             Obx(
//               () => Positioned(
//                   top: MediaQuery.of(context).padding.top,
//                   left: 0,
//                   child: Transform.translate(
//                     offset: Offset(-(MediaQuery.of(context).size.width),
//                         -(MediaQuery.of(context).size.width)),
//                     child: InkWell(
//                       onTap: () => controller.toggleDrawer(),
//                       child: AnimatedContainer(
//                         curve: Curves.easeInOutCubic,
//                         duration: Duration(milliseconds: 800),
//                         decoration: BoxDecoration(
//                           color: Color(0xff1973d1),
//                           shape: BoxShape.circle,
//                           // borderRadius: BorderRadius.circular(1000)
//                         ),
//                         width: controller.isDrawerOpen.value
//                             ? MediaQuery.of(context).size.width * 2 + 200
//                             : 10,
//                         height: controller.isDrawerOpen.value
//                             ? MediaQuery.of(context).size.width * 2 + 110
//                             : 10,
//                       ),
//                     ),
//                   )),
//             ),
//             Obx(
//               () => Positioned(
//                 top: MediaQuery.of(context).padding.top,
//                 left: 0,
//                 child: Transform.translate(
//                   offset: Offset(-(MediaQuery.of(context).size.width),
//                       -(MediaQuery.of(context).size.width)),
//                   child: AnimatedContainer(
//                       curve: Curves.easeInOutCubic,
//                       duration: Duration(milliseconds: 1000),
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                             colors: [
//                               Color(0xff03c3baa),
//                               Color(0xff135cc5),
//                             ]),
//                         shape: BoxShape.circle,
//                         // borderRadius: BorderRadius.circular(1000)
//                       ),
//                       width: controller.isDrawerOpen.value
//                           ? MediaQuery.of(context).size.width * 2 + 100
//                           : 10,
//                       height: controller.isDrawerOpen.value
//                           ? MediaQuery.of(context).size.width * 2 + 100
//                           : 10,
//                       child: ClipRRect(
//                         child: Stack(
//                           children: [
//                             Positioned(
//                               top: MediaQuery.of(context).size.width,
//                               left: MediaQuery.of(context).size.width,
//                               child: Material(
//                                 color: Colors.transparent,
//                                 child: Container(
//                                   width: MediaQuery.of(context).size.width,
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Expanded(
//                                         child: Container(
//                                           height: MediaQuery.of(context)
//                                                   .size
//                                                   .width +
//                                               100,
//                                           child: ListView(
//                                               shrinkWrap: true,
//                                               physics:
//                                                   NeverScrollableScrollPhysics(),
//                                               padding: EdgeInsets.zero,
//                                               children: [
//                                                 DrawerMenu(
//                                                   title: 'Categories',
//                                                   to: LabelListScreen(),
//                                                 ),
//                                                 DrawerMenu(
//                                                   title: 'Saved',
//                                                   to: TestScreen(),
//                                                 ),
//                                                 DrawerMenu(
//                                                   title: 'Settings',
//                                                   to: TestScreen(),
//                                                 ),
//                                               ]),
//                                         ),
//                                       ),
//                                       IconButton(
//                                           icon: Icon(
//                                             Icons.close_rounded,
//                                             color: Colors.white,
//                                           ),
//                                           onPressed: () =>
//                                               controller.toggleDrawer())
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       )),
//                 ),
//               ),
//             )
//       ],),
//     );
//   }
// }