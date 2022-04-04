import 'dart:convert';
import 'package:apiintegration/Models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<UserModel> userList = [];
  Future<List<UserModel>> getUserApi() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Api Course"),
      ),
      body: Column(
        children: [
      Expanded(
          child: FutureBuilder(
        future: getUserApi(),
        builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
          if (!snapshot.hasData) {
            return const Text("Loading");
          } else {
            return ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          CustomRow(
                              tile: "Name",
                              value: snapshot.data![index].name.toString()),
                          CustomRow(
                              tile: "username",
                              value: snapshot.data![index].username
                                  .toString()),
                          CustomRow(
                              tile: "email",
                              value:
                                  snapshot.data![index].email.toString()),
                          CustomRow(
                              tile: "email",
                              value: snapshot.data![index].address!.city
                                      .toString() +
                                  snapshot.data![index].address!.geo!.lat
                                      .toString() +
                                  snapshot.data![index].address!.geo!.lng
                                      .toString()),
                        ],
                      ),
                    ),
                  );
                });
          }
        },
      ))
        ],
      ),
    );
  }
}

class CustomRow extends StatelessWidget {
  String tile, value;
  CustomRow({Key? key, required this.tile, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(tile), Text(value)],
      ),
    );
  }
}
