import 'package:flutter/material.dart';
import 'package:flutter_app_c3_mobile/model/auteur_item.dart';
import 'package:flutter_app_c3_mobile/services/api_services.dart';
import 'package:flutter_app_c3_mobile/services/author_services.dart';
import 'package:flutter_app_c3_mobile/ui/authors_all.dart';

class AuthorsView extends StatefulWidget {
  const AuthorsView({Key? key}) : super(key: key);

  @override
  _AuthorsViewState createState() => _AuthorsViewState();
}

class _AuthorsViewState extends State<AuthorsView> {
  AuthorServices bk = AuthorServices();
  late Future<List<AuteurItem>> authorlist = bk.fetchAuthors({});

  // @override
  // void initState() {
  //   super.initState();
  //   booklist = bk.fetchBooks();
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 180,
      width: size.width,
      // color: Colors.black,
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Text(
                    "Auteurs",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return AuthorsViewAll();
                        }),
                      );
                    },
                    icon: Icon(
                      Icons.arrow_right_alt,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            height: 130,
            child: FutureBuilder<List<AuteurItem>>(
              future: authorlist,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return Container(
                        width: 120,
                        key: Key("${snapshot.data![index].id}"),
                        margin: EdgeInsets.only(
                            left: 10, right: index == 9 ? 10 : 0),
                        decoration: BoxDecoration(
                            // border: Border.all(),
                            // borderRadius: BorderRadius.circular(20),
                            ),
                        child: Column(
                          children: [
                            Container(
                              key: Key("${snapshot.data![index].id}"),
                              height: 100,
                              width: 100,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.amber),
                              child: Image.network(
                                "$scheme://$authority/${snapshot.data![index].imagepath}",
                                fit: BoxFit.fill,
                                key: Key("${snapshot.data![index].id}"),
                              ),
                            ),
                            Text(
                              snapshot.data![index].name,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      );
                    },
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                  );
                }
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return Text("Aucune donnees trouve");
                } else
                  return Center(child: CircularProgressIndicator());
              },
            ),
          )
        ],
      ),
    );
  }
}
