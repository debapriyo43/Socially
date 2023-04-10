import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? file = await _imagePicker.pickImage(source: source);
  if (file != null) {
    return await file.readAsBytes();
  }
}

showSnakBar(String content, BuildContext context) {
  //SnackBar is a widget which will pop out from bottom of the app.
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}
// Future pickImage(ImageSource source) async {
//   try {
//     final image = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (image == null) return;
//     final imageTemporary = File(image.path);
//     setState(() {
//       image1 = imageTemporary;
//     });
//   } catch (error) {
//     print("error: $error");
//   }
// }
