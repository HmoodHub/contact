import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';

import '../model/contact_model.dart';
import '../provider/contact_provider.dart';
import '../widgets/const_widgets_app.dart';

class UpdateScreen extends StatefulWidget {

  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  late TextEditingController _nameController;
  late TextEditingController _numberController;
  final _keyForm = GlobalKey<FormState>();
  final name = Get.arguments['name'];
  final number = Get.arguments['number'];
  final id = Get.arguments['id'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = TextEditingController(text: name);
    _numberController = TextEditingController(text:  number);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _numberController.dispose();
    _nameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DefoultAppBar(title: 'Update Contact'),
      body: Form(
        key: _keyForm,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          shrinkWrap: true,
          children: [
            const Text(
              'To update a contact, edite in these fields',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormFieldApp(
              controller: _nameController,
              hint: 'Name',
              prefixIcon: Icons.person,
              type: TextInputType.name,
              toggleText: false,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormFieldApp(
              controller: _numberController,
              hint: 'Number',
              prefixIcon: Icons.phone_android,
              type: TextInputType.number,
              toggleText: false,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 30,
            ),
            GFButton(
              onPressed: () {
                if (_keyForm.currentState!.validate()) {
                  updateData();
                  Get.back();
                }
              },
              blockButton: true,
              size: GFSize.LARGE,
              child: const Text("UPDATE"),
            )
          ],
        ),
      ),
    );
  }
  Future<void> updateData() async {
    await Provider.of<ContactProvider>(context, listen: false)
        .updateData(contactModel)
        .then((value) {
      if (value) {
        print('update is success');
        Get.showSnackbar(
          const GetSnackBar(
            backgroundColor: Colors.green,
            message: 'Update is success',
            borderRadius: 10,
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        Get.showSnackbar(
          const GetSnackBar(
            backgroundColor: Colors.red,
            borderRadius: 10,
            message: 'Update is field',
            duration: Duration(seconds: 2),
          ),
        );
      }
    });
  }
  ContactModel get contactModel {
    ContactModel c = ContactModel();
    c.id = id;
    c.name = _nameController.text;
    c.number = _numberController.text;
    return c;
  }
}
