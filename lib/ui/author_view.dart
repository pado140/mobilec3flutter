import 'package:flutter/material.dart';
import 'package:flutter_app_c3_mobile/model/auteur_item.dart';

class AuthorView extends StatefulWidget {
  const AuthorView({Key? key}) : super(key: key);

  @override
  _AuthorViewState createState() => _AuthorViewState();
}

class _AuthorViewState extends State<AuthorView> {
  @override
  Widget build(BuildContext context) {
    final author = ModalRoute.of(context)!.settings.arguments as AuteurItem;
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.amber.shade700,
          pinned: true,
          expandedHeight: 250.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(author.name),
          ),
        ),
      ],
    ));
  }
}
