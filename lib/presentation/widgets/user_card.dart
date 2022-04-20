import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pharmainc/domain/entities/patient_entity.dart';
import 'package:pharmainc/presentation/widgets/patient_details.dart';

class UserCard extends StatefulWidget {

  Patient patient;
  String searchTerm;
  UserCard(this.patient,{this.searchTerm=""})  ;

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  String  get nameUser =>widget.patient.name!.first! + " " +widget.patient.name!.last!;

      String get dob=>DateFormat("dd-MM-yyyy").format(DateTime.parse(widget.patient.dob!));

  @override
  Widget build(BuildContext context) {
    return nameUser.contains(widget.searchTerm)?  Card(
      child: ListTile(
onTap: (){


  showModalBottomSheet(
    backgroundColor: Colors.transparent,
      context: context, builder: (context)=>PatientDetails(widget.patient));
},
leading: CircleAvatar(backgroundImage: NetworkImage(widget.patient.picture!.medium!),),
          title: Text(nameUser),subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.patient.gender!),
Text(dob)

            ],
          ),),
    ):const SizedBox();
  }
}
