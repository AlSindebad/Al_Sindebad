import 'package:alsindebad/views/widgets/smallButton.dart';
import 'package:flutter/material.dart';
import '../../data/models/place.dart';
import '../../viewmodel/place_info_viewmodel.dart';
import '../widgets/app_bar_with_navigate_back.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlaceInfo extends StatefulWidget {
  final String id;
  final String googleMapsUrl;
  PlaceInfo({required this.id, required this.googleMapsUrl});

  @override
  _PlaceInfoState createState() => _PlaceInfoState();

}

class _PlaceInfoState extends State<PlaceInfo> {
  late Future<Places?> _placeFuture;
  final PlaceInfoViewModel _viewModel = PlaceInfoViewModel();
  int _userReview = 0;
  bool _isDialogShown = false;

  @override
  void initState() {
    super.initState();
    _placeFuture = _viewModel.getPlaceInfo(widget.id);
    _loadUserReview();
    Future.delayed(Duration(seconds: 5),
        _showReviewDialog);
  }

  void _loadUserReview() async {
    int? review = await _viewModel.getUserReview(widget.id);
    if (review != null) {
      setState(() {
        _userReview = review;
        _isDialogShown =
            true; // User already reviewed, dialog should not be shown again
      });
    }
  }

  void _showReviewDialog() {
    if (_isDialogShown)
      return; // If user already reviewed, don't show the dialog
    _isDialogShown = true;

    showDialog(

      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.ratethisplace,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        5,
                        (index) => IconButton(
                          icon: Icon(
                            index < _userReview
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.yellow,
                          ),
                          onPressed: () {
                            setState(() {
                              _userReview = index + 1;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SButton(onPressed:(){
                      Navigator.of(context).pop();
                      _submitReview(_userReview);
                    }, label: (AppLocalizations.of(context)!.submit), backgroundColor: Color(0xFF112466))
                   ,
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _submitReview(int review) async {
    if (review > 0) {
      await _viewModel.submitReview(widget.id, review);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.thanks),
          duration: Duration(seconds: 2),
        ),
      );
      setState(() {
        _placeFuture = _viewModel.getPlaceInfo(
            widget.id); // Refresh the state to show the updated review
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Places?>(
      future: _placeFuture,
      builder: (BuildContext context, AsyncSnapshot<Places?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: CustomAppBarNavigateBack(title: "Loading..."),
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError || snapshot.data == null) {
          return Scaffold(
            appBar: CustomAppBarNavigateBack(title: "Error"),
            body: Center(child: Text('Error loading place info')),
          );
        } else {
          Places place = snapshot.data!;
          return Scaffold(
            appBar: CustomAppBarNavigateBack(title: place.placeName),
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
                        5,
                        (index) => Icon(
                          index < place.averageRating
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.yellow,
                        ),
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
                        icon: Icon(
                          Icons.location_on,
                          size: 40,
                        ),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
