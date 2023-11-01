// ignore_for_file: avoid_print, sort_child_properties_last

import 'package:checkofficer/utility/app_constant.dart';
import 'package:checkofficer/utility/app_controller.dart';
import 'package:checkofficer/utility/app_service.dart';
import 'package:checkofficer/utility/app_snackbar.dart';
import 'package:checkofficer/widgets/widget_button.dart';
import 'package:checkofficer/widgets/widget_form.dart';
import 'package:checkofficer/widgets/widget_icon_button.dart';
import 'package:checkofficer/widgets/widget_image.dart';
import 'package:checkofficer/widgets/widget_image_file.dart';
import 'package:checkofficer/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddGuest extends StatefulWidget {
  const AddGuest({super.key});

  @override
  State<AddGuest> createState() => _AddGuestState();
}

class _AddGuestState extends State<AddGuest> {
  AppController controller = Get.put(AppController());
  String? nameAndSurname, carId, phone, otherObjective;

  @override
  void initState() {
    super.initState();
    AppService().readAllProvince();
    AppService().readAllObjective();

    if (controller.cardFiles.isNotEmpty) {
      controller.cardFiles.clear();
    }
    if (controller.avatarFiles.isNotEmpty) {
      controller.avatarFiles.clear();
    }
    if (controller.carFiles.isNotEmpty) {
      controller.carFiles.clear();
    }
    if (controller.totalFiles.isNotEmpty) {
      controller.totalFiles.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const WidgetText(data: 'Add Guest'),
        centerTitle: true,
        actions: [
          WidgetIconButton(
            iconData: Icons.save,
            pressFunc: () {
              processSave();
            },
            color: Theme.of(context).primaryColor,
          )
        ],
      ),
      body: GetX(
          init: AppController(),
          builder: (AppController appController) {
            print('avatarFiles --> ${appController.avatarFiles.length}');
            return ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    imageAvatar(appController),
                    imageCar(appController),
                    imageCard(appController),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WidgetForm(
                      changeFunc: (p0) {
                        nameAndSurname = p0.trim();
                      },
                      labelWidget: const WidgetText(data: 'ชื่อ นามสกุล'),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WidgetForm(
                      changeFunc: (p0) {
                        phone = p0.trim();
                      },
                      labelWidget: const WidgetText(data: 'เบอร์โทรศัพย์'),
                      textInputType: TextInputType.phone,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WidgetForm(
                      changeFunc: (p0) {
                        carId = p0.trim();
                      },
                      labelWidget: const WidgetText(data: 'ทะเบียนรถ'),
                    ),
                  ],
                ),
                appController.provinceModels.isEmpty
                    ? const SizedBox()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            margin: const EdgeInsets.only(top: 16),
                            decoration: AppConstant().borderBox(),
                            width: 250,
                            child: DropdownButton(
                              underline: const SizedBox(),
                              isExpanded: true,
                              items: appController.provinceModels
                                  .map(
                                    (element) => DropdownMenuItem(
                                      child: WidgetText(data: element.name_th),
                                      value: element.name_th,
                                    ),
                                  )
                                  .toList(),
                              value: appController.chooseProvinces.last,
                              hint: const WidgetText(data: 'โปรดเลือกจังหวัด'),
                              onChanged: (value) {
                                appController.chooseProvinces.add(value);
                              },
                            ),
                          ),
                        ],
                      ),
                appController.objectiveModels.isEmpty
                    ? const SizedBox()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            margin: const EdgeInsets.only(top: 16),
                            decoration: AppConstant().borderBox(),
                            width: 250,
                            child: DropdownButton(
                              isExpanded: true,
                              underline: const SizedBox(),
                              items: appController.objectiveModels
                                  .map(
                                    (element) => DropdownMenuItem(
                                      child:
                                          WidgetText(data: element.objective),
                                      value: element.objective,
                                    ),
                                  )
                                  .toList(),
                              value: appController.chooseObjectives.last,
                              hint: const WidgetText(
                                  data: 'โปรดเลือกจุดประส่งค์'),
                              onChanged: (value) {
                                appController.chooseObjectives.add(value);

                                if (value.toString() == 'อื่นๆ') {
                                  appController.displayOther.value = true;
                                } else {
                                  appController.displayOther.value = false;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                appController.displayOther.value
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          WidgetForm(
                            changeFunc: (p0) {
                              otherObjective = p0.trim();
                            },
                            labelWidget: const WidgetText(data: 'อื่นๆ'),
                          ),
                        ],
                      )
                    : const SizedBox(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 250,
                      margin: const EdgeInsets.only(top: 16, bottom: 32),
                      child: WidgetButton(
                        label: 'บันทึก และ พิมพ์',
                        pressFunc: () {
                          processSave();
                        },
                      ),
                    ),
                  ],
                )
              ],
            );
          }),
    );
  }

  StatelessWidget imageCard(AppController appController) {
    return appController.cardFiles.isEmpty
        ? Container(
            decoration: AppConstant().borderBox(),
            child: WidgetImage(
              pathImage: 'images/id_card.png',
              width: 80,
              height: 80,
              tapFunc: () async {
                await AppService().processTakePhoto().then((value) {
                  appController.cardFiles.add(value);
                });
              },
            ),
          )
        : WidgetImageFile(
            file: appController.cardFiles.last,
            size: 80,
          );
  }

  StatelessWidget imageCar(AppController appController) {
    return appController.carFiles.isEmpty
        ? Container(
            decoration: AppConstant().borderBox(),
            child: WidgetImage(
              pathImage: 'images/id_car.png',
              width: 80,
              height: 80,
              tapFunc: () async {
                await AppService().processTakePhoto().then((value) {
                  appController.carFiles.add(value);
                });
              },
            ),
          )
        : WidgetImageFile(
            file: appController.carFiles.last,
            size: 80,
          );
  }

  Widget imageAvatar(AppController appController) {
    return appController.avatarFiles.isEmpty
        ? Container(
            decoration: AppConstant().borderBox(),
            child: WidgetImage(
              pathImage: 'images/avatar1.png',
              width: 80,
              height: 80,
              tapFunc: () async {
                await AppService().processTakePhoto().then((value) {
                  appController.avatarFiles.add(value);
                });
              },
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetImageFile(
                file: appController.avatarFiles.last,
                size: 80,
              ),
            ],
          );
  }

  void processSave() {
    if (controller.totalFiles.isEmpty) {
      AppSnackBar(title: 'ไม่มีภาพ ?', message: 'กรุณาถ่ายภาพ').errorSnackBar();
    } else {
      //process Insert
      AppService().processAddGuest(
          nameAndSurname: nameAndSurname ?? '',
          phone: phone ?? '',
          carId: carId ?? '',
          province: controller.chooseProvinces.last == null
              ? ''
              : controller.chooseProvinces.last!,
          objective: controller.chooseObjectives.last == null
              ? ''
              : controller.chooseObjectives.last!);
    }
  }
}
