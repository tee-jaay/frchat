import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker(this.imagePickFn,{Key? key}) : super(key: key);

  final Function(File pickImage) imagePickFn;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImageFile;

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 150,
      maxHeight: 150,
      imageQuality: 50,
    );
    final pickedImageFile = File(pickedImage!.path);

    setState(() {
      _pickedImageFile = pickedImageFile;
    });
    widget.imagePickFn(_pickedImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40.0,
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedImageFile != null ? FileImage(_pickedImageFile!) : null,
        ),
        const SizedBox(
          height: 12,
        ),
        TextButton.icon(
            onPressed: _pickImage,
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              primary: Colors.white,
            ),
            icon: const Icon(Icons.image),
            label: const Text('Add Image')),
      ],
    );
  }
}
