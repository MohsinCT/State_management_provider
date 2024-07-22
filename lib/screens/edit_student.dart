import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_management_provider/controller/student_provider.dart';
import 'package:student_management_provider/model/student_model.dart';
import 'package:student_management_provider/widgets/custom_textfield.dart';

class EditStudent extends StatelessWidget{
  final Student nameEntry;
  final int index;
  const EditStudent({super.key, required this.nameEntry, required this.index});

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context);
    TextEditingController nameController = TextEditingController();
    TextEditingController placeController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    String? selectedImage = nameEntry.imageUrl;

    nameController.text = nameEntry.name;
    placeController.text = nameEntry.place;
    ageController.text = nameEntry.age.toString();
    phoneController.text = nameEntry.phoneNumber;
    final formkey = GlobalKey<FormState>();

   return Scaffold(
    appBar: AppBar(
      title: Text("Edit ${nameEntry.name}"),
    ),
    body:SingleChildScrollView(
      child: Form(
        key: formkey,
        child:Column(children: [
          Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                
                CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.blue,
                        child: ClipOval(
                          // ignore: unnecessary_null_comparison
                          child: selectedImage != null
                              ? Image.file(
                                  File(selectedImage),
                                  fit: BoxFit.cover,
                                  width: 140,
                                  height: 140,
                                )
                              : const Icon(
                                  Icons.person,
                                  size: 60,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                       InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Choose image"),
                              actions: [
                                InkWell(
                                  onTap: () {
                                    studentProvider.pickImage(ImageSource.gallery);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Gallery"),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    studentProvider.pickImage(ImageSource.camera);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Camera"),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.blueAccent[200],
                          child: const Icon(Icons.add, color: Colors.white),
                        ),
                      ),
                      
              ],

            ),
          ),
        const   SizedBox(height: 30,),
           Padding(
             padding: const EdgeInsets.all(12.0),
             child: Column(
               children: [
                 CustomTextfield(
                        keyboardtype: TextInputType.text,
                        controller: nameController,
                        labelText: 'Enter name',
                        prefixIcon: const Icon(Icons.person_2_rounded), 
                      ),
                     const SizedBox(height: 30,),
                      CustomTextfield(
                        keyboardtype: TextInputType.text,
                        controller: placeController,
                        labelText: 'Place',
                        prefixIcon: const Icon(Icons.person_2_rounded), 
                      ),
                    const  SizedBox(height: 30,),
                       CustomTextfield(
                        keyboardtype: TextInputType.number,
                        controller: ageController,
                        labelText: 'age',
                        prefixIcon: const Icon(Icons.person_2_rounded), 
                      ),
                      const SizedBox(height:  30,),
                       CustomTextfield(
                        keyboardtype: TextInputType.number,
                        controller: phoneController,
                        labelText: 'phoneNumber',
                        prefixIcon: const Icon(Icons.person_2_rounded), 
                      ),
                      SizedBox(height: 30,),
                       Consumer<StudentProvider>(
                  builder: (context, studentProvider, _) {
                    return InkWell(
                      onTap: () {
                        final name = nameController.text;
                        final age = int.tryParse(ageController.text) ?? 0;
                        final place = placeController.text;
                        final phoneNumber = phoneController.text;

                        if (name.isNotEmpty &&
                            place.isNotEmpty &&
                            phoneNumber.isNotEmpty) {
                          studentProvider.updateStudent(index, name, place, age, selectedImage, phoneNumber);
                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                        height: 60,
                        width: 250,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.blue[500]!, Colors.blue[300]!],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.blue,
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: Offset(0, 3),
                            ),
                          ],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: const Center(
                          child: Text(
                            "EDIT",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),

               ],
             ),
           ),
        ],) ,
        ),
    )
   );
  }
}