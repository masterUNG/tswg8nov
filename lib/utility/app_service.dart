// ignore_for_file: avoid_print

import 'dart:convert';

import 'dart:io';
import 'dart:math';

import 'package:bluetooth_thermal_printer/bluetooth_thermal_printer.dart';
import 'package:checkofficer/models/guest_model.dart';
import 'package:checkofficer/models/objective_model.dart';
import 'package:checkofficer/models/province_model.dart';
import 'package:checkofficer/utility/app_constant.dart';
import 'package:checkofficer/utility/app_controller.dart';
import 'package:checkofficer/utility/app_snackbar.dart';
import 'package:checkofficer/widgets/widget_text.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:image/image.dart' as image;

import 'package:image_picker/image_picker.dart';
import 'package:screenshot/screenshot.dart';

class AppService {
  AppController appController = Get.put(AppController());

  Future<void> processPrint(
      {required String name, required String phone}) async {
    await BluetoothThermalPrinter.writeText('Test Print\n$name\n$phone\n\n\n');
  }

  Future<void> processPrintImage({required GuestModel guestModel}) async {
    CapabilityProfile profile = await CapabilityProfile.load();
    var generator = Generator(PaperSize.mm80, profile);

    List<int> bytes = <int>[];

    ScreenshotController screenshotController = ScreenshotController();
    screenshotController
        .captureFromWidget(
      SizedBox(
        width: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const ImageIcon(
              AssetImage('images/dfend.png'),
              size: 96,
            ),
            WidgetText(
              data: 'รายละเอียดข้อมูลการติดต่อ',
              textStyle: AppConstant().h3Style(color: Colors.black, size: 8),
            ),
            WidgetText(
              data: 'ทะเบียนรถ : ${guestModel.carId}',
              textStyle: AppConstant().h3Style(color: Colors.black, size: 8),
            ),
            WidgetText(
              data: 'จังหวัด : ${guestModel.province}',
              textStyle: AppConstant().h3Style(color: Colors.black, size: 8),
            ),
            WidgetText(
              data: 'ข้อมูลการติดต่อ : ${guestModel.objective}',
              textStyle: AppConstant().h3Style(color: Colors.black, size: 8),
            ),
            WidgetText(
              data: 'เวลาเข้า : ${guestModel.checkIn}',
              textStyle: AppConstant().h3Style(color: Colors.black, size: 8),
            ),
            Divider(),
            Divider(),
            WidgetText(
              data: 'หมายเหตุ',
              textStyle: AppConstant().h3Style(color: Colors.black, size: 8),
            ),
            Divider(),
            Divider(),
            Divider(),
            Divider(
              color: Colors.black,
            ),
            Divider(),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              width: 120,
              height: 80,
              alignment: Alignment.center,
              decoration: BoxDecoration(border: Border.all()),
              child: WidgetText(
                data: 'ตราประทับ',
                textStyle: AppConstant().h3Style(color: Colors.black, size: 8),
              ),
            ),
          ],
        ),
      ),
    )
        .then((value) async {
      final myImage = image.decodeImage(value);
      bytes += generator.image(myImage!);

      bytes += generator.qrcode(guestModel.id);

      bytes += generator.text('\n\n\n\n\n');

      await BluetoothThermalPrinter.writeBytes(bytes);
    });
  }

  Future<void> processChoosePrinter({required String printerName}) async {
    print('printName ---> $printerName');
    var macs = printerName.split('#');
    print('mas.last----> ${macs.last}');
    try {
      await BluetoothThermalPrinter.connect(macs.last).then((value) {
        print('value at processChoosePrinter ---> $value');
        if (value.toString() == 'true') {
          appController.connectedPrinter.value = true;
        }
      });
    } on Exception catch (e) {
      print('onError -----> $e');
    }
  }

  Future<void> proccessGetBluetooth() async {
    await BluetoothThermalPrinter.getBluetooths.then((value) {
      if (value != null) {
        appController.availableBluetoothDevices.addAll(value);
      }
    });
  }

  Future<void> readAllGuest() async {
    String urlApi = 'https://tswg.site/app/getAllGuest.php';

    if (appController.guestModels.isNotEmpty) {
      appController.guestModels.clear();
    }

    await dio.Dio().get(urlApi).then((value) {
      for (var element in json.decode(value.data)) {
        GuestModel model = GuestModel.fromMap(element);
        appController.guestModels.add(model);
      }
    });
  }

  Future<void> processAddGuest(
      {required String nameAndSurname,
      required String phone,
      required String carId,
      required String province,
      required String objective}) async {
    String urlApiUpload = 'https://tswg.site/app/saveFile.php';

    var files = <File>[];
    if (appController.avatarFiles.isNotEmpty) {
      files.add(appController.avatarFiles.last);
    }

    if (appController.carFiles.isNotEmpty) {
      files.add(appController.carFiles.last);
    }

    files.add(appController.cardFiles.last);

    var urlImages = <String>[
      '',
      '',
      '',
    ];
    int index = 0;

    for (var element in files) {
      String nameFile = 'image${Random().nextInt(1000000)}.jpg';
      Map<String, dynamic> map = {};
      map['file'] =
          await dio.MultipartFile.fromFile(element.path, filename: nameFile);
      dio.FormData formData = dio.FormData.fromMap(map);
      await dio.Dio().post(urlApiUpload, data: formData).then((value) {
        print('upload $nameFile success');
        // urlImages.add(
        //     'https://www.androidthai.in.th/fluttertraining/checeOffocerUng/image/$nameFile');
        urlImages[index] = 'https://tswg.site/app/image/$nameFile';
      });
      index++;
    }

    if (urlImages.isNotEmpty) {
      String urlApiInsertGuest =
          'https://tswg.site/app/insertGuest.php?isAdd=true&nameAndSur=$nameAndSurname&phone=$phone&carId=$carId&province=$province&objective=$objective&urlImage1=${urlImages[0]}&urlImage2=${urlImages[1]}&urlImage3=${urlImages[2]}&checkIn=${DateTime.now().toString()}';
      await dio.Dio().get(urlApiInsertGuest).then((value) {
        Get.back();
        AppSnackBar(
                title: 'Add Guest Success', message: 'Thankyou for Add Guest')
            .normalSnackBar();
      });
    }
  }

  Future<File> processTakePhoto() async {
    var result = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxWidth: 800, maxHeight: 800);
    File file = File(result!.path);
    return file;
  }

  Future<void> readAllObjective() async {
    String urlApi = 'https://tswg.site/app/getAllObjectiveUng.php';
    await dio.Dio().get(urlApi).then((value) {
      for (var element in json.decode(value.data)) {
        ObjectiveModel model = ObjectiveModel.fromMap(element);
        appController.objectiveModels.add(model);
      }
    });
  }

  Future<void> readAllProvince() async {
    String urlApi = 'https://www.androidthai.in.th/flutter/getAllprovinces.php';
    await dio.Dio().get(urlApi).then((value) {
      for (var element in json.decode(value.data)) {
        ProvinceModel model = ProvinceModel.fromMap(element);
        appController.provinceModels.add(model);
      }
    });
  }

  Future<void> processFindGuestModel({required String dataScan}) async {
    String urlApiEdit =
        'https://tswg.site/app/editCheckOutWhereId.php?isAdd=true&id=$dataScan&checkOut=${DateTime.now().toString()}';

    await Dio().get(urlApiEdit).then((value) async {
      String url =
          'https://tswg.site/app/getGuestWhereId.php?isAdd=true&id=$dataScan';

      await Dio().get(url).then((value) {
        if (value.toString() != 'null') {
          for (var element in json.decode(value.data)) {
            // guestModel = GuestModel.fromMap(element);
            // setState(() {});
            GuestModel guestModel = GuestModel.fromMap(element);
            appController.qrGuestModels.add(guestModel);
          }
        }
      });
    });
  }
}
