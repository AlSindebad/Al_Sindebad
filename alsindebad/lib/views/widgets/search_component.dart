import 'package:flutter/material.dart';
import '../screens/search_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class SearchBarView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

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
                  hintText: localizations!.search,
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
