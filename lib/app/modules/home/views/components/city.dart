import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../controllers/home_controller.dart';
import '../../city_model.dart';

class Kota extends GetView<HomeController> {
  const Kota({Key? key, required this.idProv, required this.tipe})
      : super(key: key);
  final int idProv;
  final String tipe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: DropdownSearch<City>(
        showClearButton: true,
        label: tipe == "asal"
            ? "Kota / Kabupaten Asal"
            : "Kota / Kabupaten Tujuan",
        onFind: (String filter) async {
          Uri url = Uri.parse(
              "https://api.rajaongkir.com/starter/city?province=$idProv");

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
            var listCity = data['rajaongkir']['results'] as List<dynamic>;
            var models = City.fromJsonList(listCity);
            return models;
          } catch (err) {
            return List<City>.empty();
          }
        },
        onChanged: (city) {
          if (city != null) {
            if (tipe == "asal") {
              controller.idKotaAsal.value = int.parse(city.cityId!);
            } else {
              controller.idKotaTujuan.value = int.parse(city.cityId!);
            }
            print(city.cityName);
          } else {
            if (tipe == "asal") {
              print("Belum memilih Kota Asal");
              controller.idKotaAsal.value = 0;
            } else {}
            print("Belum memilih Kota Tujuan");
            controller.idKotaTujuan.value = 0;
          }
          controller.showButton();
        },
        popupItemBuilder: (context, item, inSelected) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
            child: Text("${item.type} ${item.cityName}"),
          );
        },
        showSearchBox: true,
        itemAsString: (item) => item.cityName!,
      ),
    );
  }
}
