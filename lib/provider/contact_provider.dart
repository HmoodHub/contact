import 'package:contacts/database/database_app.dart';
import 'package:contacts/model/contact_model.dart';
import 'package:flutter/material.dart';

class ContactProvider extends ChangeNotifier {
  List<ContactModel> myData = <ContactModel>[];
  DatabaseApp databaseApp = DatabaseApp();

  // CRUD
  Future<void> getDate() async {
    myData = await databaseApp.read();
    notifyListeners();
  }
  Future<bool> setData(ContactModel contactModel)async{
    int rowInserted = await databaseApp.insert(contactModel);
    if (rowInserted != 0) {
      contactModel.id = rowInserted;
      myData.add(contactModel);
      print(rowInserted);
      notifyListeners();
    }
    return rowInserted != 0 ;
  }
  Future<bool> deleteData(int id)async{
    bool deleted = await databaseApp.delete(id);
    if (deleted) {
      int index = myData.indexWhere((element) => element.id == id);
      if (index != -1) {
        myData.removeAt(index);
        notifyListeners();
      }
    }  
    return deleted ;
  }
  Future<bool> updateData(ContactModel contactModel)async{
    bool updated = await databaseApp.update(contactModel);
    if (updated) {
      int index = myData.indexWhere((element) => element.id == contactModel.id);
      print(index);
      if (index != -1) {
        myData[index] = contactModel ;
        notifyListeners();
      }
    }
    return updated;
  }




}
