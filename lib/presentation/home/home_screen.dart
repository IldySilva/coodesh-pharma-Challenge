import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pharmainc/data/patientNetwork/patientNetwork.dart';
import 'package:pharmainc/domain/entities/patient_entity.dart';
import 'package:pharmainc/presentation/filtered_page.dart';
import 'package:pharmainc/presentation/widgets/user_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  RxString searchTerm="".obs;

  static const _pageSize = 50;
  final PagingController<int, Patient> _pagingController =
      PagingController(firstPageKey: 1);

  Future<void> _fetchPage(int pageKey) async {
    try {
      var newItems = await PatientNetwork().getPatients(limit: 50);
      var isLastPage = newItems.length < _pageSize;
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

  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pharma Inc",
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
               _buildSearch(),
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
                        itemBuilder: (context, item, index) => Obx(()=>UserCard(item,searchTerm:searchTerm.value))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  _buildSearch(){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            width: Get.width * 0.74,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black54,
                      offset: Offset(1, 1),
                      blurRadius: 10,
                      spreadRadius: -3)
                ]),
            child:  TextField(
              onChanged: (value)=>searchTerm.value=value,
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10),
                  border: InputBorder.none,
                  hintText: "Search"),
            )),
        IconButton(
            onPressed: () async{
              await showDialog(context: context, builder: (context){

                return SimpleDialog(title: Text("Filter By"),children: [TextButton(onPressed: (){

                  Navigator.pop(context);
                  _filterByCountry();

                }, child: Text("Nationality")),TextButton(onPressed: (){
Navigator.pop(context);
                  _filterByGender();


                }, child: Text("Gender"))]);
              });

            },
            icon: const Icon(
              Icons.filter_alt_rounded,
              color: Colors.grey,
            )),
      ],
    );

  }
  _filterByGender()async {

    return    await showDialog(context: context, builder: (context){

      return SimpleDialog(title: Text("Filter By Gender"),children: [TextButton(onPressed: (){
        Navigator.pop(context);

        Navigator.push(context, MaterialPageRoute(builder: (context)=>FilterPage(gender: "male")));

      }, child: Text("Male")),TextButton(onPressed: (){
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>FilterPage(gender: "female")));

      }, child: Text("Female"))]);
    });

  }
  _filterByCountry() async {

    var listOfCountries=["AU","BR", "CA", "CH", "DE", "DK", "ES", "FI", "FR", "GB", "IE", "IR", "NO", "NL", "NZ", "TR", "US"];
    return    await showDialog(context: context, builder: (context){

      return SimpleDialog(title: const Text("Filter By Gender"),children: [
for(var country in listOfCountries)
        TextButton(onPressed: (){
Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>FilterPage(country:country)));

      }, child: Text(country)),]);
    });
  }


}
