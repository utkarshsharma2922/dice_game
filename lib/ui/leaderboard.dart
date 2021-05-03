import 'package:dice_game/model/user.dart';
import 'package:dice_game/services/firebase_database_service.dart';
import 'package:dice_game/util/components.dart';
import 'package:dice_game/util/constants.dart';
import 'package:flutter/material.dart';
class LeaderBoard extends StatefulWidget {
  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {

  Future<Map<String,dynamic>>usersData;

  @override
  void initState() {
    usersData = FirebaseDBService.instance.fetchAllUsersSortedByMaxScore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
        ),
        title: Text("LeaderBoard",style: TextStyle(
            color: Colors.white
        ),),
      ),
      body: FutureBuilder(
        future: usersData,
        builder: (context,snapshot){
          if (snapshot.hasData){
            return getUsersList(data: snapshot.data);
          }else{
            return Center(child: CircularProgressIndicator());
          }
        },
      )
    );
  }

  Widget getUsersList({Map<String,dynamic>data}){
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ListView.separated(itemBuilder: (context,index){
        var key = data.keys.toList().elementAt(index);
        return getUserView(GameUser.fromJson(Map<String,dynamic>.from(data[key])));
      }, separatorBuilder: (context,index){
        return SizedBox(height: 8,);
      }, itemCount: data.keys.length),
    );
  }

  Widget getUserView(GameUser user){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: THEME_COLOR,
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 4,
            ),
            Components.getText(user.email, Colors.white, 16.0),
            SizedBox(
              height: 8.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 50.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Components.getText(
                          "${10 - user.triesLeft}/10", Colors.white, 22.0),
                      SizedBox(height: 5,),
                      Components.getText(
                        "Tries",
                        Colors.white,
                        12.0,
                      )
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Components.getText(
                        "${user.totalScore}", Colors.white, 22.0),
                    SizedBox(height: 5,),
                    Components.getText(
                      "Total Score",
                      Colors.white,
                      12.0,
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
