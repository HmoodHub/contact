import 'package:contacts/widgets/const_widgets_app.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../model/contact_model.dart';
import '../provider/contact_provider.dart';

class ContactScreen extends StatefulWidget {
  ContactScreen({super.key});

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  late TextEditingController _nameController;
  late TextEditingController _numberController;
  final _keyForm = GlobalKey<FormState>();
  String name = Get.arguments['name'] ?? '';
  String number = Get.arguments['number'] ?? '';
  int id = Get.arguments['id'] ?? 0;
  String myScreen = Get.arguments['myScreen'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = TextEditingController(text: name ?? '');
    _numberController = TextEditingController(text: number ?? '');
    print("$id $name $number");
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
      appBar: DefoultAppBar(title: isUpdate() ? 'Update' : 'Create'),
      body: Form(
        key: _keyForm,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          shrinkWrap: true,
          children: [
            Text(
              isUpdate()
                  ? 'Update Data'
                  : 'To add a new contact, fill in these fields',
              style: const TextStyle(
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
                  setData();
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

  Future<void> setData() async {
    bool status = isUpdate()
        ? await Provider.of<ContactProvider>(context, listen: false)
            .updateData(object)
        : await Provider.of<ContactProvider>(context, listen: false)
            .setData(object);

    if (status) {
      print('Successfully');
      Get.showSnackbar(
        const GetSnackBar(
          backgroundColor: Colors.green,
          message: 'Successfully',
          borderRadius: 10,
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      Get.showSnackbar(
        const GetSnackBar(
          backgroundColor: Colors.red,
          borderRadius: 10,
          message: 'Failed',
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  ContactModel get object {
    ContactModel c;
    if (isUpdate()) {
      c = ContactModel();
      c.id = id;
      c.name = _nameController.text;
      c.number = _numberController.text;
      return c;
    } else {
      c = ContactModel();
      c.name = _nameController.text;
      c.number = _numberController.text;
      return c;
    }
  }

  bool isUpdate() {
    if (myScreen != null && myScreen == 'update') {
      return true;
    } else {
      return false;
    }
  }
}
