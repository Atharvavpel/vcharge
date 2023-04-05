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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        children: [
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

          Positioned(
            bottom: 0,
            right: 0,
            child: IconButton(onPressed: (){
              _getImage();
            }, icon: const Icon(Icons.camera_alt_sharp, size: 30)),
          )
          
        ],
      ),
    );













    // return GestureDetector(
    //   onTap: _getImage,
    //   child: Padding(
    //     padding: const EdgeInsets.all(10.0),
    //     child: Stack(
    //       children: [
    //         CircleAvatar(
    //           radius: 100,
    //           backgroundColor: Colors.white,
    //           backgroundImage: _image != null
    //               ? FileImage(_image!)
    //               : const AssetImage('assets/images/myProfile.jpg')
    //                   as ImageProvider<Object>?,
    //           child: _image == null
    //               ? const Icon(
    //                   Icons.person,
    //                   size: 130,
    //                 )
    //               : null,
    //         ),
            
    //       ],
    //     ),
    //   ),
    // );
  }
}
