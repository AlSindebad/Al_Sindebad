import 'package:alsindebad/views/screens/palce_info.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/models/place.dart';
import '../widgets/app_bar_with_navigate_back.dart';
import '../widgets/palce_card.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String name = '';
  String placelocation = '';
  String ArabicName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarNavigateBack(
        title: ('Search'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Container(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    suffixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      borderSide: BorderSide(color: Colors.white60),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                  ),
                  onChanged: (val) {
                    setState(() {
                      name = val;
                      placelocation = val ;
                      ArabicName = val ;
                    });
                  },
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('places').snapshots(),
                  builder: (context, snapshots) {
                    if (snapshots.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshots.hasError) {
                      return Center(child: Text('Error: ${snapshots.error}'));
                    } else if (!snapshots.hasData || snapshots.data!.docs.isEmpty) {
                      return Center(child: Text('No places found'));
                    } else {
                      var filteredDocs = snapshots.data!.docs.where((doc) {
                        var data = doc.data() as Map<String, dynamic>;
                        var placeName = data['name'] ?? '';
                        var placeLocation = data['placelocation'] ?? '';
                        var placeArabicName = data['ArabicName'] ?? '';
                        return name.isEmpty ||
                            placeName.toString().toLowerCase().contains(name.toLowerCase()) ||
                            placeLocation.toString().toLowerCase().contains(placelocation.toLowerCase())||
                            placeArabicName.toString().toLowerCase().contains(ArabicName.toLowerCase());

                      }).toList();

                      List<Places> places = filteredDocs.map((doc) {
                        var data = doc.data() as Map<String, dynamic>;
                        return Places(
                          placeId: doc.id,
                          placeName: data['name'] ?? 'No Name',
                          placelocation: data['placelocation'] ?? 'No Location',
                          placeImage: data['cardImage'] ?? '',
                          placeReview: data['review'] ?? 0,
                          locationUrl: data['locationUrl'] ?? '',
                          placeDescription: data['placeDescription'] ?? '',
                          images: List<String>.from(data['images'] ?? []),
                          placeCategory: data['placeCategory'] ?? '',
                        );
                      }).toList();

                      return ListView.builder(
                        itemCount: places.length,
                        itemBuilder: (context, index) {
                          Places place = places[index];
                          return PlaceCard(
                            title: place.placeName,
                            location: place.placelocation,
                            imageUrl: place.placeImage,
                            numStars: place.placeReview,
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
            ],
          ),
        ),
      ),
    );
  }
}
