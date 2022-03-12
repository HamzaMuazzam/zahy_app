
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musan_client/slider/carousel_options.dart';
import 'package:musan_client/slider/carousel_slider.dart';

class HomeSlider extends StatefulWidget {
  const HomeSlider({Key key}) : super(key: key);

  @override
  _HomeSliderState createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            color: const Color(0xFFDBD8D8),
            height: Get.height,
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                CarouselSlider.builder(
                    itemCount: 15,
                    itemBuilder: (BuildContext context, int itemIndex,
                        int pageViewIndex) {
                      return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              image: const DecorationImage(
                                image: NetworkImage(
                                    'https://img.wallpapersafari.com/desktop/1680/1050/8/23/NKZOwi.jpg'),
                                fit: BoxFit.fill,
                              )),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, top: 10, bottom: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(20),
                                          color: Colors.grey,
                                          image: const DecorationImage(
                                              image: NetworkImage(
                                                  'https://ak.picdn.net/offset/photos/5d63fb17469b183482a1f2ce/medium/offset_847191.jpg'),
                                              fit: BoxFit.fill)),
                                    ),
                                  )),
                              Expanded(
                                  flex: 6,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8, bottom: 8, left: 8, top: 8),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "Special Offer",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue),
                                              ),
                                              Container(
                                                width: 80,
                                                height: 35,
                                                child: const Center(
                                                    child: Text("20% Off",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontSize: 15))),
                                                decoration: const BoxDecoration(
                                                    color: Colors.orange,
                                                    borderRadius:
                                                    BorderRadius.only(
                                                        topLeft: Radius
                                                            .circular(10),
                                                        bottomLeft:
                                                        Radius.circular(
                                                            10))),
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: const [
                                                    Text("You Can take up to",
                                                        style: TextStyle(
                                                            color:
                                                            Colors.blueGrey)),
                                                    Text("20%",
                                                        style: TextStyle(
                                                            color: Colors.blueGrey,
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontSize: 15)),
                                                    Text("off if you",
                                                        style: TextStyle(
                                                            color: Colors.blueGrey))
                                                  ],
                                                ),
                                                Container(
                                                  height: 10,
                                                ),
                                                const Text(
                                                  "Use our app to find your mechanic",
                                                  style: TextStyle(
                                                      color: Colors.blueGrey),
                                                )
                                              ],
                                            )),
                                        Expanded(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(
                                                          top: 5, bottom: 5),
                                                      child: Container(
                                                        child: const Center(
                                                            child: Text("More Details",
                                                                style: TextStyle(
                                                                    color:
                                                                    Colors.white))),
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.circular(15),
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                    )),
                                                Expanded(child: Container())
                                              ],
                                            )),
                                      ],
                                    ),
                                  )),
                            ],
                          ));
                    },
                    options: CarouselOptions(
                      height: Get.height / 5,
                      // aspectRatio: 16 / 9,
                      viewportFraction: 0.925,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 30),
                      autoPlayAnimationDuration: Duration(milliseconds: 30),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      onPageChanged: (indexNumber, reasonToScroll) {},
                      scrollDirection: Axis.horizontal,
                    )),



              ],
            )),
      ),
    );
  }
}
