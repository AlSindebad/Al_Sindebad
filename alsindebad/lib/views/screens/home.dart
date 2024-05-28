
import 'package:flutter/material.dart';
import 'package:alsindebad/data/models/place.dart';
import 'package:alsindebad/views/screens/event.dart';
import 'package:alsindebad/views/screens/palce_info.dart';
import '../../services/place_service.data.dart';
import '../widgets/appBar.dart';
import '../widgets/categories_view.dart';
import '../widgets/palce_card.dart';
import '../widgets/search_component.dart';
import '../widgets/tabBar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class Home extends StatelessWidget {
  final PlacesService placesService = PlacesService();

  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Home Page"),
      drawer: Drawer(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    color: Color(0xFF112466),

                    child: ListTile(
                      title: Text("Events", style: TextStyle(color: Colors.white,fontSize: 20),),
                      leading: Icon(Icons.event, color: Colors.white),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Events()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      body: Column(
        children: [
          Expanded(child: SearchBarView()),
          SizedBox(height: 10),
          Expanded(
            flex: 2,
            child: CategoriesComponent(),
          ),
          Expanded(
            flex: 9,
            child: FutureBuilder(
              future: placesService.getPlaces(),
              builder: (context, AsyncSnapshot<List<Places>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<Places> places = snapshot.data ?? [];

                  return ListView.builder(
                    itemCount: places.length,
                    itemBuilder: (context, index) {
                      Places place = places[index];
                      return PlaceCard(
                        title: place.placeName,
                        location: place.placelocation,
                        imageUrl: place.placeImage,
                        averageRating: place.averageRating,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlaceInfo(
                                id: place.placeId,
                                googleMapsUrl: place.locationUrl,
                              ),
                            ),
                          );
                        },
                      );

                    },
                  );
                }
              },
            ),
          ),
          Expanded(child: NavigationExample()),
        ],
      ),
    );
  }
}
