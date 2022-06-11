
import 'package:drawer_app/constants.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);
  final _items = const [
    "Home",
    "Book",
    "Products",
    "Cart",
    "Settings",
    "Logout",
  ];
  final icons = const [
    Icons.home,
    Icons.book,
    Icons.dashboard,
    Icons.shopping_bag,
    Icons.settings,
    Icons.logout
  ];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8, top: 20, bottom: 8),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(avatarImage, height: 100, width: 100)),
            const SizedBox(height: 10),
            Text("Hammad Parveez", style: TextStyle(color: Colors.white)),
            const SizedBox(height: 30),
            Expanded(
              child: ListView(
                children: List.generate(
                  _items.length,
                  (index) => ListTile(
                    onTap: () {},
                    title: Text(_items[index],
                        style: TextStyle(color: Colors.white)),
                    leading: Icon(icons[index], color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
