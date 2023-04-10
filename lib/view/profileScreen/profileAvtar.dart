import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileAvatarWidget extends StatefulWidget {
  const ProfileAvatarWidget({Key? key}) : super(key: key);

  @override
  _ProfileAvatarWidgetState createState() => _ProfileAvatarWidgetState();
}

class _ProfileAvatarWidgetState extends State<ProfileAvatarWidget> {
  File? _image;

  final _picker = ImagePicker();

  Future<void> _getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipOval(
    child: Material(
      color: Colors.transparent,
      child: Ink.image(
        image: const AssetImage('assets/images/myProfile2.jpg'),
        fit: BoxFit.cover,
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.25,
        child: InkWell(
          onTap: () {
            // Handle onTap
          },
        ),
      ),
    ),
  ),

        Positioned(
          bottom: 2,
          right: 6,
          child: GestureDetector(
            onTap: (){
              _getImage();
            },
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Container(
                padding: const EdgeInsets.all(2),
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Icon(Icons.edit, size: MediaQuery.of(context).size.height * 0.028, color: Colors.white,))),
                ),
              ),
          ),
          ),
        
      ],
    );



  }
}



/*


CircleAvatar(
                radius: 100,
                backgroundColor: Colors.white,
                foregroundImage: _image != null
                    ? FileImage(_image!)
                    : const AssetImage('assets/images/myProfile.jpg')
                        as ImageProvider<Object>?,
                child: _image == null
                    ? const Icon(
                        Icons.person,
                        size: 130,
                      )
                    : null,
              ),



*/