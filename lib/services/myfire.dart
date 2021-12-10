import 'dart:convert';

import 'package:do_it_church/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

Future<void> addLikedList(uid, noticeId) async {
  await firestore
      .collection('Church')
      .doc(HomeRoute.currentChurchId)
      .collection('Notice')
      .doc(noticeId)
      .update({
    'likedUsers': FieldValue.arrayUnion([uid])
  });
}

Future<void> removeLikedList(uid, noticeId) async {
  await firestore
      .collection('Church')
      .doc(HomeRoute.currentChurchId)
      .collection('Notice')
      .doc(noticeId)
      .update({
    'likedUsers': FieldValue.arrayRemove([uid])
  });
}

Future<bool> firestoreChurchName(String name) async {
  List allnames = [];
  await firestore
      .collection('Church')
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      allnames.add(doc["name"]);
    });
  });

  if (allnames.contains(name)) {
    return true;
  } else {
    return false;
  }
}


// Future<String> getLikeCount(noticeId) async {
//   DocumentReference docRef = firestore.collection('Notice').doc(noticeId);

//   DocumentSnapshot docSnap = await docRef.get();

//   var data = await docSnap.data();
//   if (data != null) {
//     Map<String, dynamic>? value = data.;
//     Map<String, dynamic> getField = jsonDecode(value!['likes']);
//   }

//   var valueInfield = getField['likes'];
// }
