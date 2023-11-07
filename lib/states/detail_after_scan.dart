// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:checkofficer/states/list_guest.dart';
import 'package:checkofficer/widgets/widget_icon_button.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:checkofficer/models/guest_model.dart';
import 'package:checkofficer/utility/app_constant.dart';
import 'package:checkofficer/widgets/widget_image.dart';
import 'package:checkofficer/widgets/widget_text.dart';
import 'package:get/get.dart';

class DetailAfterScan extends StatefulWidget {
  const DetailAfterScan({
    Key? key,
    required this.qr,
  }) : super(key: key);

  final String qr;

  @override
  State<DetailAfterScan> createState() => _DetailAfterScanState();
}

class _DetailAfterScanState extends State<DetailAfterScan> {
  GuestModel? guestModel;

  @override
  void initState() {
    super.initState();
    processCheckOut();
  }

  Future<void> processCheckOut() async {
    String url =
        'https://tswg.site/app/editCheckOutWhereId.php?isAdd=true&id=${widget.qr}&checkOut=${DateTime.now().toString()}';

    await Dio().get(url).then((value) {
      findGuestModel();
    });
  }

  Future<void> findGuestModel() async {
    String url =
        'https://tswg.site/app/getGuestWhereId.php?isAdd=true&id=${widget.qr}';
    await Dio().get(url).then((value) {
      if (value.toString() != 'null') {
        for (var element in json.decode(value.data)) {
          guestModel = GuestModel.fromMap(element);
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(),
      body: guestModel == null
          ? const SizedBox()
          : SizedBox(
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
                      WidgetText(data: 'ทะเบียนรถ : ${guestModel!.carId}'),
                      WidgetText(data: 'จังหวัด : ${guestModel!.province}'),
                      WidgetText(
                          data: 'ข้อมูลการติดต่อ : ${guestModel!.objective}'),
                      WidgetText(data: 'เวลาเข้า : ${guestModel!.checkIn}'),
                      WidgetText(data: 'เวลาออก : ${guestModel!.checkOut}'),
                      Container(
                        margin: const EdgeInsets.only(top: 16, bottom: 64),
                        child: const WidgetText(data: ''),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  AppBar mainAppBar() {
    return AppBar(
      centerTitle: true,
      title: WidgetText(
        data: 'D-FREND Solution',
        textStyle: AppConstant().h2Style(),
      ),
      leading: WidgetIconButton(
        iconData: Icons.arrow_back,
        pressFunc: () {
          Get.offAll(const ListGuest());
        },
      ),
    );
  }
}
