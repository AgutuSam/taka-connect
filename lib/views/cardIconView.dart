import 'package:flutter/material.dart';
import 'package:takaconnect/auxiliary/upload.dart';
import 'package:takaconnect/modules/categoryForm.dart';
import 'package:takaconnect/modules/subCategories.dart';
import 'package:takaconnect/views/cardList.dart';

class CardIconView extends StatelessWidget {
  const CardIconView({
    Key? key,
    this.teamMember,
    this.title,
  }) : super(key: key);

  final teamMember;
  final title;

  Team biz(dynamic user) {
    return Team(
        name: user['business_name'],
        org: "VVendie K.K.",
        // org: user['email'],
        imagePath: user['avatar']);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 4, bottom: 8),
      child: InkWell(
        splashColor: Colors.lightBlue,
        onTap: teamMember.name == 'Choose Waste Category'
            ? () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CategoryForm(category: title)));
              }
            : teamMember.name == 'Upload'
                ? () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UploadPage(teamMember.name)));
                  }
                : null,
        child: Card(
          elevation: 12.0,
          // margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
          child: Column(
            children: [
              Center(
                child: Image(
                  image: AssetImage(teamMember.imagePath),
                  height: 100,
                  width: 100,
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      onTap: teamMember.name == 'Choose Waste Category'
                          ? () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CategoryForm(category: title)));
                            }
                          : teamMember.name == 'Upload'
                              ? () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UploadPage(teamMember.name)));
                                }
                              : null,
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 4),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Center(
                                  child: Text(
                                    teamMember.name,
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 24.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
