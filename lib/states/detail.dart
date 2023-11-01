// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print
import 'package:checkofficer/utility/app_controller.dart';
import 'package:checkofficer/utility/app_dialog.dart';
import 'package:checkofficer/utility/app_service.dart';
import 'package:checkofficer/widgets/widget_button.dart';
import 'package:checkofficer/widgets/widget_icon_button.dart';
import 'package:checkofficer/widgets/widget_image.dart';
import 'package:checkofficer/widgets/widget_image_network.dart';
import 'package:checkofficer/widgets/widget_text.dart';
import 'package:flutter/material.dart';

import 'package:checkofficer/models/guest_model.dart';
import 'package:get/get.dart';

class Detail extends StatelessWidget {
  const Detail({
    Key? key,
    required this.guestModel,
  }) : super(key: key);

  final GuestModel guestModel;

  @override
  Widget build(BuildContext context) {
    return GetX(
        init: AppController(),
        builder: (AppController appController) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                WidgetIconButton(
                  iconData: Icons.print,
                  color: appController.connectedPrinter.value
                      ? Colors.green
                      : Colors.red,
                  pressFunc: () {
                    if (!appController.connectedPrinter.value) {
                      
                      AppDialog(context: context).normalDialog(
                        title: 'Connected Printer',
                        contentWidget: appController
                                .availableBluetoothDevices.isEmpty
                            ? const WidgetText(data: 'ไม่มี Printer')
                            : SizedBox(
                                height: 100,
                                width: 250,
                                child: ListView.builder(
                                  physics: const ScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: appController
                                      .availableBluetoothDevices.length,
                                  itemBuilder: (context, index) => WidgetButton(
                                    label: appController
                                        .availableBluetoothDevices[index]
                                        .toString(),
                                    pressFunc: () {
                                      AppService()
                                          .processChoosePrinter(
                                              printerName: appController
                                                      .availableBluetoothDevices[
                                                  index])
                                          .then((value) => Get.back());
                                    },
                                  ),
                                ),
                              ),
                      );
                    }
                  },
                ),
                // WidgetIconButton(
                //   iconData: Icons.settings,
                //   pressFunc: () {
                //     Get.to(const Setting());
                //   },
                // ),
              ],
            ),
            body: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: ListView(
                children: [
                  Column(
                    children: [
                      const WidgetImage(
                        pathImage: 'images/dfend.png',
                        width: 250,
                      ),
                      const WidgetText(data: 'รายละเอียดข้อมูลการติดต่อ'),
                      WidgetText(data: 'ทะเบียนรถ : ${guestModel.carId}'),
                      WidgetText(data: 'จังหวัด : ${guestModel.province}'),
                      WidgetText(
                          data: 'ข้อมูลการติดต่อ : ${guestModel.objective}'),
                      WidgetText(data: 'เวลาเข้า : ${guestModel.checkIn}'),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(border: Border.all()),
                        width: 250,
                        height: 200,
                        child: const WidgetText(data: 'ตราประทับ'),
                      ),
                      WidgetImageNetwork(
                          urlImage:
                              'https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=${guestModel.id}'),
                      Container(
                        margin: const EdgeInsets.only(top: 16, bottom: 64),
                        child:
                            const WidgetText(data: 'Title : ข้อมูลปิดท้ายสลิป'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            floatingActionButton: appController.connectedPrinter.value
                ? WidgetButton(
                    label: 'Print',
                    pressFunc: () {
                      print('print');

                      AppService().processPrintImage(guestModel: guestModel);
                    },
                  )
                : const SizedBox(),
          );
        });
  }
}
