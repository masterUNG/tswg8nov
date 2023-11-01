import 'dart:io';

import 'package:checkofficer/models/guest_model.dart';
import 'package:checkofficer/models/objective_model.dart';
import 'package:checkofficer/models/province_model.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  RxList<ProvinceModel> provinceModels = <ProvinceModel>[].obs;
  RxList<String?> chooseProvinces = <String?>[null].obs;
  RxList<ObjectiveModel> objectiveModels = <ObjectiveModel>[].obs;
  RxList<String?> chooseObjectives = <String?>[null].obs;
  RxBool displayOther = false.obs;
  RxList<File> avatarFiles = <File>[].obs;
  RxList<File> carFiles = <File>[].obs;
  RxList<File> cardFiles = <File>[].obs;
  RxList<GuestModel> guestModels = <GuestModel>[].obs;

  RxBool connectedPrinter = false.obs;
  RxList<dynamic> availableBluetoothDevices = <dynamic>[].obs;

  RxList<GuestModel> qrGuestModels = <GuestModel>[].obs;
}
