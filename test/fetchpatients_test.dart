import 'package:flutter_test/flutter_test.dart';
import 'package:pharmainc/data/patientNetwork/patientNetwork.dart';

void main(){

  test("Check if Is getting the Patients", ()async {

    final list=await PatientNetwork().getPatients();
    expect(list.isEmpty, true);
  });


}