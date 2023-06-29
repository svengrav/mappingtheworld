import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';
import 'package:url_launcher/url_launcher.dart';

class Project extends StatelessWidget {
  const Project({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(50),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
              height: 150,
              width: 150,
              child: RiveAnimation.asset('assets/mtw_logo.riv')),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              style: GoogleFonts.robotoSlab(fontSize: 30),
              'Mapping the World',
            ),
          ),
          Container(
            color: Colors.white38,
            height: 1,
            margin: const EdgeInsets.all(40),
            width: 50,
          ),
          const Text(
            'Mapping the World is a project about explorers, cartographers and their maps.',
          ),
          const SizedBox(
            height: 40,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ProjectLink(
                icon: Icon(Icons.code),
                label: 'github',
                link: 'https://github.com/svengrav/mappingtheworld',
              ),
              _ProjectLink(
                icon: Icon(Icons.link),
                label: 'linkedIn',
                link: 'https://www.linkedin.com/in/svengrav',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProjectLink extends StatelessWidget {
  const _ProjectLink(
      {required this.link, required this.icon, required this.label});

  final String link;
  final Icon icon;
  final String label;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: TextButton.icon(
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.white10),
          ),
          onPressed: () => launchUrl(Uri.parse(link)),
          icon: icon,
          label: Text(
            label,
          ),
        ),
      );
}
