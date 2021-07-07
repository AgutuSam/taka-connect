import 'package:flutter/material.dart';
import 'package:takaconnect/utils/navbar1.dart';
import 'package:takaconnect/views/cardGridTitle.dart';
import 'package:takaconnect/views/cardList.dart';

class SubCategoryPage extends StatefulWidget {
  const SubCategoryPage(this.categoryTitle, this.categoryList);
  final String categoryTitle;
  final String categoryList;

  @override
  _SubCategoryPageState createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavBar1(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(child: Text(widget.categoryTitle)),
        iconTheme: IconThemeData(color: Colors.white),
        // automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 2.5,
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, top: 2.0, bottom: 2.0),
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  children: widget.categoryTitle == 'Plastic'
                      ? Team.plastic.asMap().entries.map((widget) {
                          return CardTitleView(teamMember: widget.value);
                        }).toList()
                      : Team.sorters.asMap().entries.map((widget) {
                          return CardTitleView(teamMember: widget.value);
                        }).toList()),
            ),
          ),
        ),
      ),
    );
  }
}
