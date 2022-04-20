import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../data/patientNetwork/patientNetwork.dart';
import '../domain/entities/patient_entity.dart';
import 'widgets/user_card.dart';

class FilterPage extends StatefulWidget {

  String? gender;
  String? country;
  FilterPage({this.gender,this.country}) ;
  static const _pageSize = 50;

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {

  final PagingController<int, Patient> _pagingController =
  PagingController(firstPageKey: 1);

  Future<void> _fetchPage(int pageKey) async {
    try {
      var newItems = await PatientNetwork().getPatientsByGenderOrCountry(gender: widget.gender,country: widget.country);
      var isLastPage = newItems.length < FilterPage._pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey.toInt());
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Pharma Inc - ${widget.gender??widget.country}",
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
              child: Container(
                height: Get.height,
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.03,
                    ),

                    Expanded(
                      child: PagedListView<int, Patient>(
                        pagingController: _pagingController,
                        builderDelegate: PagedChildBuilderDelegate<Patient>(
                            newPageProgressIndicatorBuilder: (c) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  CircularProgressIndicator(),
                                  SizedBox(width: 8,),
                                  Text("Loading More")
                                ],
                              ),
                            ),
                            itemBuilder: (context, item, index) => UserCard(item)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
