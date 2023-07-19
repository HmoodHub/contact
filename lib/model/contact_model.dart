class ContactModel{

  late int id ;
  late String name , number ;


  ContactModel();

  Map<String , dynamic> toMap(){
    Map<String , dynamic> myMap = {};
    myMap['name'] = name;
    myMap['number'] = number;
    return myMap;
  }

  ContactModel.fromMap(Map<String , dynamic> myMap){
    id = myMap['id'];
    name = myMap['name'];
    number = myMap['number'];
  }

}