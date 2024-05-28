import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/place.dart';
import '../widgets/appBar.dart';
import '../widgets/categories_view.dart';
import '../widgets/palce_card.dart';
import '../widgets/search_component.dart';
import '../widgets/tabBar.dart';
import 'palce_info.dart';
import '../../viewmodel/place_Category_viewmodel.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PlaceCategory()..data(),
      child: Scaffold(
        appBar: CustomAppBar(title: "Home Page"),
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
                    return Center(child: CircularProgressIndicator());
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
