import 'package:adottapets/modals/fetchdata.dart';
import 'package:adottapets/tilewidgets/userdatatile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDataList extends StatefulWidget {
  const UserDataList({Key key}) : super(key: key);

  @override
  _UserDataListState createState() => _UserDataListState();
}

class _UserDataListState extends State<UserDataList> {
  @override
  Widget build(BuildContext context) {
    final datalist = Provider.of<List<DispData>>(context) ?? [];


    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: datalist.length,
                itemBuilder: (context, index) {
                  return UserDataTile(dbData: datalist[index]);
                }
            ),
          ),
        ],
      ),
    );

  }
}
