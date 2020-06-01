import 'package:board_app/util/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class CustomCard extends StatelessWidget {
  final QuerySnapshot snapshot;
  final int index;

  const CustomCard({Key key, this.snapshot, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Card(
            elevation: 7.0,
            color: SetTheme().bgSecondary,
            child: ListTile(
              onLongPress: () {
                _cardDialogueBox(context: context, index: index);
              },
              title: Text(
                (snapshot.documents[index].data['title']).toLowerCase(),
                style: TextStyle(
                    color: SetTheme().TextOnbgMain,
                    fontFamily: "NewYork",
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
//                (snapshot.documents[index].data['description']).toLowerCase(),
                ("${snapshot.documents[index].data['description']}".length <= 40
                    ? "${snapshot.documents[index].data['description']}"
                        .toLowerCase()
                    : ("${snapshot.documents[index].data['description']}"
                                .substring(0, 40) +
                            "...")
                        .toLowerCase()),
                style: TextStyle(
                    color: SetTheme().TextOnbgMainDark,
                    fontFamily: "NewYork",
                    fontSize: 12.0),
              ),
              leading: CircleAvatar(
                radius: 25.0,
                backgroundColor: SetTheme().bgDialogue,
                child: Text(
                  (snapshot.documents[index].data['title']).toUpperCase()[0],
                  style: TextStyle(
                      color: SetTheme().TextOnbgDialogue,
                      fontFamily: "NewYork",
                      fontSize: 14),
                ),
              ),
              trailing: Text(
                "...",
                style: TextStyle(
                    fontFamily: "NewYork",
                    fontWeight: FontWeight.bold,
                    color: SetTheme().bgSecondaryLight),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _cardDialogueBox({BuildContext context, int index}) {
    var timeToDate = new DateTime.fromMillisecondsSinceEpoch(
        snapshot.documents[index].data['timestamp'].seconds * 1000);
    var dateFormatted = new DateFormat("EE, MMMM d").format(timeToDate);
    showDialog(
      context: context,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: SetTheme().bgDialogue,
          ),
          width: MediaQuery.of(context).size.width * 0.75,
          height: MediaQuery.of(context).size.height * 0.75,
          //color: SetTheme().bgDialogue,
          child: Column(
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    (snapshot.documents[index].data['title']).toLowerCase(),
                    style: TextStyle(
                      color: SetTheme().TextOnbgDialogue,
                      fontFamily: "NewYork",
                      fontSize: 19.0,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                      dateFormatted,
                      style: TextStyle(
                        color: SetTheme().TextOnbgDialogueLight,
                        fontFamily: "NewYork",
                        fontSize: 10.0,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Text(
                  //textAlign: TextAlign.start,
                  snapshot.documents[index].data['description'],
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: SetTheme().TextOnbgDialogue,
                    fontFamily: "NewYork",
                    fontSize: 12.0,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                      "~ " +
                          "${snapshot.documents[index].data['name']}"
                              .toLowerCase(),
                      style: TextStyle(
                        color: SetTheme().bgMain,
                        fontFamily: "NewYork",
                        fontSize: 10.0,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      //alignment: Alignment.bottomCenter,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "back to home",
                        style: TextStyle(
                            fontFamily: "NewYork",
                            fontSize: 12.0,
                            color: SetTheme().bgMain),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
