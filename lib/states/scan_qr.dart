// ignore_for_file: avoid_print

import 'package:checkofficer/states/detail_after_scan.dart';
import 'package:checkofficer/utility/app_controller.dart';
import 'package:checkofficer/utility/app_dialog.dart';
import 'package:checkofficer/utility/app_service.dart';
import 'package:checkofficer/widgets/widget_button.dart';
import 'package:checkofficer/widgets/widget_image.dart';
import 'package:checkofficer/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan/scan.dart';

class ScanQr extends StatefulWidget {
  const ScanQr({super.key});

  @override
  State<ScanQr> createState() => _ScanQrState();
}

class _ScanQrState extends State<ScanQr> {
  ScanController scanController = ScanController();

  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    scanController.pause();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ScanView(
        controller: scanController,
        onCapture: (data) {
          print('data ---> $data');

          AppService().processFindGuestModel(dataScan: data).then((value) {
            AppDialog(context: context).normalDialog(
                title: 'Check Out Success',
                iconWidget: const WidgetImage(
                  pathImage: 'images/logo_tswg.png',
                  width: 150,
                ),
                contentWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const WidgetText(data: 'รายละเอียดข้อมูลการติดต่อ'),
                    WidgetText(
                        data:
                            'ทะเบียนรถ : ${appController.qrGuestModels.last.carId}'),
                    WidgetText(
                        data:
                            'จังหวัด : ${appController.qrGuestModels.last.province}'),
                    WidgetText(
                        data:
                            'ข้อมูลการติดต่อ : ${appController.qrGuestModels.last.objective}'),
                    WidgetText(
                        data:
                            'เวลาเข้า : ${appController.qrGuestModels.last.checkIn}'),
                    WidgetText(
                        data:
                            'เวลาออก : ${appController.qrGuestModels.last.checkOut}'),
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child:
                          const WidgetText(data: ''),
                    ),
                  ],
                ),
                actionWidget: WidgetButton(
                  label: 'OK',
                  pressFunc: () {
                    Get.back();
                    Get.back();
                  },
                ));
          });

          // Get.back();
          // Get.offAll(DetailAfterScan(qr: data));
        },
      ),
    );
  }
}
