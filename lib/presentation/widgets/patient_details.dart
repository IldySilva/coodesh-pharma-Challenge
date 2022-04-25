import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/patient_entity.dart';

class PatientDetails extends StatelessWidget {
  Patient patient;

  PatientDetails(this.patient);
  String get nameUser => patient.name!.first! + " " + patient.name!.last!;

  String get dob =>
      DateFormat("dd-MM-yyyy").format(DateTime.parse(patient.dob!));
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: Get.width,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(100))),
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(patient.picture!.medium!),
                  radius: 50,
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                    width: Get.width * 0.7,
                    child: ListTile(
                      title: Text(
                        nameUser,
                        style: TextStyle(fontSize: 18),
                      ),
                      subtitle: Text(patient.email!),
                    trailing: IconButton(onPressed: ()=>Navigator.pop(context),icon: Icon(Icons.close),),
                    ))

              ],
            ),
            Container(
              child: ListTile(
                title: Text(
                  patient.id?.name??"No Name",
                  style: TextStyle(fontSize: 18),
                ),
                subtitle: Text("ID"),
              ),
            ),
            Container(
              child: ListTile(
                title: Text(
                  patient.gender!,
                  style: TextStyle(fontSize: 18),
                ),
                subtitle: Text("Gender"),
              ),
            ),
            Container(
              child: ListTile(
                title: Text(
               dob,
                  style: TextStyle(fontSize: 18),
                ),
                subtitle: Text("Date of Birth"),
              ),
            ),
            Container(

              child: ListTile(
                title: Text(
                  patient.phone!,
                  style: TextStyle(fontSize: 18),
                ),
                subtitle: Text("Phone Number"),
              ),
            ),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [

             Container(
               width: Get.width * 0.4,
               child: ListTile(
                 title: Text(
                   patient.nat!,
                   style: TextStyle(fontSize: 18),
                 ),
                 subtitle: Text("From"),
               ),
             ),  Container(
               width: Get.width * 0.4,
               child: ListTile(
                 title: Text(
                   patient.location!.city!,
                   style: TextStyle(fontSize: 18),
                 ),
                 subtitle: Text("Adress"),
               ),
             )
           ],)
          ],
        )
      ],
    );
  }
}
