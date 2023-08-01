import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mtw_app/map/map_definition.dart';

import 'map_position.dart';

class MapDescription extends StatelessWidget {
  final MapDefinition definition;
  final MapPosition position;

  const MapDescription({
    super.key,
    required this.position,
    required this.definition,
  });

  @override
  Widget build(BuildContext context) {
    var description = Column(children: [
      Container(
        color: Colors.white38,
        height: 1,
        margin: const EdgeInsets.all(15),
        width: 50,
      ),
      Text(
        definition.summary,
        textAlign: TextAlign.center,
        style: GoogleFonts.robotoSlab(fontSize: 15),
      )
    ],);

    var information = Column(children: [
      Text(
        definition.year.toString(),
        style: GoogleFonts.robotoSlab(fontSize: 15),
      ),
      position.height > 100 ? description : const SizedBox()
    ]);


    return position.build(Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(children: [
        Text(
          definition.title,
          style: GoogleFonts.robotoSlab(fontSize: 30),
        ),
        information,
      ]),
    ));
  }
}
