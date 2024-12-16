import 'package:abihnav_mvp/pages/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardController dashboardController = Get.put(DashboardController());
    final _focusNode = FocusNode();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Abhinav POC",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        shadowColor: Colors.grey,
        backgroundColor: const Color.fromARGB(255, 65, 83, 93),
        elevation: 8,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.settings,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SearchBar(
                focusNode: _focusNode,
                onTapOutside: (event) {
                  _focusNode.unfocus();
                },
                leading: Icon(Icons.search),
                hintText: 'Search for any item',
                backgroundColor: WidgetStateProperty.all(Colors.white),
                onChanged: (value) {
                  dashboardController.partList.retainWhere((part) => part
                      .partName
                      .toLowerCase()
                      .contains(value.toLowerCase()));
                  if (value.isEmpty) {
                    dashboardController.loadSheet();
                  }
                },
              ),
              SizedBox(
                height: 12,
              ),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: dashboardController.partList.length,
                    itemBuilder: (context, index) {
                      return
                          //ListTile(
                          //   title: Text(dashboardController.partList[index].partName),
                          // );

                          Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        elevation: 5,
                        color: const Color.fromARGB(255, 255, 255, 255),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                dashboardController.partList[index].partName,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Text.rich(TextSpan(
                                  text: 'Brand: ',
                                  style: TextStyle(
                                      color: Color.fromARGB(148, 0, 0, 0)),
                                  children: <InlineSpan>[
                                    TextSpan(
                                      text: dashboardController
                                          .partList[index].brand,
                                      style: TextStyle(
                                          fontSize: 16,
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ])),
                              Text.rich(TextSpan(
                                  text: 'Serial Number: ',
                                  style: TextStyle(
                                      color: Color.fromARGB(148, 0, 0, 0),
                                      fontSize: 14),
                                  children: <InlineSpan>[
                                    TextSpan(
                                      text: dashboardController
                                          .partList[index].modelNumber,
                                      style: TextStyle(
                                          fontSize: 16,
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ])),
                            ],
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
