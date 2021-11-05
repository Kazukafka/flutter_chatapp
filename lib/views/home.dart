import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messenger_clone/services/auth.dart';
import 'package:messenger_clone/services/database.dart';
import 'package:messenger_clone/views/signin.dart';
import 'package:flutter/src/material/icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final databaseReference = FirebaseFirestore.instance;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isSearching = false;
  late Stream usersStream;

  TextEditingController searchUserNameEdittingController =
      TextEditingController();

  onSearchBtnClick() async {
    isSearching = true;
    setState(() {});
    usersStream = await DatabaseMethods()
        .getUserByUserName(searchUserNameEdittingController.text);
  }

  Widget searchUsersList() {
    return StreamBuilder<QuerySnapshot>(
      stream: usersStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data!.docs[index];
                  return Image.network(ds["imgUrl"]);
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("messenger clone"),
        actions: [
          InkWell(
            onTap: () {
              AuthMethods().signOut().then((s) {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => SignIn()));
              });
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.exit_to_app)),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                isSearching
                    ? GestureDetector(
                        onTap: () {
                          isSearching = false;
                          searchUserNameEdittingController.text = "";
                          setState(() {});
                        },
                        child: Padding(
                            padding: EdgeInsets.only(right: 12),
                            child: Icon(Icons.arrow_back)),
                      )
                    : Container(),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.grey,
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(24)),
                    child: Column(children: [
                      Row(
                        children: [
                          Expanded(
                              child: TextField(
                            controller: searchUserNameEdittingController,
                            decoration: InputDecoration(
                                border: InputBorder.none, hintText: "username"),
                          )),
                          GestureDetector(
                              onTap: () {
                                if (searchUserNameEdittingController.text !=
                                    "") {
                                  onSearchBtnClick();
                                }
                              },
                              child: Icon(Icons.search))
                        ],
                      ),
                    ]),
                  ),
                )
              ],
            ),
            searchUsersList()
          ],
        ),
      ),
    );
  }
}
