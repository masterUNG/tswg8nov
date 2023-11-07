// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:checkofficer/models/user_model.dart';
import 'package:checkofficer/states/list_guest.dart';
import 'package:checkofficer/utility/app_constant.dart';
import 'package:checkofficer/utility/app_controller.dart';
import 'package:checkofficer/utility/app_snackbar.dart';
import 'package:checkofficer/widgets/widget_button.dart';
import 'package:checkofficer/widgets/widget_form.dart';
import 'package:checkofficer/widgets/widget_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Authen extends StatefulWidget {
  const Authen({super.key});

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  String? user, password;

  AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppConstant().imageBox(),
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 250,
                    margin: const EdgeInsets.only(top: 64),
                    child: const WidgetImage(
                      pathImage: 'images/logo_tswg.png',
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WidgetForm(
                    hint: 'User :',
                    suffixWidget: const Icon(Icons.person_outline),
                    changeFunc: (p0) {
                      user = p0.trim();
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WidgetForm(
                    hint: 'Password :',
                    suffixWidget: const Icon(Icons.lock_outline),
                    changeFunc: (p0) {
                      password = p0.trim();
                    },
                    obsecu: true,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    width: 250,
                    child: WidgetButton(
                      label: 'Login',
                      pressFunc: () async {
                        if ((user?.isEmpty ?? true) ||
                            (password?.isEmpty ?? true)) {
                          AppSnackBar(
                                  title: 'กรอกไม่ครบ',
                                  message: 'กรุณากรอกให้ครบทุกช่อง ด้วยคะ')
                              .errorSnackBar();
                        } else {
                          String urlApi =
                              'https://tswg.site/app/getUserWhereUser.php?isAdd=true&user=$user';

                          print('urlApi ---> $urlApi');
                          await Dio().get(urlApi).then((value) {
                            print('value ---> $value');

                            if (value.toString() == 'null') {
                              AppSnackBar(
                                      title: 'User False',
                                      message:
                                          'ไม่มี $user คนนี้ใน ฐานข้อมูลเรา')
                                  .errorSnackBar();
                            } else {
                              for (var element in json.decode(value.data)) {
                                UserModel model = UserModel.fromMap(element);
                                print('model string ===> ${model.toString()}');
                                if (password == model.password) {
                                  //Password true

                                  appController.indexApi.value =
                                      int.parse(model.api.trim());

                                  AppSnackBar(
                                          title: 'Welcome',
                                          message:
                                              'Welcome ${model.name} to App')
                                      .normalSnackBar();
                                  Get.offAll(const ListGuest());
                                } else {
                                  AppSnackBar(
                                          title: 'Password False',
                                          message: 'กรุณาลองใหม่ Passoword ผิด')
                                      .errorSnackBar();
                                }
                              }
                            }
                          });
                        }
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
