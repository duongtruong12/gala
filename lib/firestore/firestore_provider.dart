import 'dart:async';

import 'package:base_flutter/firestore/firestore_exception.dart';
import 'package:base_flutter/model/city_model.dart';
import 'package:base_flutter/model/message_group_model.dart';
import 'package:base_flutter/model/ticket_model.dart';
import 'package:base_flutter/model/user_model.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'firestore_config.dart';

class FireStoreProvider {
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance.ref();

  Future<User?> createUser(
      {required String email, required String password}) async {
    loading.value = true;
    User? user;
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: generateMd5(password));
      if (userCredential.user != null) {
        user = userCredential.user;
      }
    } on FirebaseException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    } finally {
      loading.value = false;
    }
    return user;
  }

  Future<UserModel?> getUserDetail({required String? id}) async {
    if (id == user.value?.id) {
      return user.value;
    }

    UserModel? userModel;
    try {
      final userCredential = await fireStore
          .collection(FirebaseCollectionName.users)
          .doc(id)
          .get();
      if (userCredential.data() != null) {
        userModel = UserModel.fromJson(userCredential.data()!);
      }
    } on FirebaseException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    }
    return userModel;
  }

  Future<void> changePassword({required String newPassword}) async {
    loading.value = true;
    try {
      await FirebaseAuth.instance.currentUser?.updatePassword(newPassword);
    } on FirebaseException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    } finally {
      loading.value = false;
    }
  }

  StreamSubscription? listenerCurrentUser({required String id}) {
    StreamSubscription? streamSubscription;
    try {
      streamSubscription = fireStore
          .collection(FirebaseCollectionName.users)
          .doc(id)
          .snapshots()
          .listen((event) async {
        if (event.data() != null) {
          user.value = UserModel.fromJson(event.data()!);
          await storeData(
              key: SharedPrefKey.user, value: userModelToJson(user.value!));
          user.refresh();
        }
      });
    } on FireStoreException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    }
    return streamSubscription;
  }

  Future<String?> uploadFile(
      {required XFile file, required String path}) async {
    loading.value = true;
    try {
      Reference _reference =
          storageRef.child('${user.value?.id}/$path/${file.name}');
      final data = await file.readAsBytes();
      await _reference.putData(
          data,
          SettableMetadata(
            contentType: 'image/jpeg',
          ));
      return await _reference.getDownloadURL();
    } on FirebaseException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    }
  }

  Future<void> deleteAll(String path) async {
    Reference _reference = storageRef.child('${user.value?.id}/$path/');
    final list = await _reference.listAll();
    await Future.wait(list.items.map((e) => e.delete()));
  }

  Future<List<CityModel>> getListCityModel() async {
    final list = <CityModel>[];
    try {
      final doc = fireStore.collection(FirebaseCollectionName.city);
      final query = await doc.get(const GetOptions(source: Source.cache));
      if (query.docs.isEmpty) {
        await doc.get().then((value) => list.addAll(
            value.docs.map((e) => CityModel.fromJson(e.data())).toList()));
      } else {
        list.addAll(
            query.docs.map((e) => CityModel.fromJson(e.data())).toList());
      }
    } on FirebaseException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    }
    return list;
  }

  Future<void> createTicket({required Ticket ticket}) async {
    loading.value = true;
    try {
      final now = Timestamp.now();
      final ticketId = generateMd5('${now.millisecondsSinceEpoch}');
      ticket.id = ticketId;
      ticket.createdUser = user.value?.id;
      ticket.createdDate = now.toDate();
      ticket.expectedPoint = ticket.calculateTotalPrice();
      if (ticket.startTimeAfter != StartTimeAfter.customMinutes.name) {
        if (ticket.startTimeAfter == StartTimeAfter.minutes30.name) {
          ticket.startTime = now.toDate().add(const Duration(minutes: 30));
        } else if (ticket.startTimeAfter == StartTimeAfter.minutes60.name) {
          ticket.startTime = now.toDate().add(const Duration(minutes: 60));
        } else if (ticket.startTimeAfter == StartTimeAfter.minutes90.name) {
          ticket.startTime = now.toDate().add(const Duration(minutes: 90));
        } else {
          ticket.startTime = now.toDate();
        }
      }

      final messageGroupId = generateIdMessage(['admin', user.value!.id!]);

      final messageId = generateMd5('${now.millisecondsSinceEpoch}');
      final lastMessage = MessageModel(
        id: messageId,
        content: 'created_ticket_successfully'.tr,
        userId: user.value?.id,
        delete: false,
        createdTime: now.toDate(),
        type: SendMessageType.create.name,
      );

      final messageGroupReference = fireStore
          .collection(FirebaseCollectionName.messageGroup)
          .doc(messageGroupId);

      final batch = fireStore.batch();

      batch.update(messageGroupReference, {
        'lastMessage': lastMessage.toJson(),
        'lastUpdatedTime': now.toDate().toString(),
      });

      batch.set(
          messageGroupReference
              .collection(FirebaseCollectionName.messagesCollection)
              .doc(messageId),
          lastMessage.toJson(),
          SetOptions(merge: true));

      batch.set(
          fireStore.collection(FirebaseCollectionName.ticket).doc(ticketId),
          ticket.toJson(),
          SetOptions(merge: true));

      await batch.commit();
    } on FirebaseException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    } finally {
      loading.value = false;
    }
  }

  Future<List<StateModel>> getListState({required int? cityId}) async {
    final list = <StateModel>[];
    try {
      final doc = fireStore
          .collection(FirebaseCollectionName.state)
          .where('cityId', isEqualTo: cityId);
      final query = await doc.get(const GetOptions(source: Source.cache));
      if (query.docs.isEmpty) {
        await doc.get().then((value) => list.addAll(
            value.docs.map((e) => StateModel.fromJson(e.data())).toList()));
      } else {
        list.addAll(
            query.docs.map((e) => StateModel.fromJson(e.data())).toList());
      }
    } on FirebaseException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    }
    return list;
  }

  Future<List<String?>> uploadMultipleFiles(
      {required List<XFile> images, required String path}) async {
    loading.value = true;
    List<String?> imageUrls = [];
    try {
      await deleteAll(path);
      imageUrls = await Future.wait(
          images.map((_image) => uploadFile(file: _image, path: path)));
    } on FirebaseException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    } finally {
      loading.value = false;
    }
    return imageUrls;
  }

  Future<void> updateUser({required Map<String, dynamic> data}) async {
    loading.value = true;
    try {
      await fireStore
          .collection(FirebaseCollectionName.users)
          .doc(user.value?.id)
          .update(data);
    } on FirebaseException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    } finally {
      loading.value = false;
    }
  }

  Future<UserModel?> getUserModelCache({required String id}) async {
    UserModel? userModel;
    try {
      final doc = await fireStore
          .collection(FirebaseCollectionName.users)
          .doc(id)
          .get(const GetOptions(source: Source.cache));
      if (doc.exists && doc.data() != null) {
        userModel = UserModel.fromJson(doc.data()!);
      } else {
        final doc = await fireStore
            .collection(FirebaseCollectionName.users)
            .doc(id)
            .get();
        userModel = UserModel.fromJson(doc.data()!);
      }
    } on FirebaseException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    }

    return userModel;
  }

  Future<void> loginUser(
      {required String email, required String password}) async {
    loading.value = true;
    try {
      final userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: generateMd5(password));
      if (userCredential.user == null) {
        showError('error_default'.tr);
        return;
      }

      final doc = await fireStore
          .collection(FirebaseCollectionName.users)
          .doc(userCredential.user?.uid)
          .get();
      if (doc.data() == null || !doc.exists) {
        showError('error_default'.tr);
        return;
      }
      user.value = UserModel.fromJson(doc.data()!);
      await storeData(
          key: SharedPrefKey.password, value: generateMd5(password));
      await storeData(
          key: SharedPrefKey.user, value: userModelToJson(user.value!));
    } on FirebaseException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    } finally {
      loading.value = false;
    }
  }

  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getListUser({
    DocumentSnapshot? lastDocument,
    TypeAccount? sort,
  }) async {
    loading.value = true;
    final list = <DocumentSnapshot<Map<String, dynamic>>>[];
    try {
      _parseList(QuerySnapshot<Map<String, dynamic>> querySnapshot) {
        if (querySnapshot.docs.isEmpty) {
          return;
        }
        list.addAll(querySnapshot.docs);
      }

      final query = fireStore
          .collection(FirebaseCollectionName.users)
          .where('typeAccount', isEqualTo: sort?.name)
          .orderBy('createdDate', descending: true)
          .limit(kPagingSize);
      if (lastDocument != null) {
        await query.startAfterDocument(lastDocument).get().then(_parseList);
      } else {
        await query.get().then(_parseList);
      }
    } on FireStoreException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    } finally {
      loading.value = false;
    }
    return list;
  }

  StreamSubscription? listenerListTicker(
      {required ValueSetter<QuerySnapshot<Map<String, dynamic>>> valueChanged,
      bool futureData = false,
      required DateTime dateTime,
      required String status,
      required int page}) {
    StreamSubscription? streamSubscription;
    try {
      final minDate = Timestamp.fromDate(
          DateTime(dateTime.year, dateTime.month, dateTime.day, 0, 0, 0));
      final maxDate = Timestamp.fromDate(
          DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59, 59));

      final query = fireStore
          .collection(FirebaseCollectionName.ticket)
          .where('status', isEqualTo: status)
          .where('startTime',
              isLessThan: futureData ? null : maxDate, isGreaterThan: minDate);

      if (user.value?.typeAccount != TypeAccount.admin.name) {
        query.where('stateId', isEqualTo: user.value?.stateId).where(
            'tagInformation',
            arrayContainsAny: user.value?.tagInformation);
      }

      streamSubscription =
          query.limit(page * kPagingSize).snapshots().listen((event) async {
        valueChanged(event);
      });
    } on FireStoreException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    }
    return streamSubscription;
  }

  StreamSubscription? listenerMessageGroup(
      {required ValueSetter<QuerySnapshot<Map<String, dynamic>>> valueChanged,
      required int page}) {
    StreamSubscription? streamSubscription;
    try {
      streamSubscription = fireStore
          .collection(FirebaseCollectionName.messageGroup)
          .where('userIds', arrayContains: user.value?.id)
          .orderBy('lastUpdatedTime', descending: true)
          .limit(page * kPagingSize)
          .snapshots()
          .listen((event) async {
        valueChanged(event);
      });
    } on FireStoreException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    }
    return streamSubscription;
  }

  StreamSubscription? listenerMessagesCollection(
      {required ValueSetter<QuerySnapshot<Map<String, dynamic>>> valueChanged,
      required String id,
      required int page}) {
    StreamSubscription? streamSubscription;
    try {
      streamSubscription = fireStore
          .collection(FirebaseCollectionName.messageGroup)
          .doc(id)
          .collection(FirebaseCollectionName.messagesCollection)
          .orderBy('createdTime', descending: false)
          .limit(page * kPagingSize)
          .snapshots()
          .listen((event) async {
        valueChanged(event);
      });
    } on FireStoreException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    }
    return streamSubscription;
  }

  Future<void> applyTicket(Ticket model) async {
    try {
      final batch = fireStore.batch();
      batch.update(
          fireStore
              .collection(FirebaseCollectionName.users)
              .doc(user.value?.id),
          {
            'applyTickets': FieldValue.arrayUnion([model.id]),
          });

      batch.update(
          fireStore.collection(FirebaseCollectionName.ticket).doc(model.id), {
        'peopleApply': FieldValue.arrayUnion([user.value?.id])
      });
      await batch.commit();
    } on FireStoreException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    }
  }

  Future<void> sendMessage(
      {required String content,
      required String messageGroupId,
      required SendMessageType type}) async {
    try {
      final batch = fireStore.batch();
      final now = Timestamp.now();
      final messageId = generateMd5('${now.millisecondsSinceEpoch}');

      final lastMessage = MessageModel(
        id: messageId,
        content: content,
        userId: user.value?.id,
        delete: false,
        createdTime: now.toDate(),
        type: type.name,
      );

      final messageGroupReference = fireStore
          .collection(FirebaseCollectionName.messageGroup)
          .doc(messageGroupId);

      batch.update(messageGroupReference, {
        'lastMessage': lastMessage.toJson(),
        'lastUpdatedTime': now.toDate().toString(),
      });

      batch.set(
          messageGroupReference
              .collection(FirebaseCollectionName.messagesCollection)
              .doc(messageId),
          lastMessage.toJson(),
          SetOptions(merge: true));

      await batch.commit();
    } on FireStoreException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    }
  }

  StreamSubscription? listenerSingleMessageGroup(
      {required String id,
      required ValueSetter<MessageGroupModel> valueSetter}) {
    StreamSubscription? streamSubscription;
    try {
      streamSubscription = fireStore
          .collection(FirebaseCollectionName.messageGroup)
          .doc(id)
          .snapshots()
          .listen((event) async {
        if (event.data() != null) {
          final model = MessageGroupModel.fromJson(event.data()!);
          valueSetter(model);
        }
      });
    } on FireStoreException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    }
    return streamSubscription;
  }

  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getListMessageGroup(
      {DocumentSnapshot? lastDocument}) async {
    loading.value = true;
    final list = <DocumentSnapshot<Map<String, dynamic>>>[];
    try {
      _parseList(QuerySnapshot<Map<String, dynamic>> querySnapshot) {
        if (querySnapshot.docs.isEmpty) {
          return;
        }
        list.addAll(querySnapshot.docs);
      }

      final query = fireStore.collection(FirebaseCollectionName.messageGroup);
      if (lastDocument != null) {
        await query
            .where('userIds', arrayContains: user.value?.id)
            .orderBy('lastUpdatedTime', descending: true)
            .limit(kPagingSize)
            .startAfterDocument(lastDocument)
            .get()
            .then(_parseList);
      } else {
        await query
            .where('userIds', arrayContains: user.value?.id)
            .orderBy('lastUpdatedTime', descending: true)
            .limit(kPagingSize)
            .get()
            .then(_parseList);
      }
    } on FireStoreException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    } finally {
      loading.value = false;
    }
    return list;
  }

  Future<bool> createUserFireStore(
      {required String? email,
      required String? displayName,
      required String? realName,
      required TypeAccount typeAccount,
      required String id}) async {
    loading.value = true;
    bool isSuccess = false;
    try {
      final batch = fireStore.batch();
      final now = Timestamp.now();
      final documentReference =
          fireStore.collection(FirebaseCollectionName.users).doc(id);
      final userModel = UserModel(
        id: id,
        email: email,
        realName: realName,
        displayName: displayName,
        typeAccount: typeAccount.name,
        previewImage: [],
        tagInformation: [],
        currentPoint: 0,
        pointPer30Minutes: 2500,
        createdDate: now.toDate(),
        applyTickets: [],
      );
      batch.set(documentReference, userModel.toJson(), SetOptions(merge: true));

      //Set message
      final messageGroupId = generateIdMessage(['admin', id]);
      final messageId = generateMd5('${now.millisecondsSinceEpoch}');
      final lastMessage = MessageModel(
        id: messageId,
        content: 'created_account_successfully'.tr,
        userId: user.value?.id,
        delete: false,
        createdTime: now.toDate(),
        type: SendMessageType.create.name,
      );
      final model = MessageGroupModel(
        id: messageGroupId,
        title: 'admin'.tr,
        createdTime: now.toDate(),
        messageGroupType: MessageGroupType.admin.name,
        userIds: [user.value?.id, id],
        lastUpdatedTime: now.toDate(),
        lastMessage: lastMessage,
      );
      final messageGroupReference = fireStore
          .collection(FirebaseCollectionName.messageGroup)
          .doc(messageGroupId);
      batch.set(messageGroupReference, model.toJson(), SetOptions(merge: true));

      batch.set(
          messageGroupReference
              .collection(FirebaseCollectionName.messagesCollection)
              .doc(messageId),
          lastMessage.toJson(),
          SetOptions(merge: true));

      await batch.commit().then((value) => isSuccess = true);
    } on FirebaseException catch (e) {
      isSuccess = false;
      throw FireStoreException(e.code, e.message, e.stackTrace);
    } finally {
      loading.value = false;
    }
    return isSuccess;
  }
}
