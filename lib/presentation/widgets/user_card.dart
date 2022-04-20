import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pharmainc/domain/entities/patient_entity.dart';

class UserCard extends StatelessWidget {

  Patient patient;
  String searchTerm;
  UserCard(this.patient,{this.searchTerm=""})  ;
  String  get nameUser =>patient.name!.first! + " " +patient.name!.last!;
      String get dob=>DateFormat("dd-MM-yyyy").format(DateTime.parse(patient.dob!));

  @override
  Widget build(BuildContext context) {
    return nameUser.contains(searchTerm)?  Card(
      child: ListTile(

leading: CircleAvatar(backgroundImage: NetworkImage(patient.picture!.medium!),),
          title: Text(nameUser),subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(patient.gender!),
Text(dob)

            ],
          ),),
    ):const SizedBox();
  }
}
