import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PokededxPage extends StatefulWidget {
  const PokededxPage({Key? key}) : super(key: key);

  @override
  _PokededxPageState createState() => _PokededxPageState();
}

class _PokededxPageState extends State<PokededxPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(AppLocalizations.of(context)!.landingPageCardLabelPokedex),
      ),
    );
  }
}
