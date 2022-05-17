import 'package:autoconnectweb/models/service_model.dart';
import 'package:flutter/material.dart';

class ServiceTile extends StatefulWidget {
  final ServiceModel service;
  const ServiceTile(this.service, {Key? key, this.isFile = false})
      : super(key: key);
  final bool isFile;
  @override
  _ServiceTileState createState() => _ServiceTileState();
}

class _ServiceTileState extends State<ServiceTile> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        height: size.height * 0.1,
        constraints: const BoxConstraints(minHeight: 70),
        child: Column(
          children: [
            Expanded(
                child: Row(
              children: [
                SizedBox(
                    width: 150,
                    height: size.height * 0.1,
                    child: Image.network(
                      widget.service.imageUrl!,
                      fit: BoxFit.cover,
                    )),
                const SizedBox(width: 10),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.service.serviceName!,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      'KES ' + widget.service.price!,
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ],
                ))
              ],
            )),
            const Divider()
          ],
        ),
      ),
    );
  }
}
