import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:alsindebad/viewmodels/edit_profile_view_model.dart';
import 'package:alsindebad/data/models/user.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../utils/validators.dart';
import '../widgets/app_bar_with_just_arrow.dart';
import '../widgets/small_button.dart';

class EditProfileScreen extends StatefulWidget {
final UserModel userModel;

EditProfileScreen({required this.userModel});

@override
_EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
final TextEditingController _usernameController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final _formKey = GlobalKey<FormState>();
final EditProfileViewModel _viewModel = EditProfileViewModel();

File? _imageFile;
final ImagePicker _picker = ImagePicker();

String? _selectedCountry;

@override
void initState() {
super.initState();
_usernameController.text = widget.userModel.name;
_emailController.text = widget.userModel.email;
_selectedCountry = widget.userModel.country;
}

Future<void> _pickImage() async {
try {
final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
if (pickedFile != null) {
setState(() {
_imageFile = File(pickedFile.path);
});
}
} catch (e) {
print('Error picking image: $e');
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error picking image')));
}
}

Future<void> _saveProfile() async {
if (_formKey.currentState!.validate()) {
String? imageUrl;
if (_imageFile != null) {
try {
imageUrl = await _viewModel.uploadImageToFirebase(widget.userModel.id, _imageFile!);
} catch (e) {
print('Error uploading image: $e');
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error uploading image')));
return;
}
}
final updatedProfile = UserModel(
id: widget.userModel.id,
name: _usernameController.text,
email: _emailController.text,
country: _selectedCountry!,
imageUrl: imageUrl ?? widget.userModel.imageUrl,
signInMethod: widget.userModel.signInMethod,
);

await _viewModel.updateUserProfile(userModel: updatedProfile, imageFile: _imageFile);
Navigator.of(context).pop();
}
}

@override
Widget build(BuildContext context) {
final localizations = AppLocalizations.of(context);

List<String> countries = [
localizations!.chosse,
localizations.usa,
localizations.canada,
localizations.palestine,
localizations.australia,
localizations.germany,
localizations.france,
localizations.spain,
localizations.italy,
localizations.egypt,
localizations.japan
];

return Scaffold(
appBar: CustomAppBarNavigateJustBack(title: localizations.editProfile),
body: Padding(
padding: const EdgeInsets.all(45.0),
child: SingleChildScrollView(
child: Form(
key: _formKey,
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
_buildProfileImage(),
SizedBox(height: 10),
_buildInputField(localizations.name, _usernameController, localizations),
SizedBox(height: 10),
  _buildEmailInputField(localizations.email, _emailController, localizations, widget.userModel.signInMethod),
SizedBox(height: 10),
_buildCountryDropdown(localizations.country, countries),
SizedBox(height: 20),
Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [
SButton(
backgroundColor: Colors.red,
label: localizations.cancel,
onPressed: () {
Navigator.of(context).pop();
},
),
SizedBox(width: 20),
SButton(
backgroundColor: Color(0xFF112466),
label: localizations.save,
onPressed: _saveProfile,
),
],
),
],
),
),
),
)

);
}

Widget _buildProfileImage() {
return Stack(
children: [
CircleAvatar(
radius: 80,
backgroundImage: _imageFile != null
? FileImage(_imageFile!)
    : NetworkImage(widget.userModel.imageUrl ?? 'https://via.placeholder.com/150') as ImageProvider,
backgroundColor: Colors.grey.shade200,

),
Positioned(
bottom: 0,
right: 0,

child: InkWell(
onTap: _pickImage,
child: Icon(
Icons.camera_alt,
color: Color(0xFF112466),
size: 30,
),
),
),
],
);
}

Widget _buildInputField(String title, TextEditingController controller, AppLocalizations localizations) {
return Container(
width: 300,
padding: EdgeInsets.symmetric(vertical: 8.0),
child: TextFormField(
controller: controller,
decoration: InputDecoration(
labelText: title,
border: OutlineInputBorder(),
),
validator: (value) => Validators.validateName(value, localizations),
),
);
}

Widget _buildEmailInputField(String title, TextEditingController controller, AppLocalizations localizations, String signInMethod) {
return Container(
width: 300,
padding: EdgeInsets.symmetric(vertical: 8.0),
child: TextFormField(
controller: controller,
decoration: InputDecoration(
labelText: title,
border: OutlineInputBorder(),
),
validator: (value) => Validators.validateEmail(value, localizations),
  enabled: signInMethod != 'Google' && signInMethod != 'Email & Password',),
);
}

Widget _buildCountryDropdown(String title, List<String> countries) {
return Container(
width: 300,
padding: EdgeInsets.symmetric(vertical: 8.0),
child: DropdownButtonFormField<String>(
value: _selectedCountry == 'Choose' ? countries.first : _selectedCountry,
decoration: InputDecoration(
labelText: title,
border: OutlineInputBorder(),
),
items: countries.map((String country) {
return DropdownMenuItem<String>(
value: country,
child: Text(country),
);
}).toList(),
onChanged: (String? newValue) {
setState(() {
_selectedCountry = newValue;
});
},
validator: (value) {
if (value == null || value.isEmpty) {
return 'Please select a country';
}
return null;
},
),
);
}
}
