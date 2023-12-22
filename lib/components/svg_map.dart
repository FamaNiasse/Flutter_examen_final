import 'package:flutter/material.dart';
import 'package:flutter_examen1/components/config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_graphics/vector_graphics.dart';


class SvgMap extends StatefulWidget {
  const SvgMap({super.key, required this.config});

  final Config config;

  @override
  State<SvgMap> createState() => _SvgMapState();
}

class _SvgMapState extends State<SvgMap> {

  // précompilation du svgMap lancer:
  // dart run vector_graphics_compiler -i web/assets/img/france.svg -o web/assets/img/france.svg.vec
  final Widget compiledSvgMap = const SvgPicture(
    AssetBytesLoader('web/assets/img/france.svg.vec')
  );

  final Widget svgMap = SvgPicture.asset(
  'web/assets/img/france.svg',
    semanticsLabel: 'Carte des regions'
  );


  @override
  Widget build(BuildContext context) {
    return Center(
      child: svgMap,
    );
  }
}