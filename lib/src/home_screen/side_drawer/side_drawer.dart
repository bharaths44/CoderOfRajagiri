import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cor/src/auth/login/login_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home_controller.dart';

class SideDrawer extends StatelessWidget {
  SideDrawer({super.key});
  Future<Map<String, String>> getCurrentUserDetails() async {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return {'name': 'No current user', 'email': 'No current user'};
    }

    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();

    if (userDoc.exists) {
      return {
        'name': userDoc['name'] as String,
        'email': userDoc['email'] as String,
      };
    } else {
      return {
        'name': 'No username found for current user',
        'email': 'No email found for current user'
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(top: 50.0, left: 30.0, right: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              //p
              children: [
                Column(
                  children: [
                    buildProfileImage(),
                    const SizedBox(height: 50.0),
                    buildMenuItem('Home', Icons.home_outlined, 0),
                    const Divider(),
                    buildMenuItem('Outfits', Icons.shopping_bag, 1),
                    const Divider(),
                    buildMenuItem('Shuffle', Icons.shuffle, 2),
                  ],
                ),
                const Spacer(),
                buildMenuItem('Logout', Icons.logout, -1),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildProfileImage() {
    return FutureBuilder<Map<String, String>>(
      future: getCurrentUserDetails(),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, String>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              children: [
                const SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      snapshot.data?['name'] ?? 'No name',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    AutoSizeText(
                      snapshot.data?['email'] ?? 'No email',
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Get.back(),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget buildMenuItem(String title, IconData icon, int index) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(
        title,
        style: const TextStyle(color: Colors.black, fontSize: 24.0),
      ),
      onTap: () {
        if (index == -1) {
          Get.find<LoginController>().logout();
        } else {
          Get.find<DashBoardController>().changeTabIndex(index);
        }
        Get.back();
      },
    );
  }
}
