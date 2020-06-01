import 'package:board_app/ui/custom_card.dart';
import 'package:board_app/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '';

class BoardApp extends StatefulWidget {
  @override
  _BoardAppState createState() => _BoardAppState();
}

class _BoardAppState extends State<BoardApp> {
  var firestoreDb = Firestore.instance.collection("board").snapshots();
  TextEditingController nameInputController;
  TextEditingController titleInputController;
  TextEditingController descriptionInputController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameInputController = new TextEditingController();
    titleInputController = new TextEditingController();
    descriptionInputController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SetTheme().bgMain,
      appBar: AppBar(
        backgroundColor: SetTheme().appBars,
        title: Text(
          "~ Board ~",
          style: TextStyle(
            fontFamily: "NewYork",
            color: SetTheme().TextOnAppBar,
            fontSize: 27.0,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialogue(context);
        },
        backgroundColor: SetTheme().buttons,
        child: Icon(
          Icons.add,
          color: SetTheme().buttonSymbol,
        ),
      ),
      body: StreamBuilder(
          stream: firestoreDb,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, int index) {
//                    return Text(
//                      snapshot.data.documents[index]['title'],
//                      style: TextStyle(
//                        fontSize: 19.0,
//                        fontFamily: "NewYork",
//                        color: SetTheme().TextOnbgMain,
//                      ),
//                    );
                    return CustomCard(snapshot: snapshot.data, index: index);
                  });
            }
          }),
    );
  }

  _showDialogue(BuildContext context) async {
    await showDialog(
        context: context,
        child: AlertDialog(
          //shape: ShapeBorder(),
          backgroundColor: SetTheme().bgDialogue,
          contentPadding: EdgeInsets.all(10.0),
          content: Column(
            children: <Widget>[
              Text(
                "please fill out the form",
                style: TextStyle(
                    fontFamily: "NewYork",
                    color: SetTheme().TextOnbgDialogue,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "please limit the description to at most 1000 characters",
                style: TextStyle(
                    fontFamily: "NewYork",
                    color: SetTheme().TextOnbgDialogueLight,
                    fontSize: 10.0),
              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: TextField(
                  autofocus: true,
                  autocorrect: true,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: SetTheme().bgSecondary),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: SetTheme().bgMain),
                    ),
                    labelText: "your name*",
                    labelStyle: TextStyle(
                        fontFamily: "NewYork",
                        color: SetTheme().TextOnbgDialogue),
                  ),
                  controller: nameInputController,
                  style: TextStyle(
                      color: SetTheme().bgMain, fontFamily: "NewYork"),
                ),
              ),
              Expanded(
                child: TextField(
                  autofocus: true,
                  autocorrect: true,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: SetTheme().bgSecondary),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: SetTheme().bgMain),
                    ),
                    labelText: "title*",
                    labelStyle: TextStyle(
                        fontFamily: "NewYork",
                        color: SetTheme().TextOnbgDialogue),
                  ),
                  controller: titleInputController,
                  style: TextStyle(
                      color: SetTheme().bgMain, fontFamily: "NewYork"),
                ),
              ),
              Expanded(
                child: TextField(
                  autofocus: true,
                  autocorrect: true,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: SetTheme().bgSecondary),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: SetTheme().bgMain),
                    ),
                    labelText: "description*",
                    labelStyle: TextStyle(
                        fontFamily: "NewYork",
                        color: SetTheme().TextOnbgDialogue),
                  ),
                  controller: descriptionInputController,
                  style: TextStyle(
                      color: SetTheme().bgMain, fontFamily: "NewYork"),
                ),
              ),
              Text(
                "fields marked with an asterisk (*) are mandatory",
                style: TextStyle(
                    fontFamily: "NewYork",
                    color: SetTheme().TextOnbgDialogueLight,
                    fontSize: 10.0),
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                if (titleInputController.text.isNotEmpty &&
                    nameInputController.text.isNotEmpty &&
                    descriptionInputController.text.isNotEmpty) {
                  Firestore.instance
                      .collection("board")
                      .add({
                        "name": nameInputController.text,
                        "title": titleInputController.text,
                        "description": descriptionInputController.text,
                        "timestamp": new DateTime.now(),
                      })
                      .then((response) => {
                            print(response.documentID),
                            Navigator.pop(context),
                            nameInputController.clear(),
                            titleInputController.clear(),
                            descriptionInputController.clear(),
                          })
                      .catchError((error) => print(error));
                } else {}
              },
              child: Text(
                "Save",
                style: TextStyle(
                    color: SetTheme().TextOnbgDialogue, fontFamily: "NewYork"),
              ),
            ),
            FlatButton(
              onPressed: () {
                nameInputController.clear();
                titleInputController.clear();
                descriptionInputController.clear();
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                    fontFamily: "NewYork", color: SetTheme().TextOnbgDialogue),
              ),
            ),
          ],
        ));
  }
}
