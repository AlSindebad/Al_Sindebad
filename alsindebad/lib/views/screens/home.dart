import 'package:alsindebad/views/screens/event_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/place.dart';
import '../../services/place_service.data.dart';
import '../widgets/appBar.dart';
import '../widgets/categories_view.dart';
import '../widgets/palce_card.dart';
import '../widgets/search_component.dart';
import '../widgets/tabBar.dart';
import 'palce_info.dart';
import '../../viewmodel/place_category_viewmodel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class Home extends StatelessWidget {
  final PlacesService placesService = PlacesService();


  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return ChangeNotifierProvider(
      create: (context) => PlaceCategory()..data(),
      child: Scaffold(
        appBar: CustomAppBar(title: localizations!.alsindebad,),
        drawer: Drawer(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    color: Color(0xFF112466),
                    child: ListTile(
                      title: Text(localizations.events,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      leading: Icon(Icons.event, color: Colors.white),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EventsPage()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            SearchBarView(),
            SizedBox(height: 10),
            Expanded(
              flex: 2,
              child: CategoriesComponent(),
            ),
            Expanded(
              flex: 9,
              child: Consumer<PlaceCategory>(
                builder: (context, viewModel, child) {
                  if (viewModel.places.isEmpty) {
                    return FutureBuilder(
                      future: viewModel.data(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else {
                          return ListView.builder(
                            itemCount: viewModel.places.length,
                            itemBuilder: (context, index) {
                              Places place = viewModel.places[index];
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
                    );
                  } else {
                    return ListView.builder(
                      itemCount: viewModel.places.length,
                      itemBuilder: (context, index) {
                        Places place = viewModel.places[index];
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
      ),
    );
  }
}