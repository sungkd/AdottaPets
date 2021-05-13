import 'package:adottapets/constants/decorate.dart';
import 'package:adottapets/modals/fetchdata.dart';
import 'package:adottapets/tilewidgets/datatile.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';


class DataList extends StatefulWidget {
  @override
  _DataListState createState() => _DataListState();
}

class _DataListState extends State<DataList> {
  String key = '';
  @override
  Widget build(BuildContext context) {


    var datalist = Provider.of<List<DispData>>(context);

    // Filter the imbisses using the key.
    datalist = datalist.where((_search) {
      return _search.location.toLowerCase().contains(key) ||
          _search.pin.toString().toLowerCase().contains(key);
    }).toList();

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: datalist.length,
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return DataTile(dbData: datalist[index]);
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                autofocus: false,
                decoration: richTextDecoration.copyWith(
                  isDense: true,
                  filled: true,
                  fillColor: Colors.black54,
                  labelText: 'Enter city or pin code',
                  labelStyle: TextStyle(
                      color: Colors.white
                  ),
                  hintText: 'Mumbai or 400042',
                  hintStyle:  TextStyle(color: Colors.white),
                  prefixIcon: Icon(LineIcons.search,
                    color: Colors.white,),
                ),
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  // Update the key when the value changes.
                  setState(() => key = value.toLowerCase());
                },
              ),
            ),

          ],
        ),
      ),
    );

  }

}
