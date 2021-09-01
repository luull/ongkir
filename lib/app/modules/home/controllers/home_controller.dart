import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../courier_model.dart';

class HomeController extends GetxController {
  var hiddenCityAsal = true.obs;
  var idProvAsal = 0.obs;
  var idKotaAsal = 0.obs;
  var hiddenCityTujuan = true.obs;
  var idProvTujuan = 0.obs;
  var idKotaTujuan = 0.obs;
  var hiddenButton = true.obs;
  var kurir = ''.obs;
  double weight = 0;

  late TextEditingController weightC;
  void ongkosKirim() async {
    Uri url = Uri.parse("https://api.rajaongkir.com/starter/cost");
    try {
      final response = await http.post(url, headers: {
        "content-type": "application/x-www-form-urlencoded",
        "key": "17d64d0c28207f3e337a5011177545fd",
      }, body: {
        "origin": "$idKotaAsal",
        "destination": "$idKotaTujuan",
        "weight": "$weight",
        "courier": "$kurir"
      });
      var data = (json.decode(response.body) as Map<String, dynamic>);
      var results = data['rajaongkir']['results'] as List<dynamic>;

      var listCourier = Courier.fromJsonList(results);
      var courier = listCourier[0];
      print(listCourier[0]);
      Get.bottomSheet(
        Container(
          height: 300,
          color: Colors.white,
          child: Center(
            child: ListView(
              padding: EdgeInsets.all(20),
              children: courier.costs!
                  .map(
                    (e) => ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      tileColor: Colors.grey,
                      title: Text("${e.service}"),
                      subtitle:
                          Text("${e.description} \n ${e.cost![0].etd} Hari"),
                      trailing: Text(
                        "Rp.${e.cost![0].value}",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      );
    } catch (err) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: err.toString(),
      );
    }
  }

  void showButton() {
    if (idKotaAsal != 0 && idKotaTujuan != 0 && weight > 0 && kurir != '') {
      hiddenButton.value = false;
    } else {
      hiddenButton.value = true;
    }
  }

  void changeWeight(String value) {
    weight = double.tryParse(value) ?? 0;
    print(weight);
  }

  @override
  void onInit() {
    weightC = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    weightC.dispose();
    super.onClose();
  }
}
