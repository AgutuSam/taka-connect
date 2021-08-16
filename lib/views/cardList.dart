import 'package:flutter/material.dart';
import 'package:takaconnect/modules/categoryHome.dart';

class CardListView extends StatelessWidget {
  const CardListView({
    Key? key,
    this.teamMember,
    required this.animationController,
    required this.animation,
  }) : super(key: key);

  final teamMember;
  final AnimationController animationController;
  final Animation<double> animation;

  Team biz(dynamic user) {
    return Team(
        name: user['business_name'],
        org: "VVendie K.K.",
        // org: user['email'],
        imagePath: user['avatar']);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 15),
      child: AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(
            opacity: animation,
            child: Transform(
              transform: Matrix4.translationValues(
                  0.0, 50 * (1.0 - animation.value), 0.0),
              child: InkWell(
                splashColor: Colors.lightBlue,
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (contezt) => CategoryHomePage())),
                child: Card(
                  elevation: 12.0,
                  // margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (contezt) => CategoryHomePage())),
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: height * 0.045),
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Center(
                                      child: Text(
                                        teamMember.name,
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 36.0,
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.0,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: teamMember.org,
                                            ),
                                          ],
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
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class Team {
  Team({
    this.name = '',
    this.imagePath = '',
    this.title = '',
    this.org = '',
  });

  String name;
  String title;
  String org;
  String imagePath;

  static List<Team> teamList = <Team>[
    Team(
      imagePath: 'assets/users/pexels-nappy-935969.jpg',
      name: 'Sorters/Pickers',
      title: 'sorters',
      org: '...',
    ),
    Team(
      imagePath: 'assets/users/pexels-wallace-chuck-2287252.jpg',
      name: 'Collectors',
      title: 'collectors',
      org: '...',
    ),
    Team(
      imagePath: 'assets/users/pexels-pixabay-157661.jpg',
      name: 'Buyers',
      title: 'buyers',
      org: '...',
    ),
    Team(
      imagePath: 'assets/users/pexels-bharat-kumar-2232981.jpg',
      name: 'Recyclers',
      title: 'recyclers',
      org: '...',
    ),
  ];

  static List<Team> category = <Team>[
    Team(
      imagePath: 'assets/trashTruck.png',
      name: 'Choose Waste Category',
      title: 'Microbiologist',
      org: '...',
    ),
    // Team(
    //   imagePath: 'assets/upload.png',
    //   name: 'Upload',
    //   title: 'Programmer',
    //   org: '...',
    // ),
  ];

  static List sorters = [
    'Plastic',
    'Metal',
    'E_waste',
    'Glass',
    'Rubber',
    'Paper',
    'Organic',
    'Foam',
  ];
  static List buyers = [
    'Plastic',
    'Metal',
    'E_waste',
    'Glass',
    'Rubber',
    'Paper',
    'Organic',
    'Foam',
  ];
  static List recyclers = [
    'Plastic',
    'Metal',
    'E_waste',
    'Glass',
    'Rubber',
    'Paper',
    'Organic',
    'Foam',
  ];
  static List collectors = [
    'Plastic',
    'Metal',
    'E_waste',
    'Glass',
    'Rubber',
    'Paper',
    'Organic',
    'Foam',
  ];
  static List analysis = [
    'All',
    'Plastic',
    'Metal',
    'E_waste',
    'Glass',
    'Rubber',
    'Paper',
    'Organic',
    'Foam',
  ];
  static List plastic = [
    'PET',
    'PP',
    'HDPE',
    'PVC',
  ];

  static List glass = ['Jars', 'Bottles', 'Glassware'];
  static List paper = ['Hard', 'Soft'];
  static List metal = [
    'Aluminium Cans',
    'Iron Sheets',
    'Steel',
    'Copper',
    'Bross',
    'Bronze',
    'Cobalt'
  ];
  static List rubber = ['Shoe/Flip Flops', 'Tyre'];
  static List foam = ['Matress', 'Styrofoam', 'Foam'];
  // ignore: non_constant_identifier_names
  static List e_waste = [
    'Cooling Equipment',
    'Telecommunication Equipment',
    'Consumer Electronic Devices'
  ];
  static List organic = ['Food Remnants'];
}

class Waste {
  Waste({
    this.name = '',
    required this.subs,
  });

  String name;
  List subs;
  static List wasteList = <Waste>[
    Waste(name: 'Plastic', subs: [
      'PET',
      'PP',
      'HDPE',
      'PVC',
    ]),
    Waste(name: 'Metal', subs: [
      'Aluminium Cans',
      'Iron Sheets',
      'Steel',
      'Copper',
      'Bross',
      'Bronze',
      'Cobalt'
    ]),
    Waste(name: 'E_waste', subs: [
      'Cooling Equipment',
      'Telecommunication Equipment',
      'Consumer Electronic Devices'
    ]),
    Waste(name: 'Glass', subs: ['Jars', 'Bottles', 'Glassware']),
    Waste(name: 'Rubber', subs: ['Shoe/Flip Flops', 'Tyre']),
    Waste(name: 'Paper', subs: ['Hard', 'Soft']),
    Waste(name: 'Organic', subs: ['Food Remnants']),
    Waste(name: 'Foam', subs: ['Matress', 'Styrofoam', 'Foam']),
  ];
}
