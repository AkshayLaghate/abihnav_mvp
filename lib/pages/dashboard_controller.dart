import 'package:abihnav_mvp/model/part_model.dart';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class DashboardController extends GetxController {
  RxList<PartModel> partList = <PartModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    loadSheet();
    super.onInit();
  }

  loadSheet() async {
    partList.clear();
    ByteData data = await rootBundle.load('assets/SampleSheet.xlsx');
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        bool add = false;
        String name = '';
        String serial = '';
        String brand = '';
        for (var cell in row) {
          if (cell?.columnIndex == 0 && cell!.rowIndex > 0) {
            print('${cell?.value} ');
            add = true;
            serial = cell.value.toString();
          }
          if (cell?.columnIndex == 1 && cell!.rowIndex > 0) {
            print('${cell?.value} ');
            add = true;
            name = cell.value.toString();
          }
          if (cell?.columnIndex == 2 && cell!.rowIndex > 0) {
            print('${cell?.value}');
            add = true;
            brand = cell.value.toString();
          }
        }
        if (add) {
          partList.add(
              PartModel(partName: name, modelNumber: serial, brand: brand));
          add = false;
        }
      }
    }
  }
}
