import 'package:drawer_app/constants.dart';
import 'package:drawer_app/main.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final VoidCallback? openDrawer;
  const HomePage({Key? key, this.openDrawer}) : super(key: key);

  final img =
      'https://play-lh.googleusercontent.com/rKJc3JnKbUHWzifgGHFWHuhxBAIcDLgASw0FlwW8x6GZCurj_eAeeAsSyB6BlcI7EyDy';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: openDrawer,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                10,
                (index) => Container(
                  margin: EdgeInsets.only(left: 10),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  height: 150,
                  width: MediaQuery.of(context).size.width * .8,
                  child: Image.network(
                    img,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
