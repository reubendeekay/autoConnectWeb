// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:autoconnectweb/providers/admin_provider.dart';
import 'package:autoconnectweb/providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DocumentDetailScreen extends StatelessWidget {
  const DocumentDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mechanic = Provider.of<UIProvider>(context, listen: false);
    final actions = Provider.of<AdminProvider>(context, listen: false);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Container(
            height: 70,
            padding: const EdgeInsets.all(20),
            child: Row(children: [
              const SizedBox(width: 10),
              CircleAvatar(
                radius: 40,
                backgroundImage:
                    NetworkImage(mechanic.selecetdMechanic!.profile!),
              ),
              const SizedBox(width: 15),
              Text(mechanic.selecetdMechanic!.name!),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RaisedButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () async {
                        await actions
                            .approveMechanic(mechanic.selecetdMechanic!.id!);
                        mechanic.setSelectedMechanic(null);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Approved'),
                          ),
                        );
                      },
                      child: const Text(
                        'Approve',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    RaisedButton(
                      color: Colors.red,
                      onPressed: () async {
                        await actions
                            .denyMechanic(mechanic.selecetdMechanic!.id!);
                        mechanic.setSelectedMechanic(null);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Denied'),
                          ),
                        );
                      },
                      child: const Text(
                        'Deny',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
          const Divider(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    color: Colors.grey[200],
                    padding: const EdgeInsets.all(20),
                    child: Text(mechanic.selecetdMechanic!.name!)),
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    color: Colors.grey[200],
                    padding: const EdgeInsets.all(20),
                    child: Text(mechanic.selecetdMechanic!.description!)),
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    color: Colors.grey[200],
                    padding: const EdgeInsets.all(20),
                    child: Text(mechanic.selecetdMechanic!.phone!)),
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    color: Colors.grey[200],
                    padding: const EdgeInsets.all(20),
                    child: Text(mechanic.selecetdMechanic!.address!)),
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    color: Colors.grey[200],
                    padding: const EdgeInsets.all(20),
                    child: Text('Mechanic Location' +
                        '(' +
                        mechanic.selecetdMechanic!.location!.latitude
                            .toString() +
                        ',' +
                        mechanic.selecetdMechanic!.location!.longitude
                            .toString() +
                        ')')),
                const SizedBox(height: 20),
                const Text(
                  'Documents',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Row(children: [
                  InkWell(
                    onTap: () {
                      downloadFile(mechanic.selecetdMechanic!.nationalId!);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blueGrey[200],
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.only(right: 20),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 100,
                            child: Image.asset(
                              'assets/images/pdf.png',
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text('National ID'),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      downloadFile(mechanic.selecetdMechanic!.permit!);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blueGrey[200],
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.only(right: 20),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 100,
                            child: Image.asset(
                              'assets/images/pdf.png',
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text('Business Permit')
                        ],
                      ),
                    ),
                  )
                ]),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void downloadFile(String url) {
  html.AnchorElement anchorElement = html.AnchorElement(href: url);
  anchorElement.download = url;
  anchorElement.click();
}
