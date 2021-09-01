import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../controllers/home_controller.dart';
import '../../province_model.dart';

class Provinsi extends GetView<HomeController> {
  const Provinsi({Key? key, required this.tipe}) : super(key: key);
  final String tipe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: DropdownSearch<Province>(
        label: tipe == "asal" ? "Provinsi Asal" : "Provinsi Tujuan",
        showClearButton: true,
        onFind: (String filter) async {
          Uri url = Uri.parse("https://api.rajaongkir.com/starter/province");

          try {
            final response = await http.get(
              url,
              headers: {"key": "17d64d0c28207f3e337a5011177545fd"},
            );

            var data = json.decode(response.body) as Map<String, dynamic>;

            var status = data['rajaongkir']['status']['code'];
            if (status != 200) {
              throw data['rajaongkir']['status']['description'];
            }
            var listProvince = data['rajaongkir']['results'] as List<dynamic>;
            var models = Province.fromJsonList(listProvince);
            return models;
          } catch (err) {
            return List<Province>.empty();
          }
        },
        onChanged: (prov) {
          if (prov != null) {
            print(prov.province);
            if (tipe == "asal") {
              controller.hiddenCityAsal.value = false;
              controller.idProvAsal.value = int.parse(prov.provinceId!);
            } else {
              controller.hiddenCityTujuan.value = false;
              controller.idProvTujuan.value = int.parse(prov.provinceId!);
            }
          } else {
            print("Belum memilih provinsi");
            if (tipe == "asal") {
              controller.hiddenCityAsal.value = true;
              controller.idProvAsal.value = 0;
            } else {
              controller.hiddenCityTujuan.value = true;
              controller.idProvTujuan.value = 0;
            }
          }
          controller.showButton();
        },
        popupItemBuilder: (context, item, inSelected) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
            child: Text("${item.province}"),
          );
        },
        showSearchBox: true,
        itemAsString: (item) => item.province!,
      ),
    );
  }
}
