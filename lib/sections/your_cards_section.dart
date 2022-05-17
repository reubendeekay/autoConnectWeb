import 'package:autoconnectweb/models/mechanic_model.dart';
import 'package:autoconnectweb/providers/mechanic_provider.dart';
import 'package:autoconnectweb/widgets/top_mechanics_widget.dart';
import 'package:autoconnectweb/widgets/category_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardsSection extends StatelessWidget {
  const CardsSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CategoryBox(title: "Top Mechanics", suffix: Container(), children: [
      FutureBuilder<List<MechanicModel>>(
          future: Provider.of<MechanicProvider>(context, listen: false)
              .getTopMechanics(),
          builder: (ctx, data) {
            if (data.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView(
              shrinkWrap: true,
              children: data.data!
                  .map((e) => TopMechanicWidget(mechanic: e))
                  .toList(),
            );
          })
    ]);
  }
}
