import 'package:autoconnectweb/sections/auth/screens/mechanic_profile/mechanic_profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:autoconnectweb/models/mechanic_model.dart';
import 'package:autoconnectweb/models/user_model.dart';
import 'package:autoconnectweb/providers/admin_provider.dart';
import 'package:autoconnectweb/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class UserManagement extends StatelessWidget {
  const UserManagement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
            width: Responsive.isDesktop(context)
                ? size.width * .6
                : size.width * 0.84,
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('mechanics')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List<DocumentSnapshot> docs = snapshot.data!.docs;

                  return ListView(
                    children: List.generate(
                        docs.length,
                        (index) => MechanicTile(
                              mechanic: MechanicModel.fromJson(docs[index]),
                            )),
                  );
                })),
        Visibility(
          visible: Responsive.isDesktop(context),
          child: const SizedBox(
            width: 20,
          ),
        ),
        Visibility(
          visible: Responsive.isDesktop(context),
          child: Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'All Users',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .snapshots(),
                  builder: (ctx, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    List<DocumentSnapshot> docs = snapshot.data!.docs;

                    return Expanded(
                      child: ListView(
                        children: List.generate(
                            docs.length,
                            (index) => UsersCard(
                                user: UserModel.fromJson(docs[index]))),
                      ),
                    );
                  })
            ],
          )),
        ),
      ],
    );
  }
}

class UsersCard extends StatelessWidget {
  const UsersCard({Key? key, required this.user}) : super(key: key);
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(user.imageUrl!),
          ),
          title: Row(
            children: [
              Text(user.fullName!),
              if (user.isAdmin!)
                const SizedBox(
                  width: 10,
                ),
              if (user.isAdmin!)
                const Icon(
                  Icons.verified,
                  size: 16,
                  color: Colors.green,
                ),
            ],
          ),
          subtitle: Text(user.email!),
        ),
        Positioned(
            top: 5,
            right: 5,
            child: PopupMenuButton(
              itemBuilder: (ctx) => [
                PopupMenuItem(
                  child: Text(user.isAdmin! ? 'Revoke Admin' : 'Make Admin'),
                  value: 1,
                ),
                const PopupMenuItem(
                  child: Text('Delete'),
                  value: 2,
                ),
                const PopupMenuItem(
                  child: Text('Block'),
                  value: 3,
                ),
              ],
              onSelected: (value) async {
                if (value == 1) {
                  Provider.of<AdminProvider>(context, listen: false)
                      .makeAdmin(user.userId!, user.isAdmin!);
                  user.isAdmin = !user.isAdmin!;
                } else if (value == 2) {
                  final res = await http.post(
                      Uri.parse(
                          'https://us-central1-my-autoconnect.cloudfunctions.net/deleteUser'),
                      body: {
                        'uid': user.userId!,
                      });

                  if (res.statusCode == 200) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.green,
                        content: Text('User deleted successfully',
                            style: TextStyle(
                              color: Colors.white,
                            ))));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('Error deleting user',
                            style: TextStyle(
                              color: Colors.white,
                            ))));
                  }
                } else if (value == 3) {}
              },
            ))
      ],
    );
  }
}

class MechanicTile extends StatelessWidget {
  const MechanicTile({Key? key, required this.mechanic}) : super(key: key);
  final MechanicModel mechanic;

  @override
  Widget build(BuildContext context) {
    final actions = Provider.of<AdminProvider>(context, listen: false);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (ctz) => Dialog(
                              child: SizedBox(
                                width: 400,
                                child: MechanicProfileScreen(
                                  mechanic: mechanic,
                                ),
                              ),
                            ));
                  },
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey,
                    child: mechanic.status == 'blocked'
                        ? const Center(
                            child: Text(
                              'Blocked',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : null,
                    backgroundImage: mechanic.status == 'blocked'
                        ? null
                        : NetworkImage(mechanic.profile!),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mechanic.name!,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    iconWidget(Icons.email, mechanic.id!),
                    iconWidget(Icons.phone, mechanic.phone!),
                    iconWidget(Icons.location_on, mechanic.address!),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Actions',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 35,
                  child: RaisedButton.icon(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    onPressed: () async {
                      if (mechanic.status != 'blocked') {
                        await actions.blockMechanic(mechanic.id!);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Mechanic Blocked'),
                        ));
                      } else {
                        await actions.approveMechanic(mechanic.id!);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Mechanic Approved'),
                        ));
                      }
                    },
                    icon: const Icon(
                      Icons.block,
                      color: Colors.white,
                      size: 20,
                    ),
                    label: Text(
                      mechanic.status == 'blocked' ? 'Approve' : 'Block',
                      style: const TextStyle(color: Colors.white),
                    ),
                    color: mechanic.status == 'blocked'
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
                SizedBox(
                  height: 35,
                  child: RaisedButton.icon(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    onPressed: () async {
                      await actions.denyMechanic(mechanic.id!);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Mechanic Revoked'),
                      ));
                    },
                    icon: const Icon(
                      Icons.security,
                      size: 20,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Revoke Access',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(
                  height: 35,
                  child: RaisedButton.icon(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    onPressed: () async {
                      await actions.deleteMechanic(mechanic.id!);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Mechanic Deleted'),
                      ));
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 20,
                    ),
                    label: const Text(
                      'Delete',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.red,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget iconWidget(IconData icon, String title) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.grey,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(title),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
