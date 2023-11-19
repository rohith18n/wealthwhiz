import 'package:flutter/material.dart';
import 'package:wealthwhiz/Screens/profile/widgets/about.dart';
import 'package:wealthwhiz/Screens/profile/widgets/help.dart';
import 'package:wealthwhiz/Screens/profile/widgets/privacy.dart';
import 'package:wealthwhiz/Screens/profile/widgets/termsandconditions.dart';
import 'package:iconly/iconly.dart';

import '../../reset/reset.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        elevation: 0,
      ),
      backgroundColor: Colors.lightGreen,
      body: ListView(
        children: [
          Container(
            height: 150,
            decoration: const BoxDecoration(color: Colors.lightGreen),
            child: Center(
              child: Text(
                'WealthWhiz',
                style: TextStyle(
                    color: Colors.limeAccent[700],
                    fontSize: 30,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const TermsPage(),
                ),
              );
            },
            child: ListTile(
              title: const Text(
                "Terms and Conditions",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              textColor: Colors.white,
              leading: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    IconlyLight.paper_negative,
                    color: Colors.white,
                  )),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const PrivacyPage(),
                ),
              );
            },
            child: ListTile(
              title: const Text(
                "Privacy Policy",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              textColor: Colors.white,
              leading: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    IconlyLight.lock,
                    color: Colors.white,
                  )),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ResetPage(),
                ),
              );
            },
            child: ListTile(
              title: const Text(
                "Reset",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              textColor: Colors.white,
              leading: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.restore,
                    color: Colors.white,
                  )),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const HelpPage(),
                ),
              );
            },
            child: ListTile(
              title: const Text(
                "Help",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              textColor: Colors.white,
              leading: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    IconlyLight.call,
                    color: Colors.white,
                  )),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AboutPage(),
                ),
              );
            },
            child: ListTile(
              title: const Text(
                "About",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              textColor: Colors.white,
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(
                  IconlyLight.profile,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
