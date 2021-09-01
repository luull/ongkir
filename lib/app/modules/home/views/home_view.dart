import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './components/province.dart';
import './components/city.dart';
import './components/weight.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cek Ongkir Indonesia'),
        backgroundColor: Colors.red[800],
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Container(
              child: new Image.asset('assets/images/deliv.png'),
              alignment: Alignment.center,
            ),
            Provinsi(tipe: "asal"),
            Obx(
              () => controller.hiddenCityAsal.isTrue
                  ? SizedBox()
                  : Kota(idProv: controller.idProvAsal.value, tipe: "asal"),
            ),
            Provinsi(tipe: "tujuan"),
            Obx(
              () => controller.hiddenCityTujuan.isTrue
                  ? SizedBox()
                  : Kota(idProv: controller.idProvTujuan.value, tipe: "tujuan"),
            ),
            Weight(),
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: DropdownSearch<Map<String, dynamic>>(
                mode: Mode.MENU,
                showClearButton: true,
                items: [
                  {"code": "jne", "name": "JNE"},
                  {"code": "tiki", "name": "TIKI"},
                  {"code": "pos", "name": "POS INDONESIA"},
                ],
                label: "Pilih Kurir",
                onChanged: (value) {
                  if (value != null) {
                    controller.kurir.value = value['code'];
                    controller.showButton();
                    print(value['code']);
                  } else {
                    controller.kurir.value = "";
                  }
                },
                itemAsString: (item) => "${item['name']}",
                popupItemBuilder: (context, item, isSelected) => Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "${item['name']}",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            Obx(
              () => controller.hiddenButton.isTrue
                  ? SizedBox()
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          primary: Colors.red[800]),
                      onPressed: () => controller.ongkosKirim(),
                      child: Text("CEK ONGKOS"),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
