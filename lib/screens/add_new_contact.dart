import 'package:contacts/widgets/const_widgets_app.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../model/contact_model.dart';
import '../provider/contact_provider.dart';

class AddNewContact extends StatefulWidget {
  @override
  _AddNewContactState createState() => _AddNewContactState();
}

class _AddNewContactState extends State<AddNewContact> {
  late TextEditingController _nameController;
  late TextEditingController _numberController;
  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = TextEditingController();
    _numberController = TextEditingController();
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
      appBar: DefoultAppBar(title: 'New Contact'),
      body: Form(
        key: _keyForm,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          shrinkWrap: true,
          children: [
            const Text(
              'To add a new contact, fill in these fields',
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
                  insertData();
                  Get.back();
                }
              },
              blockButton: true,
              size: GFSize.LARGE,
              child: const Text("SAVE"),
            )
          ],
        ),
      ),
    );
  }

  Future<void> insertData() async {
    await Provider.of<ContactProvider>(context, listen: false)
        .setData(contactModel)
        .then((value) {
      if (value) {
        print('added is success');
        Get.showSnackbar(
          const GetSnackBar(
            backgroundColor: Colors.green,
            message: 'Add is success',
            borderRadius: 10,
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        Get.showSnackbar(
          const GetSnackBar(
            backgroundColor: Colors.red,
            borderRadius: 10,
            message: 'Add is field',
            duration: Duration(seconds: 2),
          ),
        );
      }
    });
  }

  ContactModel get contactModel {
    ContactModel c = ContactModel();
    c.name = _nameController.text;
    c.number = _numberController.text;
    return c;
  }
}
