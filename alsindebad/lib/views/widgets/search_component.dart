import 'package:flutter/material.dart';
import '../screens/search_page.dart';

class SearchBarView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Search()),
            );
          },
          child: Container(
            child: AbsorbPointer(
              child: AbsorbPointer(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search here',
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    borderSide: BorderSide(color: Colors.white60),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
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
