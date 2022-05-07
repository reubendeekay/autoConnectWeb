import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:autoconnectweb/models/mechanic_model.dart';
import 'package:autoconnectweb/providers/ui_provider.dart';
import 'package:autoconnectweb/sections/auth/screens/documents/document_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DocumentOverview extends StatelessWidget {
  const DocumentOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: const DocumentPeopleList(),
        ),
        Expanded(
            child: Provider.of<UIProvider>(
                      context,
                    ).selecetdMechanic ==
                    null
                ? const Center(
                    child: Text('No Requests '),
                  )
                : const DocumentDetailScreen())
      ],
    );
  }
}

class DocumentPeopleList extends StatelessWidget {
  const DocumentPeopleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('mechanics')
            .where('status', isEqualTo: 'pending')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: Text('No Requests'));
          }

          List<DocumentSnapshot> docs = snapshot.data!.docs;

          return ListView(
            children: List.generate(
              docs.length,
              (index) => DocumentPersonWidget(
                  mechanic: MechanicModel.fromJson(docs[index])),
            ),
          );
        });
  }
}

class DocumentPersonWidget extends StatelessWidget {
  const DocumentPersonWidget({Key? key, required this.mechanic})
      : super(key: key);
  final MechanicModel mechanic;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            Provider.of<UIProvider>(context, listen: false)
                .setSelectedMechanic(mechanic);
          },
          hoverColor: Colors.yellow,
          title: Text(mechanic.name!),
          subtitle: Text(mechanic.phone!),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(mechanic.profile!),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
