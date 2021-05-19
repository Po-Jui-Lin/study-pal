import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:study_pal/chat/service/send.dart';

Future sendFile(String userId, String peerId) async {
  File file;
  FilePickerResult result;

  String fileUrl = '';
  final String groupId = userId.hashCode <= peerId.hashCode ? userId + '-' + peerId : peerId + '-' + userId;

  DateTime now = new DateTime.now();
  DateFormat formatter = DateFormat('yyyyMMdd');
  String formattedDate = formatter.format(now);

  result = await FilePicker.platform.pickFiles(type: FileType.any);

  if (result != null) {
    file = File(result.files.first.path);
  }

  String fileName = now.millisecondsSinceEpoch.toString();
  Reference reference = FirebaseStorage.instance.ref().child("chat").child(groupId).child(formattedDate).child(fileName);
  UploadTask uploadTask = reference.putFile(file);

  try {
    var fileDownUrl = await (await uploadTask).ref.getDownloadURL();
    fileUrl = fileDownUrl.toString();
    send(fileUrl, 2, userId, peerId, TextEditingController());
  } catch (err) {
    Fluttertoast.showToast(msg: 'error');
  }
}
