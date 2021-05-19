import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:study_pal/chat/service/send.dart';

Future sendImage(String userId, String peerId) async {
  ImagePicker imagePicker = ImagePicker();
  PickedFile pickedFile;
  File imageFile;
  String imageUrl = '';
  final String groupId = userId.hashCode <= peerId.hashCode ? userId + '-' + peerId : peerId + '-' + userId;

  DateTime now = new DateTime.now();
  DateFormat formatter = DateFormat('yyyyMMdd');
  String formattedDate = formatter.format(now);

  pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
  imageFile = File(pickedFile.path);

  String fileName = now.millisecondsSinceEpoch.toString();
  Reference reference = FirebaseStorage.instance.ref().child("chat").child(groupId).child(formattedDate).child(fileName);
  UploadTask uploadTask = reference.putFile(imageFile);

  try {
    var imageDownUrl = await (await uploadTask).ref.getDownloadURL();
    imageUrl = imageDownUrl.toString();
    send(imageUrl, 1, userId, peerId, TextEditingController());
  } catch (err) {
    Fluttertoast.showToast(msg: 'error');
  }
}
