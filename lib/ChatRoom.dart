import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musan_client/src/provider/dashboard_provider.dart';
import 'package:musan_client/src/ui/auth/SignUp.dart';

import 'api_services/ApiServices.dart';

class ChatRoom extends StatefulWidget {
  final String chatRoomId;
  String messageSendBy;
  ChatRoom({this.chatRoomId:"ClientID_WorkshopID_OrderNumber", this.messageSendBy});

  @override
  _ChatRoomState createState() =>
      _ChatRoomState(chatRoomId: this.chatRoomId,messageSendBy:this.messageSendBy);
}

class _ChatRoomState extends State<ChatRoom> {
  // final Map<String, dynamic> userMap;
  final String chatRoomId;


  String messageSendBy;
  _ChatRoomState( {this.chatRoomId,this.messageSendBy});

  final TextEditingController _message = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void onSendMessage() async {
    _scrolList();
    if (_message.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "sendby": "$messageSendBy",
        "message": _message.text,
        "time": FieldValue.serverTimestamp(),
      };

      _message.clear();
      await _firestore
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .add(messages)
          .then((value) {
        print("ValueIS: $value");
        _scrolList();
        var splitListIDs = chatRoomId.split("_");
        var clientID = splitListIDs[0];
        var privderID = splitListIDs[1];
        var orderID = splitListIDs[2];
        // String body='{"topic": "$clientID","fcmToken": "string","title": "Message Received","body": "A new message received from workshop",'
        //     '"route": "string","data": "{\"chatID\":"$chatRoomId",\"routeName\":\"ChatRoom\"}"}';

        String body='{\"topic\":\"$privderID\",\"fcmToken\":\"string\",\"title\":\"Message Received\",\"body\":\"A new message received from workshop\",\"route\":\"string\",\"data\":\"{\\\"chatID\\\":\\\"$chatRoomId\\\",\\\"routeName\\\":\\\"ChatRoom\\\"}\"}';

        ApiServices.hitNotificationForChat(body);

      });
    } else {
      print("Enter Some Text");
    }
  }

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    analytics.logScreenView(screenName: "ChatRoom",screenClass:"ChatRoom");

    Future.delayed(Duration(seconds: 1), () {
      try{
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
        );}
      catch(e){

      }
    });
    super.initState();
  }

  Widget _scrolList() {
    try{
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      );

    }
    catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,),onPressed: (){
            Get.back();
          },),
          title: Text("Chat".tr),
          // title: StreamBuilder<DocumentSnapshot>(
          //   stream: _firestore.collection("users").doc(userMap['uid']).snapshots(),
          //   builder: (context, snapshot) {
          //     if (snapshot.data != null) {
          //       return Container(
          //         child: Column(
          //           children: [
          //             Text(userMap['name']),
          //             Text(
          //               snapshot.data['status'],
          //               style: TextStyle(fontSize: 14),
          //             ),
          //           ],
          //         ),
          //       );
          //     } else {
          //       return Container();
          //     }
          //   },
          // ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                height: size.height / 1.25,
                width: size.width,
                child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection('chatroom')
                      .doc(chatRoomId)
                      .collection('chats')
                      .orderBy("time", descending: false)
                      .snapshots(),
                  builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.data != null) {
                      print("snapshot.data");
                      _scrolList();

                      return ListView.builder(
                        // reverse: true,
                        shrinkWrap: true,
                        controller: _scrollController,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          // print("HEllo");
                          Map<String, dynamic> map =
                          snapshot.data.docs[index].data();
                          return messages(size, map);
                        },
                      );
                    }
                    else {
                      // TOASTS(snapshot.error.toString());
                      print(snapshot.error.toString());
                      return Container();
                    }
                  },
                ),
              ),
            ),
            Container(
              height: size.height / 10,
              width: size.width,
              alignment: Alignment.center,
              child: Container(
                height: size.height / 12,
                width: size.width / 1.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: size.height / 17,
                        child: TextField(
                          controller: _message,
                          textDirection: Get.locale.toString().contains("ar") ? TextDirection.rtl: TextDirection.ltr,
                          decoration: InputDecoration(
                              hintText: "Send Message".tr,

                              hintTextDirection: Get.locale.toString().contains("ar") ? TextDirection.rtl: TextDirection.ltr,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              )),
                        ),
                      ),
                    ),
                    IconButton(icon: Icon(Icons.send), onPressed: onSendMessage),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget messages(Size size, Map<String, dynamic> map) {
    // Timestamp time = map['time'];
    // print(time.toDate());
    return Container(
      width: size.width,
      alignment: map['sendby'] == "$messageSendBy"
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: map['sendby'] != "$messageSendBy"? Radius.circular(10): Radius.circular(0),
              topLeft:map['sendby'] == "$messageSendBy"? Radius.circular(10): Radius.circular(0),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)
          ),
          color: map['sendby'] != "$messageSendBy"? Colors.redAccent: blue,
        ),
        child: Column(children: [
          Text(
            map['message'],
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text(
          //     time.toDate().toString(),
          //
          //     style: TextStyle(
          //
          //       fontSize: 16,
          //       fontWeight: FontWeight.w500,
          //       color: Colors.white,
          //     ),
          //   ),
          // )

        ],),
      ),
    );
  }
}
