import 'dart:async';

import 'package:base_flutter/firestore/firestore_exception.dart';
import 'package:base_flutter/model/city_model.dart';
import 'package:base_flutter/model/message_group_model.dart';
import 'package:base_flutter/model/notification_model.dart';
import 'package:base_flutter/model/ticket_model.dart';
import 'package:base_flutter/model/transfer_information_model.dart';
import 'package:base_flutter/model/transfer_request_model.dart';
import 'package:base_flutter/model/user_model.dart';
import 'package:base_flutter/ui/screen/home/dash_board/my_page_female/user_guide_female/user_guide_female_controller.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:base_flutter/utils/validate.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sprintf/sprintf.dart';

import '../model/point_cost_model.dart';
import 'firestore_config.dart';

class FireStoreProvider {
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance.ref();
  final messaging = FirebaseMessaging.instance;

  Future<void> installNotification() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      return;
    }
    final token = await messaging.getToken();
    if (token == null) {
      return;
    }
    await fireStoreProvider.updateUser(data: {'notificationToken': token});
  }

  StreamSubscription listenNotification() {
    return FirebaseMessaging.onMessage.listen((event) {
      if (Get.context == null ||
          event.notification?.title == null ||
          event.notification?.body == null) {
        return;
      }
      CherryToast(
        title: Text(event.notification?.title ?? ''),
        description: Text(event.notification?.body ?? ''),
        toastPosition: Position.top,
        layout: ToastLayout.rtl,
        animationType: AnimationType.fromTop,
        icon: Icons.message_rounded,
        iconColor: getColorPrimary(),
        themeColor: getColorPrimary(),
      ).show(Get.context!);
    });
  }

  //User
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

  Future<void> forgotPassword(String email) async {
    loading.value = true;
    try {
      await auth.sendPasswordResetEmail(email: email);
    } on FirebaseException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    } finally {
      loading.value = false;
    }
  }

  Future<List> getListToken(List userId,
      {ValueSetter<List>? myEmailSetter}) async {
    final listToken = [];
    final listEmail = [];
    void parseList(QuerySnapshot<Map<String, dynamic>> doc) {
      if (doc.docs.isNotEmpty) {
        for (var element in doc.docs) {
          if (element.id != user.value?.id) {
            final model = UserModel.fromJson(element.data());
            if (model.notificationToken != null) {
              listToken.add(model.notificationToken);
            }
            if (model.email != null) {
              listEmail.add(model.email);
            }
          }
        }
      }
    }

    try {
      final doc = await fireStore
          .collection(FirebaseCollectionName.users)
          .where('id', whereIn: userId)
          .get();
      parseList(doc);
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable') {
        final doc = await fireStore
            .collection(FirebaseCollectionName.users)
            .where('id', whereIn: userId)
            .get();
        parseList(doc);
      } else {
        throw FireStoreException(e.code, e.message, e.stackTrace);
      }
    }
    if (myEmailSetter != null) {
      myEmailSetter(listEmail);
    }
    return listToken;
  }

  Future<List> getListTokenAdmin() async {
    final listToken = [];
    void parseList(QuerySnapshot<Map<String, dynamic>> doc) {
      if (doc.docs.isNotEmpty) {
        for (var element in doc.docs) {
          if (element.id != user.value?.id) {
            final model = UserModel.fromJson(element.data());
            listToken.add(model.notificationToken);
          }
        }
      }
    }

    try {
      final doc = await fireStore
          .collection(FirebaseCollectionName.users)
          .where('typeAccount', isEqualTo: 'admin')
          .get(const GetOptions(source: Source.cache));
      parseList(doc);
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable') {
        final doc = await fireStore
            .collection(FirebaseCollectionName.users)
            .where('typeAccount', isEqualTo: 'admin')
            .get();
        parseList(doc);
      } else {
        throw FireStoreException(e.code, e.message, e.stackTrace);
      }
    }
    return listToken;
  }

  Future<UserModel?> getUserDetail(
      {required String? id, Source source = Source.serverAndCache}) async {
    if (id == user.value?.id) {
      return user.value;
    }

    UserModel? userModel;
    try {
      final userCredential = await fireStore
          .collection(FirebaseCollectionName.users)
          .doc(id)
          .get(GetOptions(source: source));
      if (userCredential.data() != null) {
        userModel = UserModel.fromJson(userCredential.data()!);
      }
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable') {
        final doc = await fireStore
            .collection(FirebaseCollectionName.users)
            .doc(id)
            .get();
        if (doc.data() != null) {
          userModel = UserModel.fromJson(doc.data()!);
        }
      } else {
        throw FireStoreException(e.code, e.message, e.stackTrace);
      }
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
              key: SharedPrefKey.user,
              value: userModelToJsonSaveValue(user.value!));
          user.refresh();
        }
      });
    } on FirebaseException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    }
    return streamSubscription;
  }

  Future<bool> checkUserId(String? userId) async {
    loading.value = true;
    try {
      final query = await fireStore
          .collection(FirebaseCollectionName.users)
          .where('userId', isEqualTo: userId)
          .get();
      if (query.docs.isEmpty) {
        return true;
      } else {
        return false;
      }
    } on FirebaseException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    } finally {
      loading.value = false;
    }
  }

  Future<bool> createUserFireStore(
      {required String? email,
      required String? displayName,
      required String? realName,
      required String? userId,
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
        userId: userId,
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
        approveTickets: [],
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
        seenMessage: {user.value?.id: now},
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
      final doc = fireStore
          .collection(FirebaseCollectionName.city)
          .orderBy('id', descending: false);
      final query = await doc.get(const GetOptions(source: Source.cache));
      if (query.docs.isEmpty) {
        await doc.get().then((value) => list.addAll(
            value.docs.map((e) => CityModel.fromJson(e.data())).toList()));
      }
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable') {
        final doc = fireStore.collection(FirebaseCollectionName.city);
        await doc.get().then((value) => list.addAll(
            value.docs.map((e) => CityModel.fromJson(e.data())).toList()));
      } else {
        throw FireStoreException(e.code, e.message, e.stackTrace);
      }
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

  Future<void> loginUser(
      {required String email, required String password}) async {
    loading.value = true;
    try {
      String str = email;
      final isEmail = Validate.emailValidate(email) == null;
      if (!isEmail) {
        final doc = await fireStore
            .collection(FirebaseCollectionName.users)
            .where('userId', isEqualTo: str)
            .get();

        if (doc.docs.isEmpty) {
          showError('user-not-found'.tr);
          return;
        } else {
          final userModel = UserModel.fromJson(doc.docs.first.data());
          str = userModel.email ?? '';
        }
      }

      final userCredential = await auth.signInWithEmailAndPassword(
          email: str, password: generateMd5(password));

      if (userCredential.user == null) {
        showError('error_default'.tr);
        return;
      }
      await queryUserFromFirebase(userCredential.user!, password: password);
    } on FirebaseException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    } finally {
      loading.value = false;
    }
  }

  Future<User?> getCurrentUser() async {
    User? firebaseUser = auth.currentUser;
    firebaseUser ??= await auth.authStateChanges().single;

    return firebaseUser;
  }

  Future<void> queryUserFromFirebase(User authFirebase,
      {String? password}) async {
    loading.value = true;
    try {
      final doc = await fireStore
          .collection(FirebaseCollectionName.users)
          .doc(authFirebase.uid)
          .get();
      if (doc.data() == null || !doc.exists) {
        showError('error_default'.tr);
        return;
      }
      user.value = UserModel.fromJson(doc.data()!);
      if (password != null) {
        await storeData(
            key: SharedPrefKey.password, value: generateMd5(password));
      }
      await storeData(
          key: SharedPrefKey.user,
          value: userModelToJsonSaveValue(user.value!));
    } on FirebaseException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    } finally {
      loading.value = false;
    }
  }

  StreamSubscription? listenerListUser(
      {required ValueSetter<QuerySnapshot<Map<String, dynamic>>> valueChanged,
      TypeAccount? sort,
      required int page}) {
    StreamSubscription? streamSubscription;
    try {
      streamSubscription = fireStore
          .collection(FirebaseCollectionName.users)
          .where('typeAccount', isEqualTo: sort?.name)
          .orderBy('createdDate', descending: true)
          .limit(kPagingSize * page)
          .snapshots()
          .listen((event) async {
        valueChanged(event);
      });
    } on FirebaseException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    }
    return streamSubscription;
  }

  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getListUser({
    DocumentSnapshot? lastDocument,
    TypeAccount? sort,
    bool sortPeopleApprove = false,
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

      var query = fireStore
          .collection(FirebaseCollectionName.users)
          .where('typeAccount', isEqualTo: sort?.name)
          .orderBy('createdDate', descending: true)
          .limit(kPagingSize);
      if (sortPeopleApprove) {
        query = fireStore
            .collection(FirebaseCollectionName.users)
            .where('typeAccount', isEqualTo: sort?.name)
            .orderBy('createdDate', descending: true)
            .where('approveTickets', isEqualTo: []).limit(kPagingSize);
      }
      if (lastDocument != null) {
        await query.startAfterDocument(lastDocument).get().then(_parseList);
      } else {
        await query.get().then(_parseList);
      }
    } on FirebaseException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    } finally {
      loading.value = false;
    }
    return list;
  }

  Future<List<DocumentSnapshot<Map<String, dynamic>>>> searchListUser({
    DocumentSnapshot? lastDocument,
    String? address,
    String? birthPlace,
    required List<int> height,
    required List<int> age,
    TypeAccount? sort,
  }) async {
    loading.value = true;
    final list = <DocumentSnapshot<Map<String, dynamic>>>[];
    try {
      _parseList(QuerySnapshot<Map<String, dynamic>> querySnapshot) {
        if (querySnapshot.docs.isEmpty) {
          return;
        }
        if (height.length < 2 || querySnapshot.docs.isEmpty) {
          list.addAll(querySnapshot.docs);
          return;
        }

        for (var element in querySnapshot.docs) {
          final model = UserModel.fromJson(element.data());
          if (model.height != null) {
            if (model.height! >= height[0] && model.height! <= height[1]) {
              list.add(element);
            }
          }
        }
      }

      final now = Timestamp.now();
      Timestamp? minDate, maxDate;
      if (age.length > 1) {
        minDate = Timestamp.fromDate(
            DateTime(now.toDate().year - age[1], 1, 1, 0, 0, 0));
        maxDate = Timestamp.fromDate(
            DateTime(now.toDate().year - age[0], 12, 31, 23, 59, 59));
      }

      var query = fireStore
          .collection(FirebaseCollectionName.users)
          .where('typeAccount', isEqualTo: sort?.name)
          .where('address', isEqualTo: address)
          .where('birthPlace', isEqualTo: birthPlace)
          .where('birthday', isLessThan: maxDate, isGreaterThan: minDate)
          .limit(kPagingSize);
      if (lastDocument != null) {
        await query.startAfterDocument(lastDocument).get().then(_parseList);
      } else {
        await query.get().then(_parseList);
      }
    } on FirebaseException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    } finally {
      loading.value = false;
    }
    return list;
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

  //Ticket
  Future<void> createTicket({required Ticket ticket}) async {
    loading.value = true;
    try {
      final now = Timestamp.now();
      final ticketId = generateMd5('${now.millisecondsSinceEpoch}');
      ticket.id = ticketId;
      ticket.createdUser = user.value?.id;
      ticket.createdDate = now.toDate();
      ticket.status = TicketStatus.created.name;
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
        content: sprintf('user_create_ticket'.tr,
            [user.value?.displayName, ticket.getTicketName()]),
        userId: user.value?.id,
        delete: false,
        ticketId: ticketId,
        createdTime: now.toDate(),
        type: SendMessageType.createTicket.name,
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
      final listToken = await getListTokenAdmin();
      batch.set(
          fireStore
              .collection(FirebaseCollectionName.notification)
              .doc(messageGroupId)
              .collection(FirebaseCollectionName.itemsNotification)
              .doc(messageId),
          NotificationModel(
            id: messageId,
            title: ticket.getTicketName(),
            body: 'created_ticket_successfully'.tr,
            createdDate: now.toDate(),
            listToken: listToken,
          ).toJson(),
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

  Future<void> cancelTicket({required Ticket ticket}) async {
    loading.value = true;
    try {
      final batch = fireStore.batch();
      final now = Timestamp.now();
      ticket.status = TicketStatus.cancelled.name;
      final messageGroupId = generateIdMessage(['admin', ticket.createdUser!]);

      final messageId = generateMd5('${now.millisecondsSinceEpoch}');
      final lastMessage = MessageModel(
        id: messageId,
        content: sprintf('ticket_has_cancelled'.tr, [ticket.getTicketName()]),
        userId: user.value?.id,
        delete: false,
        ticketId: ticket.id,
        createdTime: now.toDate(),
        type: SendMessageType.create.name,
      );

      // update message created cancelled ticket
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

      // Update people apply cancelled
      for (var element in ticket.peopleApply) {
        final messageGroupId = generateIdMessage(['admin', element!]);

        final messageId = generateMd5('${now.millisecondsSinceEpoch}');
        final lastMessage = MessageModel(
          id: messageId,
          content: sprintf('ticket_has_cancelled'.tr, [ticket.getTicketName()]),
          userId: user.value?.id,
          delete: false,
          ticketId: ticket.id,
          createdTime: now.toDate(),
          type: SendMessageType.create.name,
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

        batch.update(
            fireStore.collection(FirebaseCollectionName.users).doc(element), {
          'applyTickets': FieldValue.arrayRemove([ticket.id]),
        });
      }

      // update ticket
      batch.set(
          fireStore.collection(FirebaseCollectionName.ticket).doc(ticket.id),
          ticket.toJson(),
          SetOptions(merge: true));

      await batch.commit();
    } on FirebaseException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    } finally {
      loading.value = false;
    }
  }

  Future<void> createMessageGroupTicket({required Ticket ticket}) async {
    loading.value = true;
    try {
      final batch = fireStore.batch();
      final now = Timestamp.now();
      ticket.status = TicketStatus.done.name;
      final listUser = <String>[
        ...ticket.peopleApprove,
        ticket.createdUser!,
        user.value!.id!
      ];
      final messageGroupId = generateIdMessage([...listUser, ticket.id!]);
      final messageId = generateMd5('${now.millisecondsSinceEpoch}');
      final messageGroupReference = fireStore
          .collection(FirebaseCollectionName.messageGroup)
          .doc(messageGroupId);

      // update ticket
      batch.set(
          fireStore.collection(FirebaseCollectionName.ticket).doc(ticket.id),
          ticket.toJson(),
          SetOptions(merge: true));

      // Update people apply cancelled
      for (var element in ticket.peopleApply) {
        batch.update(
            fireStore.collection(FirebaseCollectionName.users).doc(element), {
          'applyTickets': FieldValue.arrayRemove([ticket.id]),
        });
      }

      // Update people approve
      for (var element in ticket.peopleApprove) {
        batch.update(
            fireStore.collection(FirebaseCollectionName.users).doc(element), {
          'applyTickets': FieldValue.arrayRemove([ticket.id]),
          'approveTickets': FieldValue.arrayUnion([ticket.id]),
        });
        batch.set(
            messageGroupReference
                .collection(FirebaseCollectionName.countTimeTicket)
                .doc(element),
            CountTimeModel(id: element, point: ticket.calculateEachPrice())
                .toJson(),
            SetOptions(merge: true));
      }

      //Set message
      final lastMessage = MessageModel(
        id: messageId,
        content: 'created_ticket_successfully'.tr,
        userId: ticket.createdUser,
        delete: false,
        createdTime: now.toDate(),
        type: SendMessageType.create.name,
      );
      final model = MessageGroupModel(
        id: messageGroupId,
        ticketId: ticket.id,
        title: ticket.getTicketName(),
        createdTime: now.toDate(),
        messageGroupType: MessageGroupType.group.name,
        userIds: listUser,
        lastUpdatedTime: now.toDate(),
        lastMessage: lastMessage,
        seenMessage: {ticket.createdUser: now},
      );

      batch.set(messageGroupReference, model.toJson(), SetOptions(merge: true));
      final listToken = await getListToken(listUser);
      batch.set(
          fireStore
              .collection(FirebaseCollectionName.notification)
              .doc(messageGroupId)
              .collection(FirebaseCollectionName.itemsNotification)
              .doc(messageId),
          NotificationModel(
            id: messageId,
            title: ticket.getTicketName(),
            body: 'created_ticket_successfully'.tr,
            createdDate: now.toDate(),
            listToken: listToken,
          ).toJson(),
          SetOptions(merge: true));

      batch.set(
          messageGroupReference
              .collection(FirebaseCollectionName.messagesCollection)
              .doc(messageId),
          lastMessage.toJson(),
          SetOptions(merge: true));

      await batch.commit();
    } on FirebaseException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    } finally {
      loading.value = false;
    }
  }

  Future<MessageGroupModel?> getMessageGroupByTicketId(
      {required ticketId, Source source = Source.serverAndCache}) async {
    MessageGroupModel? model;
    try {
      final data = await fireStore
          .collection(FirebaseCollectionName.messageGroup)
          .where('ticketId', isEqualTo: ticketId)
          .get(GetOptions(source: source));
      if (data.docs.isNotEmpty) {
        model = MessageGroupModel.fromJson(data.docs.first.data());
      }
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable') {
        final data = await fireStore
            .collection(FirebaseCollectionName.messageGroup)
            .where('ticketId', isEqualTo: ticketId)
            .get();
        if (data.docs.isNotEmpty) {
          model = MessageGroupModel.fromJson(data.docs.first.data());
        }
      } else {
        throw FireStoreException(e.code, e.message, e.stackTrace);
      }
    } finally {
      loading.value = false;
    }

    return model;
  }

  Future<Ticket?> getTicketDetail(
      {required id, Source source = Source.serverAndCache}) async {
    Ticket? ticket;
    try {
      final data = await fireStore
          .collection(FirebaseCollectionName.ticket)
          .doc(id)
          .get(GetOptions(source: source));
      if (data.data() != null) {
        ticket = Ticket.fromJson(data.data()!);
      }
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable') {
        final data = await fireStore
            .collection(FirebaseCollectionName.ticket)
            .doc(id)
            .get();
        if (data.data() != null) {
          ticket = Ticket.fromJson(data.data()!);
        }
      } else {
        throw FireStoreException(e.code, e.message, e.stackTrace);
      }
    } finally {
      loading.value = false;
    }

    return ticket;
  }

  StreamSubscription? listenerHistoryTicker(
      {required ValueSetter<QuerySnapshot<Map<String, dynamic>>> valueChanged,
      required TicketPage ticketPage,
      required int page}) {
    StreamSubscription? streamSubscription;
    try {
      if (ticketPage == TicketPage.apply) {
        streamSubscription = fireStore
            .collection(FirebaseCollectionName.ticket)
            .where('peopleApply', arrayContains: user.value?.id)
            .where('status', isEqualTo: TicketStatus.created.name)
            .limit(page * kPagingSize)
            .snapshots()
            .listen((event) async {
          valueChanged(event);
        });
      } else if (ticketPage == TicketPage.current) {
        streamSubscription = fireStore
            .collection(FirebaseCollectionName.ticket)
            .where('peopleApprove', arrayContains: user.value?.id)
            .where('status', isEqualTo: TicketStatus.done.name)
            .limit(page * kPagingSize)
            .snapshots()
            .listen((event) async {
          valueChanged(event);
        });
      } else {
        streamSubscription = fireStore
            .collection(FirebaseCollectionName.ticket)
            .where('peopleApprove', arrayContains: user.value?.id)
            .where('status', whereIn: [
              TicketStatus.cancelled.name,
              TicketStatus.finish.name
            ])
            .limit(page * kPagingSize)
            .snapshots()
            .listen((event) async {
              valueChanged(event);
            });
      }
    } on FirebaseException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    }
    return streamSubscription;
  }

  StreamSubscription? listenerListTicker(
      {required ValueSetter<QuerySnapshot<Map<String, dynamic>>> valueChanged,
      bool futureData = false,
      bool queryAll = false,
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
          .where('status',
              isEqualTo: status != TicketStatus.all.name ? status : null)
          .where('startTime',
              isLessThan: queryAll
                  ? null
                  : futureData
                      ? null
                      : maxDate,
              isGreaterThan: queryAll ? null : minDate)
          .where('tagInformation',
              arrayContainsAny:
                  user.value?.typeAccount != TypeAccount.admin.name &&
                          user.value?.tagInformation.isNotEmpty == true
                      ? user.value?.tagInformation
                      : null);

      streamSubscription =
          query.limit(page * kPagingSize).snapshots().listen((event) async {
        valueChanged(event);
      });
    } on FirebaseException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    }
    return streamSubscription;
  }

  Future<void> applyTicket(Ticket model) async {
    try {
      final batch = fireStore.batch();
      final now = Timestamp.now();
      final messageGroupId = generateIdMessage(['admin', user.value!.id!]);

      final messageId = generateMd5('${now.millisecondsSinceEpoch}');
      final lastMessage = MessageModel(
        id: messageId,
        content: sprintf('user_apply_ticket'.tr,
            [user.value?.displayName, model.getTicketName()]),
        userId: user.value?.id,
        delete: false,
        ticketId: model.id,
        createdTime: now.toDate(),
        type: SendMessageType.create.name,
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
    } on FirebaseException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    }
  }

  //Message
  StreamSubscription? listenerMessageGroup(
      {required ValueSetter<QuerySnapshot<Map<String, dynamic>>> valueChanged,
      required int page,
      TypeAccount? typeAccount}) {
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
    } on FirebaseException catch (e) {
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
          .orderBy('createdTime', descending: true)
          .limit(page * kPagingSize)
          .snapshots()
          .listen((event) async {
        valueChanged(event);
      });
    } on FirebaseException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    }
    return streamSubscription;
  }

  Future<void> uploadSeenMessage({required String? messageGroup}) async {
    try {
      await fireStore
          .collection(FirebaseCollectionName.messageGroup)
          .doc(messageGroup)
          .update(
              {'seenMessage.${user.value?.id}': FieldValue.serverTimestamp()});
    } on FirebaseException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    }
  }

  Future<void> sendMessage(
      {required String content,
      required MessageGroupModel? model,
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
          .doc(model?.id);

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

      final listToken = await getListToken(model?.userIds ?? []);

      batch.set(
          fireStore
              .collection(FirebaseCollectionName.notification)
              .doc(model?.id)
              .collection(FirebaseCollectionName.itemsNotification)
              .doc(messageId),
          NotificationModel(
            id: messageId,
            title: model?.title,
            body: content,
            createdDate: now.toDate(),
            listToken: listToken,
          ).toJson(),
          SetOptions(merge: true));

      await batch.commit();
    } on FirebaseException catch (e) {
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
    } on FirebaseException catch (e) {
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
    } on FirebaseException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    } finally {
      loading.value = false;
    }
    return list;
  }

  //CountTimeTicketStart
  StreamSubscription? listenerCountTimeTicket(
      {required ValueSetter<QuerySnapshot<Map<String, dynamic>>> valueChanged,
      required String messageGroupId}) {
    StreamSubscription? streamSubscription;
    try {
      streamSubscription = fireStore
          .collection(FirebaseCollectionName.messageGroup)
          .doc(messageGroupId)
          .collection(FirebaseCollectionName.countTimeTicket)
          .snapshots()
          .listen((event) async {
        valueChanged(event);
      });
    } on FirebaseException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    }
    return streamSubscription;
  }

  Future<void> guestFinishTicket(
      {required String messageGroupId,
      required Map<String, CountTimeModel> map,
      required List userIds,
      required Ticket ticket}) async {
    try {
      final batch = fireStore.batch();
      final now = Timestamp.now();
      final messageId = generateMd5('${now.millisecondsSinceEpoch}');
      final messageIdPointCost =
          generateMd5('${now.millisecondsSinceEpoch}_point_cost');

      final lastMessage = MessageModel(
        id: messageId,
        content: 'message_group_end'.tr,
        userId: user.value?.id,
        delete: false,
        createdTime: now.toDate(),
        type: SendMessageType.create.name,
      );

      final lastMessageCostPoint = MessageModel(
        id: messageIdPointCost,
        content:
            '${'message_group_end'.tr}\n${'point_paid'.tr}${formatCurrency(ticket.calculateTotalPrice())}',
        userId: user.value?.id,
        delete: false,
        createdTime: now.toDate().add(const Duration(milliseconds: 100)),
        type: SendMessageType.pointCost.name,
      );

      final messageGroupReference = fireStore
          .collection(FirebaseCollectionName.messageGroup)
          .doc(messageGroupId);

      batch.update(messageGroupReference, {
        'lastMessage': lastMessage.toJson(),
        'lastUpdatedTime': now.toDate().toString(),
      });

      final listToken = await getListToken(userIds);

      batch.set(
          fireStore
              .collection(FirebaseCollectionName.notification)
              .doc(messageGroupId)
              .collection(FirebaseCollectionName.itemsNotification)
              .doc(messageId),
          NotificationModel(
            id: messageId,
            title: ticket.getTicketName(),
            body:
                '${'message_group_end'.tr}\n${'point_paid'.tr}${formatCurrency(ticket.calculateTotalPrice())}',
            createdDate: now.toDate(),
            listToken: listToken,
          ).toJson(),
          SetOptions(merge: true));

      batch.set(
          messageGroupReference
              .collection(FirebaseCollectionName.messagesCollection)
              .doc(messageId),
          lastMessage.toJson(),
          SetOptions(merge: true));

      batch.set(
          messageGroupReference
              .collection(FirebaseCollectionName.messagesCollection)
              .doc(messageIdPointCost),
          lastMessageCostPoint.toJson(),
          SetOptions(merge: true));

      batch.update(
          fireStore.collection(FirebaseCollectionName.ticket).doc(ticket.id), {
        'status': TicketStatus.finish.name,
      });

      for (var element in ticket.peopleApprove) {
        final model = map[element];
        batch.update(
            fireStore.collection(FirebaseCollectionName.users).doc(element), {
          'approveTickets': FieldValue.arrayRemove([ticket.id]),
        });

        if (model == null || model.endDate != null) {
          continue;
        }
        model.startDate ??= now.toDate();
        model.endDate ??= now.toDate();
        batch.update(
            messageGroupReference
                .collection(FirebaseCollectionName.countTimeTicket)
                .doc(element),
            model.toJson());

        batch.update(
            fireStore.collection(FirebaseCollectionName.users).doc(element), {
          'currentPoint': FieldValue.increment(model.point ?? 0),
          'approveTickets': FieldValue.arrayRemove([ticket.id]),
        });

        batch.set(
            fireStore
                .collection(FirebaseCollectionName.pointsHistory)
                .doc(element)
                .collection(FirebaseCollectionName.collectionPointsHistory)
                .doc(messageId),
            PointCostModel(
              id: messageId,
              point: model.point,
              createTime: now.toDate(),
              reason: PointReason.gift.name,
              status: TransferStatus.received.name,
            ).toJson(),
            SetOptions(merge: true));

        batch.update(
            fireStore
                .collection(FirebaseCollectionName.users)
                .doc(ticket.createdUser),
            {'currentPoint': FieldValue.increment(-(model.point ?? 0))});

        batch.set(
            fireStore
                .collection(FirebaseCollectionName.pointsHistory)
                .doc(ticket.createdUser)
                .collection(FirebaseCollectionName.collectionPointsHistory)
                .doc(messageId),
            PointCostModel(
              id: messageId,
              point: -(model.point ?? 0),
              createTime: now.toDate(),
              reason: PointReason.pay.name,
              status: TransferStatus.received.name,
            ).toJson(),
            SetOptions(merge: true));
      }

      await batch.commit();
    } on FirebaseException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> startCountTimeTicket({required String messageGroupId}) async {
    loading.value = true;
    try {
      final batch = fireStore.batch();
      final now = Timestamp.now();
      final messageId = generateMd5('${now.millisecondsSinceEpoch}');

      final lastMessage = MessageModel(
        id: messageId,
        content: sprintf('message_start_time'.tr, [user.value?.displayName]),
        userId: user.value?.id,
        delete: false,
        createdTime: now.toDate(),
        type: SendMessageType.create.name,
      );

      final messageGroupReference = fireStore
          .collection(FirebaseCollectionName.messageGroup)
          .doc(messageGroupId);

      batch.update(
          fireStore
              .collection(FirebaseCollectionName.messageGroup)
              .doc(messageGroupId)
              .collection(FirebaseCollectionName.countTimeTicket)
              .doc(user.value?.id),
          {'startDate': Timestamp.now()});

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
    } on FirebaseException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    } finally {
      loading.value = false;
    }
  }

  Future<void> endCountTimeTicket(
      {required String messageGroupId,
      required CountTimeModel? model,
      required Ticket? ticket}) async {
    loading.value = true;
    try {
      final batch = fireStore.batch();
      final now = Timestamp.now();
      final messageId = generateMd5('${now.millisecondsSinceEpoch}');
      final messageIdPointCost =
          generateMd5('${now.millisecondsSinceEpoch}_point_cost');
      final lastMessage = MessageModel(
        id: messageId,
        content: sprintf('message_end_time'.tr, [user.value?.displayName]),
        userId: user.value?.id,
        delete: false,
        createdTime: now.toDate(),
        type: SendMessageType.create.name,
      );

      final lastMessageCostPoint = MessageModel(
        id: messageIdPointCost,
        content: '${sprintf('message_end_time'.tr, [
              user.value?.displayName
            ])}\n${'point_paid'.tr}${formatCurrency(model?.point)}',
        userId: user.value?.id,
        delete: false,
        createdTime: now.toDate().add(const Duration(milliseconds: 100)),
        type: SendMessageType.pointCost.name,
      );

      final messageGroupReference = fireStore
          .collection(FirebaseCollectionName.messageGroup)
          .doc(messageGroupId);

      batch.update(
          fireStore
              .collection(FirebaseCollectionName.messageGroup)
              .doc(messageGroupId)
              .collection(FirebaseCollectionName.countTimeTicket)
              .doc(user.value?.id),
          {'endDate': Timestamp.now()});

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
          messageGroupReference
              .collection(FirebaseCollectionName.messagesCollection)
              .doc(messageIdPointCost),
          lastMessageCostPoint.toJson(),
          SetOptions(merge: true));

      batch.update(
          fireStore
              .collection(FirebaseCollectionName.users)
              .doc(user.value?.id),
          {'currentPoint': FieldValue.increment(model?.point ?? 0)});

      batch.set(
          fireStore
              .collection(FirebaseCollectionName.pointsHistory)
              .doc(user.value?.id)
              .collection(FirebaseCollectionName.collectionPointsHistory)
              .doc(messageId),
          PointCostModel(
            id: messageId,
            point: model?.point,
            createTime: now.toDate(),
            reason: PointReason.gift.name,
            status: TransferStatus.received.name,
          ).toJson(),
          SetOptions(merge: true));

      batch.update(
          fireStore
              .collection(FirebaseCollectionName.users)
              .doc(ticket?.createdUser),
          {'currentPoint': FieldValue.increment(-(model?.point ?? 0))});

      batch.set(
          fireStore
              .collection(FirebaseCollectionName.pointsHistory)
              .doc(ticket?.createdUser)
              .collection(FirebaseCollectionName.collectionPointsHistory)
              .doc(messageId),
          PointCostModel(
            id: messageId,
            point: -(model?.point ?? 0),
            createTime: now.toDate(),
            reason: PointReason.pay.name,
            status: TransferStatus.received.name,
          ).toJson(),
          SetOptions(merge: true));

      await batch.commit();
    } on FirebaseException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    } finally {
      loading.value = false;
    }
  }

  Future<void> closeTicket(
      {required String messageGroupId,
      required Ticket? ticket,
      required List userIds}) async {
    loading.value = true;
    try {
      final batch = fireStore.batch();
      final now = Timestamp.now();
      final messageId = generateMd5('${now.millisecondsSinceEpoch}');
      final messageIdPointCost =
          generateMd5('${now.millisecondsSinceEpoch}_point_cost');

      final lastMessage = MessageModel(
        id: messageId,
        content: 'message_group_end'.tr,
        userId: user.value?.id,
        delete: false,
        createdTime: now.toDate(),
        type: SendMessageType.create.name,
      );

      final lastMessageCostPoint = MessageModel(
        id: messageIdPointCost,
        content:
            '${'message_group_end'.tr}\n${'point_paid'.tr}${formatCurrency(ticket?.calculateTotalPrice())}',
        userId: user.value?.id,
        delete: false,
        createdTime: now.toDate().add(const Duration(milliseconds: 100)),
        type: SendMessageType.pointCost.name,
      );

      final messageGroupReference = fireStore
          .collection(FirebaseCollectionName.messageGroup)
          .doc(messageGroupId);

      batch.update(messageGroupReference, {
        'lastMessage': lastMessage.toJson(),
        'lastUpdatedTime': now.toDate().toString(),
      });

      final listToken = await getListToken(userIds);

      batch.set(
          fireStore
              .collection(FirebaseCollectionName.notification)
              .doc(messageGroupId)
              .collection(FirebaseCollectionName.itemsNotification)
              .doc(messageId),
          NotificationModel(
            id: messageId,
            title: ticket?.getTicketName(),
            body:
                '${'message_group_end'.tr}\n${'point_paid'.tr}${formatCurrency(ticket?.calculateTotalPrice())}',
            createdDate: now.toDate(),
            listToken: listToken,
          ).toJson(),
          SetOptions(merge: true));

      batch.set(
          messageGroupReference
              .collection(FirebaseCollectionName.messagesCollection)
              .doc(messageId),
          lastMessage.toJson(),
          SetOptions(merge: true));

      batch.set(
          messageGroupReference
              .collection(FirebaseCollectionName.messagesCollection)
              .doc(messageIdPointCost),
          lastMessageCostPoint.toJson(),
          SetOptions(merge: true));

      batch.update(
          fireStore.collection(FirebaseCollectionName.ticket).doc(ticket?.id), {
        'status': TicketStatus.finish.name,
      });

      for (var element in ticket!.peopleApprove) {
        batch.update(
            fireStore.collection(FirebaseCollectionName.users).doc(element), {
          'approveTickets': FieldValue.arrayRemove([ticket.id]),
        });
      }

      await batch.commit();
    } on FirebaseException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    } finally {
      loading.value = false;
    }
  }

  //Point history
  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getPointHistory(
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

      final query = fireStore
          .collection(FirebaseCollectionName.pointsHistory)
          .doc(user.value?.id)
          .collection(FirebaseCollectionName.collectionPointsHistory);
      if (lastDocument != null) {
        await query
            .orderBy('createTime', descending: true)
            .limit(kPagingSize)
            .startAfterDocument(lastDocument)
            .get()
            .then(_parseList);
      } else {
        await query
            .orderBy('createTime', descending: true)
            .limit(kPagingSize)
            .get()
            .then(_parseList);
      }
    } on FirebaseException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    } finally {
      loading.value = false;
    }
    return list;
  }

  //Add payment info
  Future<void> addPoint({required int? point}) async {
    try {
      final batch = fireStore.batch();
      final now = Timestamp.now();
      final id = generateMd5('${now.millisecondsSinceEpoch}');

      batch.update(
          fireStore
              .collection(FirebaseCollectionName.users)
              .doc(user.value?.id),
          {'currentPoint': FieldValue.increment(point ?? 0)});

      batch.set(
          fireStore
              .collection(FirebaseCollectionName.pointsHistory)
              .doc(user.value?.id)
              .collection(FirebaseCollectionName.collectionPointsHistory)
              .doc(id),
          PointCostModel(
            id: id,
            point: point,
            createTime: now.toDate(),
            reason: PointReason.buy.name,
            status: TransferStatus.received.name,
          ).toJson(),
          SetOptions(merge: true));

      await batch.commit();
    } on FirebaseException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    }
  }

  Future<void> setTransferInformation(
      {required TransferInformationModel model}) async {
    try {
      await fireStore
          .collection(FirebaseCollectionName.transferInformation)
          .doc(model.id)
          .set(model.toJson(), SetOptions(merge: true));
    } on FirebaseException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    }
  }

  Future<TransferInformationModel?> getTransferInformationDetail(
      {required String? id}) async {
    TransferInformationModel? model;
    loading.value = true;
    try {
      final doc = await fireStore
          .collection(FirebaseCollectionName.transferInformation)
          .doc(id)
          .get();
      if (doc.data() != null) {
        model = TransferInformationModel.fromJson(doc.data()!);
      }
    } on FirebaseException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    } finally {
      loading.value = false;
    }
    return model;
  }

  Future<void> setTransferRequest({required TransferRequestModel model}) async {
    final now = Timestamp.now();
    final id = generateMd5('${now.millisecondsSinceEpoch}');
    model.id = id;
    try {
      final batch = fireStore.batch();
      batch.set(
          fireStore
              .collection(FirebaseCollectionName.transferRequest)
              .doc(model.id),
          model.toJson(),
          SetOptions(merge: true));

      batch.set(
          fireStore
              .collection(FirebaseCollectionName.pointsHistory)
              .doc(user.value?.id)
              .collection(FirebaseCollectionName.collectionPointsHistory)
              .doc(id),
          PointCostModel(
            id: id,
            point: -(model.totalPrice?.toInt() ?? 0),
            createTime: now.toDate(),
            reason: PointReason.remittancePayment.name,
            status: TransferStatus.waiting.name,
          ).toJson(),
          SetOptions(merge: true));

      batch.update(
          fireStore
              .collection(FirebaseCollectionName.users)
              .doc(user.value?.id),
          {
            'currentPoint':
                FieldValue.increment(-(model.totalPrice?.toInt() ?? 0))
          });

      await batch.commit();
    } on FirebaseException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    }
  }

  StreamSubscription? listenerTransferRequest(
      {required ValueSetter<QuerySnapshot<Map<String, dynamic>>> valueChanged,
      DateTime? minDate,
      DateTime? maxDate,
      required int page,
      String? status}) {
    StreamSubscription? streamSubscription;
    try {
      final timeStampMaxDate = maxDate != null
          ? Timestamp.fromDate(
              DateTime(maxDate.year, maxDate.month, maxDate.day, 23, 59, 59))
          : null;
      final timeStampMinDate = minDate != null
          ? Timestamp.fromDate(
              DateTime(minDate.year, minDate.month, minDate.day, 0, 0, 0))
          : null;
      streamSubscription = fireStore
          .collection(FirebaseCollectionName.transferRequest)
          .where('status',
              isEqualTo: status == TransferStatus.all.name ? null : status)
          .where('createdDate',
              isLessThan: timeStampMaxDate, isGreaterThan: timeStampMinDate)
          .limit(page * kPagingSize)
          .snapshots()
          .listen((event) async {
        valueChanged(event);
      });
    } on FirebaseException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    }
    return streamSubscription;
  }

  Future<void> changeStatusListTransfer(
      {required String status,
      required List<TransferRequestModel> list}) async {
    loading.value = true;
    try {
      final batch = fireStore.batch();
      for (var element in list) {
        if (element.status == TransferStatus.cancel.name ||
            element.status == TransferStatus.alreadyTransfer.name) {
          continue;
        }
        if (element.status != status) {
          batch.update(
              fireStore
                  .collection(FirebaseCollectionName.transferRequest)
                  .doc(element.id),
              {'status': status});

          batch.update(
            fireStore
                .collection(FirebaseCollectionName.pointsHistory)
                .doc(element.createdId)
                .collection(FirebaseCollectionName.collectionPointsHistory)
                .doc(element.id),
            {'status': status},
          );

          if (status == TransferStatus.cancel.name) {
            batch.update(
                fireStore
                    .collection(FirebaseCollectionName.users)
                    .doc(element.createdId),
                {
                  'currentPoint':
                      FieldValue.increment(element.totalPrice?.toInt() ?? 0)
                });
          }
        }
      }
      await batch.commit();
    } on FirebaseException catch (e) {
      throw FireStoreException(e.code, e.message, e.stackTrace);
    } finally {
      loading.value = false;
    }
  }
}
