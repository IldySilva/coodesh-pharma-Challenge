import 'dart:convert';

import 'package:pharmainc/data/Requests.dart';
import 'package:pharmainc/domain/entities/patient_entity.dart';

class PatientNetwork{
  IRepository repository=HttpNetwork();

Future<List<Patient>> getPatients({limit=50})async{
  List<Patient> returnedList=[];
  try{

    var response=await  repository.fetchData("https://randomuser.me/api/?results=$limit");
    for (var patientJson in jsonDecode(response.body)["results"]) {
      returnedList.add(Patient.fromJson(patientJson));
    }
    return returnedList;

  }
  on Exception catch(e){
    print(e);
    return returnedList;

  }


}

}