import 'package:flutter/material.dart';
import 'package:takaconnect/views/cardList.dart';

class HomeCategories extends StatefulWidget {
  const HomeCategories({
    Key? key,
  }) : super(key: key);

  @override
  _HomeCategoriesState createState() => _HomeCategoriesState();
}

class _HomeCategoriesState extends State<HomeCategories>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late TextEditingController searchController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    return true;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text('Taka Connect'),
        actions: [
          IconButton(
              icon: Icon(Icons.more_vert),
              color: Colors.white,
              onPressed: () {}),
        ],
        actionsIconTheme: IconThemeData(color: Colors.white),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: !false,
        // backgroundColor: Color(0xFF000050),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  child: Container(
                    padding: EdgeInsets.only(top: 4, bottom: 4),
                    width: MediaQuery.of(context).size.width * 0.95,
                    color: Colors.green.shade300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
                        Text('Choose Category'),
                        IconButton(
                            onPressed: () {}, icon: Icon(Icons.more_vert))
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: double.infinity,
                    child: FutureBuilder<bool>(
                      future: getData(),
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        if (!snapshot.hasData) {
                          return Align(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator());
                        } else {
                          return ListView.builder(
                            padding: const EdgeInsets.only(
                                top: 0, bottom: 0, right: 16, left: 16),
                            itemCount: Team.teamList.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              final int count = Team.teamList.length > 10
                                  ? 10
                                  : Team.teamList.length;
                              final Animation<double> animation =
                                  Tween<double>(begin: 0.0, end: 1.0).animate(
                                      CurvedAnimation(
                                          parent: animationController,
                                          curve: Interval(
                                              (1 / count) * index, 1.0,
                                              curve: Curves.fastOutSlowIn)));
                              animationController.forward();

                              return CardListView(
                                teamMember: Team.teamList[index],
                                animation: animation,
                                animationController: animationController,
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
