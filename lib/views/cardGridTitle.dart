import 'package:flutter/material.dart';
import 'package:takaconnect/modules/subCategories.dart';
import 'package:takaconnect/views/cardList.dart';

class CardTitleView extends StatelessWidget {
  const CardTitleView({
    Key? key,
    required this.teamMember,
  }) : super(key: key);

  final String teamMember;

  Team biz(dynamic user) {
    return Team(
        name: user['business_name'],
        org: "VVendie K.K.",
        // org: user['email'],
        imagePath: user['avatar']);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: teamMember == 'Plastic'
          ? () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (contex) =>
                          SubCategoryPage('Plastic', 'plastic')));
            }
          : null,
      child: Container(
          child: Card(
        elevation: 10,
        child: Center(
          child: Container(
            padding: EdgeInsets.only(top: 8, bottom: 8),
            child: Center(
              child: Text(
                teamMember,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                  fontSize: 24.0,
                ),
              ),
            ),
          ),
        ),
      )),
    );
  }
}
