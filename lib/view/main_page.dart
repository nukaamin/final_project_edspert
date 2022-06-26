import 'package:flutter/material.dart';
import 'package:apps_education/constants/setting_Reusable.dart';
import 'package:apps_education/view/main/discussion/message_page.dart';
import 'package:apps_education/view/main/practice/home.dart';
import 'package:apps_education/view/main/profile/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  static String route = "main_page";

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _pc = PageController();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Image.asset(
          Setting_Reusable.asset.icDiscuss,
          width: 30,
        ),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ChatPage()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNavigation(),
      body: PageView(
        controller: _pc,
        physics: NeverScrollableScrollPhysics(),
        
        children: const [
          HomePage(), //index ke 0
          ChatPage(),
          ProfilePage(), //index ke 1
        ],
      ),
    );
  }

  Container _buildBottomNavigation() {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 20,
            color: Colors.black.withOpacity(0.06))
      ]),
      child: BottomAppBar(
          color: Colors.white,
          child: Container(
            height: 60,
            child: Row(children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Material(
                    child: InkWell(
                      onTap: () {
                        index = 0;
                        _pc.animateToPage(index,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.bounceInOut);

                        setState(() {});
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            Setting_Reusable.asset.icHome,
                            height: 20,
                            color: index == 0 ? null : Colors.grey,
                          ),
                          Text("Home"),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Material(
                    child: InkWell(
                      child: Column(
                        children: [
                          Opacity(
                            opacity: 0,
                            child: Image.asset(
                              Setting_Reusable.asset.icHome,
                              height: 20,
                            ),
                          ),
                          Text("Diskusi"),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Material(
                    child: InkWell(
                      onTap: () {
                        index = 1;
                        _pc.animateToPage(
                          index,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );

                        setState(() {});
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            Setting_Reusable.asset.icProfile,
                            height: 20,
                            color: index == 0 ? null : Colors.grey,
                          ),
                          Text("Profile"),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          )),
    );
  }
}