import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:robocon_admin_2023/helper/meeting_model.dart';
import 'package:robocon_admin_2023/helper/meeting_model.dart';
import 'package:robocon_admin_2023/helper/registration_model.dart';

import 'logs_model.dart';

class FirebaseHelper {
  static final StreamController<List<RegistrationModel>> _streamController =
      StreamController<List<RegistrationModel>>.broadcast();
  static final StreamController<List<MeetingModel>> _meetingController =
      StreamController<List<MeetingModel>>.broadcast();

  static Future<bool> haveCollectionOrNot(String documentID) async {
    DocumentSnapshot user = await FirebaseFirestore.instance
        .collection('users')
        .doc(documentID)
        .get();
    return user.exists;
  }

  static Future<RegistrationModel?> getData(String? email) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    if (email != null) {
      DocumentSnapshot snapshot =
          await firestore.collection('users').doc(email).get();
      var map = snapshot.data() as Map<String, dynamic>;
      return RegistrationModel.fromJson(map);
    }
  }

  static Future<List<RegistrationModel>> getAllData(
      String selectedTab, String currentAlphabet, String nextAlphabet) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection('users')
          .where("type", isEqualTo: selectedTab)
          .orderBy("name")
          // .limit(10)
          .where("name", isGreaterThanOrEqualTo: currentAlphabet)
          .where("name", isLessThanOrEqualTo: nextAlphabet)
          .get();
      if (snapshot.size > 0) {
        List<RegistrationModel> list = [];
        for (QueryDocumentSnapshot<Map<String, dynamic>> data
            in snapshot.docs) {
          list.add(RegistrationModel.fromJson(data.data()));
        }
        return list;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<List<RegistrationModel>> getAllTabData(
      String selectedTab) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection('users')
          .orderBy("name")
          .where("type", isEqualTo: selectedTab)
          .get();
      if (snapshot.size > 0) {
        List<RegistrationModel> list = [];
        for (QueryDocumentSnapshot<Map<String, dynamic>> data
            in snapshot.docs) {
          list.add(RegistrationModel.fromJson(data.data()));
        }
        return list;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<List<RegistrationModel>> getAllUsersData() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await firestore.collection('users').get();
      if (snapshot.size > 0) {
        List<RegistrationModel> list = [];
        for (QueryDocumentSnapshot<Map<String, dynamic>> data
            in snapshot.docs) {
          list.add(RegistrationModel.fromJson(data.data()));
        }
        return list;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<List<RegistrationModel>> getAllVerifiedData(String selectedTab,
      String currentAlphabet, String nextAlphabet, bool verified) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection('users')
          .where("type", isEqualTo: selectedTab)
          // .orderBy("name")
          // .limit(10)
          .where("name", isGreaterThanOrEqualTo: currentAlphabet)
          .where("name", isLessThanOrEqualTo: nextAlphabet)
          .where('verified', isEqualTo: verified)
          .get();
      if (snapshot.size > 0) {
        List<RegistrationModel> list = [];
        for (QueryDocumentSnapshot<Map<String, dynamic>> data
            in snapshot.docs) {
          list.add(RegistrationModel.fromJson(data.data()));
        }
        return list;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<List<RegistrationModel>> getAllTabVerifiedData(
      String selectedTab, bool verified) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection('users')
          .where("type", isEqualTo: selectedTab)
          .where('verified', isEqualTo: verified)
          .get();
      if (snapshot.size > 0) {
        List<RegistrationModel> list = [];
        for (QueryDocumentSnapshot<Map<String, dynamic>> data
            in snapshot.docs) {
          list.add(RegistrationModel.fromJson(data.data()));
        }
        return list;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<List<RegistrationModel>> getVolunteerData(String type) async {
    if (type != "All") {
      try {
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
            .collection('users')
            .where("type", isEqualTo: "Volunteer")
            .orderBy("name")
            .where("comittee_name", isEqualTo: type)
            .get();
        if (snapshot.size > 0) {
          List<RegistrationModel> list = [];
          for (QueryDocumentSnapshot<Map<String, dynamic>> data
              in snapshot.docs) {
            list.add(RegistrationModel.fromJson(data.data()));
          }
          return list;
        } else {
          return [];
        }
      } catch (e) {
        print(e);
        return [];
      }
    }else{
      try {
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
            .collection('users')
            .where("type", isEqualTo: "Volunteer")
            .orderBy("name")
            .get();
        if (snapshot.size > 0) {
          List<RegistrationModel> list = [];
          for (QueryDocumentSnapshot<Map<String, dynamic>> data
          in snapshot.docs) {
            list.add(RegistrationModel.fromJson(data.data()));
          }
          return list;
        } else {
          return [];
        }
      } catch (e) {
        print(e);
        return [];
      }
    }
  }

  static Future<List<LogsModel>> getLogs(int startTime, int endTime) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection('logs')
          .where("timestamp", isGreaterThanOrEqualTo: startTime)
          .where("timestamp", isLessThanOrEqualTo: endTime)
          .orderBy(
            "timestamp",
            descending: true,
          )
          .get();
      if (snapshot.size > 0) {
        List<LogsModel> list = [];
        for (QueryDocumentSnapshot<Map<String, dynamic>> data
            in snapshot.docs) {
          list.add(LogsModel.fromJson(data.data()));
        }
        return list;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<List<RegistrationModel>> getAllDataLast(
      String selectedTab, String currentAlphabet) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection('users')
          .where("type", isEqualTo: selectedTab)
          .orderBy("name")
          // .limit(10)
          .where("name", isGreaterThanOrEqualTo: currentAlphabet)
          .get();
      if (snapshot.size > 0) {
        List<RegistrationModel> list = [];
        for (QueryDocumentSnapshot<Map<String, dynamic>> data
            in snapshot.docs) {
          list.add(RegistrationModel.fromJson(data.data()));
        }
        return list;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Stream<List<RegistrationModel>> getSearchData(String query) {
    List<RegistrationModel> dataList = [];
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore
        .collection('users')
        .orderBy("name")
        .where("name",
            isGreaterThanOrEqualTo: query,
            isLessThan: query.substring(0, query.length - 1) +
                String.fromCharCode(query.codeUnitAt(query.length - 1) + 1))
        .snapshots()
        .listen((event) {
      for (QueryDocumentSnapshot<Map<String, dynamic>> snapshot in event.docs) {
        dataList.add(RegistrationModel.fromJson(snapshot.data()));
      }
      if (!_streamController.isClosed) {
        _streamController.sink.add(dataList);
      }
    });
    return _streamController.stream;
  }

  static Stream<List<MeetingModel>> getMeetingData() {
    List<MeetingModel> dataList = [];
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore
        .collection('Meetings')
        .orderBy("date")
        .snapshots()
        .listen((event) {
      dataList.clear();
      for (QueryDocumentSnapshot<Map<String, dynamic>> snapshot in event.docs) {
        dataList.add(MeetingModel.fromJson(snapshot.data()));
      }
      if (!_meetingController.isClosed) {
        _meetingController.sink.add(dataList);
      }
    });
    return _meetingController.stream;
  }

  static Future<void> registerDataParticipants(RegistrationModel model) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection('users')
        .doc(model.personalEmail!)
        .set(model.toJson());
  }

  static Future<void> addMeeting(MeetingModel model) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection('Meetings')
        .doc("${model.date}")
        .set(model.toJson());
  }

  static Future<void> deleteMeeting(MeetingModel model) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('Meetings').doc("${model.date}").delete();
  }

  static Future<void> registerDataOthers(RegistrationModel model) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('users').doc(model.email!).set(model.toJson());
  }

  static Future<int> getUserCount(String type) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("users")
        .where("type", isEqualTo: type)
        .get();
    return snapshot.docs.length;
  }

  static Future<int> getVerifiedCount(bool verified) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("users")
        .where("verified", isEqualTo: verified)
        .get();
    return snapshot.docs.length;
  }

  static Future<String?> uploadFile(
      Uint8List data, String filename, String? email) async {
    if (email != null) {
      TaskSnapshot task = await FirebaseStorage.instance
          .ref("participants/$email/$filename")
          .putData(data);
      Get.log(task.metadata!.fullPath);
      return await task.ref.getDownloadURL();
    }
    return null;
  }

  static Future<void> registerData(RegistrationModel model) async {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    if (model.email != null) {
      model.name = model.name?.capitalize!;
      String emailEncoded = stringToBase64.encode(model.email!);
      model.qrImage =
          "https://api.qrserver.com/v1/create-qr-code/?data=https://aburobocon2022-admin.web.app?$emailEncoded&size=512x512";
      model.isVerified = false;
      await firestore.collection('users').doc(model.email!).set(model.toJson());
    }
  }
}
