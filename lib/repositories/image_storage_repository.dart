import 'dart:io';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class Storage {
   static final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  static Future<String> uploadFile(String filePath , String fileName)async {
    File file =File(filePath);
    try{
      Reference ref = storage.ref("Locataire/$fileName");
      await ref.putFile(file);
      return await ref.getDownloadURL();
    }on firebase_core.FirebaseException catch (e){
      if (kDebugMode) {
        print(e);
      }
      return "";
    }
  }


}
