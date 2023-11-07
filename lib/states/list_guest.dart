// ignore_for_file: avoid_print

import 'package:checkofficer/states/add_guest.dart';
import 'package:checkofficer/states/detail.dart';
import 'package:checkofficer/states/scan_qr.dart';
import 'package:checkofficer/utility/app_constant.dart';
import 'package:checkofficer/utility/app_controller.dart';
import 'package:checkofficer/utility/app_service.dart';
import 'package:checkofficer/widgets/widget_button.dart';
import 'package:checkofficer/widgets/widget_icon_button.dart';
import 'package:checkofficer/widgets/widget_image_network.dart';
import 'package:checkofficer/widgets/widget_text.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListGuest extends StatefulWidget {
  const ListGuest({super.key});

  @override
  State<ListGuest> createState() => _ListGuestState();
}

class _ListGuestState extends State<ListGuest> {
  AppController controller = Get.put(AppController());
  EasyRefreshController? easyRefreshController;

  int timeLoad = 1;

  @override
  void initState() {
    super.initState();

    easyRefreshController = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );

    AppService().readAllGuest();
    AppService().proccessGetBluetooth();
  }

  @override
  Widget build(BuildContext context) {
    return GetX(
        init: AppController(),
        builder: (AppController appController) {
          // print(
          //     '###  availableBluetooth ----> ${appController.availableBluetoothDevices.length}');
          // print('connectedPrinter ---> ${appController.connectedPrinter}');

          print('##7nov indexApi ---> ${appController.indexApi}');

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const WidgetText(data: 'รายการทั้งหมด'),
              centerTitle: true,
              actions: [
                WidgetIconButton(
                  iconData: Icons.qr_code,
                  pressFunc: () async {
                    Get.to(const ScanQr());
                  },
                ),
              ],
            ),
            floatingActionButton: WidgetButton(
              label: 'เพิ่มรายการ',
              pressFunc: () {
                Get.to(const AddGuest())!.then((value) {
                  AppService().readAllGuest();
                });
              },
            ),
            body: appController.guestModels.isEmpty
                ? const SizedBox()
                : EasyRefresh(
                    onRefresh: () {
                      AppService().readAllGuest().then((value) {
                        easyRefreshController!.finishRefresh();
                      });
                    },
                    onLoad: () async {
                      await Future.delayed(const Duration(seconds: 3))
                          .then((value) {
                        timeLoad++;
                        easyRefreshController!.finishLoad();
                        setState(() {});
                      });
                    },
                    child: ListView.builder(
                      // reverse: true,
                      itemCount: AppConstant.amountLoad * timeLoad >= appController.guestModels.length ?  appController.guestModels.length  : AppConstant.amountLoad * timeLoad ,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          print(
                              'detail ---> ${appController.guestModels[index].toMap()}');
                          Get.to(Detail(
                              guestModel: appController.guestModels[index]));
                        },
                        child: Card(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: AppConstant().borderBox(),
                                margin: const EdgeInsets.all(8.0),
                                child: WidgetImageNetwork(
                                  urlImage:
                                      appController.listUrlImages[index].last,
                                  width: 150,
                                  height: 150,
                                ),
                              ),
                              SizedBox(
                                width: 180,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const WidgetText(data: 'Check In'),
                                    WidgetText(
                                      data: AppService().displayDateTime(
                                          dateTimeString: appController
                                              .guestModels[index].checkIn),
                                      textStyle: AppConstant()
                                          .h2Style(color: Colors.red, size: 16),
                                    ),
                                    const WidgetText(data: 'Check Out'),
                                    WidgetText(
                                      data: appController.guestModels[index]
                                              .checkOut.isEmpty
                                          ? '-'
                                          : AppService().displayDateTime(
                                              dateTimeString: appController
                                                  .guestModels[index].checkOut),
                                      textStyle: AppConstant().h2Style(
                                          color: Colors.green, size: 16),
                                    ),
                                    WidgetText(
                                        data: appController
                                            .guestModels[index].nameAndSur),
                                    WidgetText(
                                        data: appController
                                            .guestModels[index].carId),
                                    WidgetText(
                                        data: appController
                                            .guestModels[index].province),
                                    WidgetText(
                                        data: appController
                                            .guestModels[index].objective),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
          );
        });
  }
}
