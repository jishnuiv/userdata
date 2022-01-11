import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:userdata/userdata.model.dart';

class UserDatas extends StatefulWidget {
  String userId;
  UserDatas({Key? key, required this.userId}) : super(key: key);

  @override
  _UserDatasState createState() => _UserDatasState();
}

class _UserDatasState extends State <UserDatas> {

  Future<SingleUser> getData() async {

    final result = await http.get(
        Uri.parse("https://dummyapi.io/data/v1/user/" + widget.userId),
        headers:{"app-id": "61dbf9b1d7efe0f95bc1e1a6"} );
    final jsonData = jsonDecode(result.body);
    print(result.body);
    final user = SingleUser.fromJson(jsonData);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("User Data"))),
      body: FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<SingleUser> snapshot) {
          if (snapshot.hasData) {
            SingleUser Details = snapshot.data!;
            return ListView(
              children: [SizedBox(height: 30  ),
                Row(mainAxisAlignment: MainAxisAlignment.center,children: [CircleAvatar(radius:40.0, backgroundImage:
              NetworkImage(Details.picture!,), backgroundColor: Colors.transparent,
              ),],),
                SizedBox(height: 30  ),
                Column(children: [
                  ListTile(leading: Text("Name"),trailing:Text("${Details.firstName!}${Details.lastName!}") ,),
                  ListTile(leading: Text("Gender"),trailing:Text("${Details.gender!}") ,),
                  ListTile(leading: Text("Date Of Birth"),trailing:Text("${Details.dateOfBirth!}") ,),
                  ListTile(leading: Text("Email"),trailing:Text("${Details.email!}") ,),
                  ListTile(leading: Text("Phone Number"),trailing:Text("${Details.phone!}") ,),
                  ListTile(leading: Text("Register Date"),trailing:Text("${Details.registerDate!}") ,),
                  ListTile(leading: Text("Updated Date"),trailing:Text("${Details.updatedDate!}") ,),
                  Row(children: [Padding(
                    padding: const EdgeInsets.all( 20),
                    child: Text("Location"),
                  ),Column(children: [
                    Text("Country:${Details.location!.country}"),
                    Text("State:${Details.location!.state}"),
                    Text("city:${Details.location!.city}"),
                    Text("Street:${Details.location!.street}")],),],mainAxisAlignment:MainAxisAlignment.spaceBetween,)






                  ],)

              ],
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
