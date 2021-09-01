import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';

class Weight extends GetView<HomeController> {
  const Weight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              autocorrect: false,
              controller: controller.weightC,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: "Berat",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => controller.changeWeight(value),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Container(
            padding: EdgeInsets.only(top: 20),
            width: 60,
            height: 55,
            color: Colors.grey,
            child: Text(
              "gram",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
