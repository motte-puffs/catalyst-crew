import 'package:flutter/material.dart';
import 'package:my_portfolio/Util/colors.dart';
import 'package:my_portfolio/Widgets/drawer_mobile.dart';
import 'package:my_portfolio/Widgets/header_mobile.dart';
import 'package:my_portfolio/Widgets/headerdesktop.dart';
import 'package:my_portfolio/Widgets/projectcard_desktop.dart';
import 'package:my_portfolio/Widgets/projectcard_mobile.dart';
import 'package:my_portfolio/pages/connect_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final projects = [
    {
      "title": "ToDo-App",
      "description":
          "Simple and minimal To Do app to manage tasks Create a new task by clicking on the plus button Press hold to delete a task.",
      "tags": ["Flutter"],
      "url": 'https://github.com/motte-puffs/ToDo-app'
    },
    {
      "title": "catalystcrew",
      "description": "The landing site for catalystcrew",
      "tags": ["Flutter", "MySQL"],
      "url": 'https://github.com/motte-puffs/catalystcrew.in'
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Get the screen size using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;
    double textScaleFactor = screenWidth >= 600 ? 1.0 : 0.9;  // Adjust scaling for mobile
    
    return LayoutBuilder(
      builder: (context, Constraints) {
        return Scaffold(
          key: scaffoldKey, // use the global key here
          backgroundColor: CustomColor.scaffoldBg,
          endDrawer: const DrawerMobile(),
          body: ListView(
            children: [
              if (Constraints.maxWidth >= 600)
                HeaderDesktop()
              else
                HeaderMobile(
                  onMenuTap: () {
                    // Use the global key to open the end drawer
                    scaffoldKey.currentState?.openEndDrawer();
                  },
                ),
              // Main content
              Container(
                height: 500,
                color: CustomColor.scaffoldBg,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Full Stack Developer",
                      style: TextStyle(
                        fontSize: 55 * textScaleFactor, // Adjust size based on screen width
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 32),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "I'm ",
                        style: TextStyle(fontSize: 18 * textScaleFactor, color: Colors.white),
                        children: [
                          TextSpan(
                            text: "Naman P",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 22 * textScaleFactor,
                            ),
                          ),
                          TextSpan(text: ",\n"),
                          TextSpan(
                            text: "enthusiastic about Flutter and full-stack development",
                            style: TextStyle(fontSize: 18 * textScaleFactor),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LetsConnectPage(),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Let's connect",
                        style: TextStyle(color: Colors.white, fontSize: 28 * textScaleFactor),
                      ),
                    ),
                    SizedBox(height: 100),
                    Text(
                      "Project Highlights",
                      style: TextStyle(fontSize: 40 * textScaleFactor, color: Colors.white),
                    ),
                  ],
                ),
              ),
              if (Constraints.maxWidth >= 600)
                DesktopProjectSection(projects: projects)
              else
                MobileProjectSection(projects: projects),
            ],
          ),
        );
      },
    );
  }
}
