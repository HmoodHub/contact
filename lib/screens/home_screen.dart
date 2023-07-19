// ignore_for_file: non_constant_identifier_names

import 'package:contacts/model/contact_model.dart';
import 'package:contacts/provider/contact_provider.dart';
import 'package:contacts/widgets/const_widgets_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'contact_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ContactProvider>(context, listen: false).getDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DefoultAppBar(
        title: 'HomeScreen',
        action: [
          IconButton(
            onPressed: () {
              Get.to(() => ContactScreen(), arguments: {'myScreen': 'create'});
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              // print(_controllerLang.language.value);
              // _controllerLang.changeLanguage();
              // print(_controllerLang.language.value);
            },
            icon: const Icon(
              Icons.language,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Consumer<ContactProvider>(
        builder: (context, value, child) {
          if (value.myData.isNotEmpty) {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              itemBuilder: (context, index) =>
                  listViewItem(index, value.myData),
              itemCount: value.myData.length,
              separatorBuilder: (context, index) => const Divider(
                thickness: 2,
              ),
            );
          } else {
            return const Center(
              child: Text(
                'No Data',
                style: TextStyle(color: Colors.grey),
              ),
            );
          }
        },
      ),
    );
  }

  Widget listViewItem(int index, List<ContactModel> myData) => ListTile(
        onTap: () {
          Get.to(
            () => ContactScreen(),
            arguments: {
              'name': myData[index].name,
              'number': myData[index].number,
              'id': myData[index].id,
              'myScreen': 'update'
            },
          );
        },
        contentPadding: EdgeInsets.zero,
        title: Text(myData[index].name),
        subtitle: Text(myData[index].number),
        leading: Icon(
          Icons.contact_mail_outlined,
          color: HexColor('#81C995'),
        ),
        trailing: IconButton(
          onPressed: () async => deleted(myData[index].id),
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      );

  Future<void> deleted(int id) async {
    await Provider.of<ContactProvider>(context, listen: false)
        .deleteData(id)
        .then((value) {
      print(
          Provider.of<ContactProvider>(context, listen: false).myData.last.id);
    });
  }
}
