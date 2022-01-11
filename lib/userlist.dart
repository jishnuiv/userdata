import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:userdata/userlist.model.dart';
import 'home.dart';




class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

Future<List<udata>?> UserData() async {
 // var params={"id":"61dbf9b1d7efe0f95bc1e1a6"};

  final result = await http.get(
      Uri.parse("https://dummyapi.io/data/v1/user?limit=10"),
      headers:{"app-id": "61dbf9b1d7efe0f95bc1e1a6"} );
  final jsonData = jsonDecode(result.body);
  print(result.body);

  List<udata>? data = UData.fromJson(jsonData).data;
  return data;
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Users List")),),
      body: FutureBuilder(future: UserData(),
        builder: (context, AsyncSnapshot<List<udata>?> snapshot) {
          if (snapshot.hasData) {
            return  ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                udata user = snapshot.data!.elementAt(index);

                return InkWell(
                  child: Card(
                    child:Column(children: [
                    ListTile(leading: CircleAvatar(
                      radius: 30.0,
                      backgroundImage:
                      NetworkImage(user.picture!,),
                      backgroundColor: Colors.transparent,
                    ),trailing: Text("${user.title!}  ${user.firstName!}${user.lastName!}"),)],)



                  ),
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserDatas(userId: user.id!,)));
                  },  );
              },
            );

          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}




