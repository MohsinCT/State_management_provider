import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_management_provider/model/student_model.dart';

class StudentProvider extends ChangeNotifier {
  final Box<Student> nameBox;
  String? selectedImage;

  StudentProvider() : nameBox = Hive.box<Student>('Student');

  List<Student> get names => nameBox.values.toList();

  void addStudent(
      String name, int age, String place, String phoneNumber, String imageUrl) {
    nameBox.add(Student(
        place: place,
        name: name,
        age: age,
        phoneNumber: phoneNumber,
        imageUrl: imageUrl));
    notifyListeners();
  }

  void updateStudent(int index, String name, String place, int age,
      String imageUrl, String phoneNumber) {
    nameBox.putAt(
        index,
        Student(
            place: place,
            name: name,
            age: age,
            phoneNumber: phoneNumber,
            imageUrl: imageUrl));
            notifyListeners();
  }
  void deleteStudent(int index){
    nameBox.deleteAt(index);
    notifyListeners();
  }

  List<Student> searchStudents(String query){
    if(query.isEmpty){
      return names;
    } else{
      return names.where((name){
        return name.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }
 
 Future  pickImage(ImageSource source)async{
  final pickImage = await ImagePicker().pickImage(source: source);
  if(pickImage != null){
    selectedImage = pickImage.path;
    notifyListeners();
  }
 }

 void clearSelectedImage(){
  selectedImage = null;
 notifyListeners();
 }


}
