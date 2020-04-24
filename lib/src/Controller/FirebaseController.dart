
import 'package:firebase_database/firebase_database.dart';
import 'package:vuthaserviceman/src/Utils/Common.dart';

activeOperation(active){

  FirebaseDatabase.instance.reference().child(ServiceMan).child(user_number).update({

    "active" :active

  }).catchError((err) => print(err));

}



