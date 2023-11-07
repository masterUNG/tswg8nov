// ignore_for_file: avoid_print

import 'package:bluetooth_thermal_printer/bluetooth_thermal_printer.dart';
import 'package:checkofficer/widgets/widget_button.dart';
import 'package:checkofficer/widgets/widget_text_button.dart';
import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool connected = false;
  var availableBluetoothDevices = [];

  @override
  void initState() {
    super.initState();
    getBluetooth();
  }

  Future<void> getBluetooth() async {
    await BluetoothThermalPrinter.getBluetooths.then((value) {
      if (value != null) {
        setState(() {
          availableBluetoothDevices.addAll(value);
        });
      }
      print(
          'avilableBluetoothDevices.length ---> ${availableBluetoothDevices.length}');
    });
  }

  Future<void> setConnected({required String mac}) async {
    await BluetoothThermalPrinter.connect(mac).then((value) {
      print('value at setConnected ---> $value');
      if (value.toString() == 'true') {
        setState(() {
          connected = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: Column(
        children: [
          choosePrinter(),
          connected
              ? WidgetButton(
                  label: 'Print',
                  pressFunc: () async {
                    await BluetoothThermalPrinter.writeText("TSWG\n"
                        "THWG System\n"
                        "THWG Entance-Exit System\n"
                        "THWG Solution \n\n\n");
                  },
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  Widget choosePrinter() {
    return availableBluetoothDevices.isEmpty
        ? const SizedBox()
        : ListView.builder(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: availableBluetoothDevices.length,
            itemBuilder: (context, index) => WidgetTextButton(
              label: availableBluetoothDevices[index],
              pressFunc: () {
                List<String> strings =
                    availableBluetoothDevices[index].toString().split('#');
                setConnected(mac: strings.last);
              },
            ),
          );
  }
}
