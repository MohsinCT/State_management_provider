import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_management_provider/controller/student_provider.dart';
import 'package:student_management_provider/widgets/custom_button.dart';
import 'package:student_management_provider/widgets/custom_profile_avatar.dart';
import 'package:student_management_provider/widgets/custom_textfield.dart';

class AddStudent extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  AddStudent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'AddStudent',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Consumer<StudentProvider>(
            builder: (context, studentinfoProvider, child) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: CustomProfileAvatar(
                        imagePath: studentinfoProvider.selectedImage,
                        cirlebackground: Colors.blue,
                        backgroundColor: Colors.blue.withOpacity(0.3),
                        onTapGalleryTap: () {
                          studentinfoProvider.pickImage(ImageSource.gallery);
                        },
                        onCameraTap: () {
                          studentinfoProvider.pickImage(ImageSource.camera);
                        }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomTextfield(
                              controller: nameController,
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                              keyboardtype: TextInputType.text,
                              labelText: 'Name'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomTextfield(
                              controller: placeController,
                              prefixIcon: const Icon(
                                Icons.place,
                                color: Colors.black,
                              ),
                              keyboardtype: TextInputType.text,
                              labelText: 'Place'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomTextfield(
                              controller: ageController,
                              prefixIcon: const Icon(
                                Icons.calendar_today,
                                color: Colors.black,
                              ),
                              keyboardtype: TextInputType.number,
                              labelText: 'Age'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomTextfield(
                              controller: phoneController,
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                              keyboardtype: TextInputType.text,
                              labelText: 'Phone'),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: CustomButton(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            final name = nameController.text;
                            final place = placeController.text;
                            final age = int.tryParse(ageController.text) ?? 0;
                            final phoneNumber = phoneController.text;

                            if (name.isNotEmpty &&
                                place.isNotEmpty &&
                                phoneNumber.isNotEmpty &&
                                studentinfoProvider.selectedImage != null) {
                                studentinfoProvider.addStudent(
                                  name,
                                  age,
                                  place,
                                  phoneNumber,
                                  studentinfoProvider.selectedImage!);

                              nameController.clear();
                              placeController.clear();
                              ageController.clear();
                              phoneController.clear();
                              studentinfoProvider.clearSelectedImage();
                              Navigator.of(context).pop();
                            }
                            
                          }
                        },
                        gradientColors: [
                          Colors.blue[500]!,
                          Colors.blue[300]!,
                        ],
                        boxShadowColor: Colors.blue,
                        buttonText: 'SAVE'),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
