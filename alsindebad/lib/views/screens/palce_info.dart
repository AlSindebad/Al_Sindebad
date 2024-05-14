import 'package:flutter/material.dart';
import '../../data/models/place.dart';
import '../../viewmodel/place_info_viewmodel.dart';
import '../widgets/appBar.dart';

class PlaceInfo extends StatefulWidget {
  final String id;
  final String googleMapsUrl;
  PlaceInfo({required this.id, required this.googleMapsUrl});

  @override
  _PlaceInfoState createState() => _PlaceInfoState();
}

class _PlaceInfoState extends State<PlaceInfo> {
  Color myColor = const Color(0xFF112466);

  late Future<Places?> _placeFuture;
  final PlaceInfoViewModel _viewModel = PlaceInfoViewModel();

  @override
  void initState() {
    super.initState();
    _placeFuture = _viewModel.getPlaceInfo(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Places?>(
      future: _placeFuture,
      builder: (BuildContext context, AsyncSnapshot<Places?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: Text("Loading..."), leading: BackButton()),
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError || snapshot.data == null) {
          return Scaffold(
            appBar: AppBar(title: Text("Error"), leading: BackButton() ),
            body: Center(child: Text('Error loading place info')),
          );
        } else {
          Places place = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: Text(place.placeName),
              leading: BackButton(),
              actions: [
                IconButton(
                  icon: Icon(Icons.notifications),
                  color:myColor ,
                  onPressed: () {
                    // Handle favorite action
                  },
                ),
                IconButton(
                  icon: Icon(Icons.account_circle),
                  color: myColor,
                  onPressed: () {
                    // Handle share action
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: place.images.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Image.network(
                            place.images[index],
                            width: 400,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      place.placeName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: List.generate(
                        place.placeReview,
                            (index) => Icon(Icons.star, color: Colors.yellow),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      place.placeDescription,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: 100,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Color(0xFF112466),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: IconButton(
                        onPressed: () {
                          _viewModel.openGoogleMaps(place.locationUrl);
                        },
                        icon: Icon(Icons.location_on, size: 40,),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
