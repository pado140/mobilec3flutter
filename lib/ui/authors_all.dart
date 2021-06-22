import 'package:flutter/material.dart';
import 'package:flutter_app_c3_mobile/model/auteur_item.dart';
import 'package:flutter_app_c3_mobile/services/api_services.dart';
import 'package:flutter_app_c3_mobile/services/author_services.dart';

class AuthorsViewAll extends StatefulWidget {
  const AuthorsViewAll({Key? key}) : super(key: key);

  @override
  _AuthorsViewAllState createState() => _AuthorsViewAllState();
}

class _AuthorsViewAllState extends State<AuthorsViewAll> {
  Widget customHeaderApp = Text("Auteurs");
  bool issearch = false;
  Icon customsearchIcon = Icon(Icons.search_rounded);
  AuthorServices bk = AuthorServices();
  late Future<List<AuteurItem>> authorlist = bk.fetchAuthors({});
  late Future<List<AuteurItem>> authorlistfilter;
  @override
  void initState() {
    super.initState();
    authorlistfilter = authorlist;
  }

  void search(String? val) {
    if (val == null) {
      setState(() {
        authorlistfilter = authorlist;
      });
    }
    // else{
    //   authorlistfilter=authorlist.then((value) => {List<AuteurItemvalue.})
    // }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: customHeaderApp,
        backgroundColor: Colors.amber.shade700,
        actions: [
          IconButton(
              onPressed: () {
                if (!issearch) {
                  setState(() {
                    issearch = true;
                    customHeaderApp = TextField(
                      onChanged: (value) {},
                    );
                    customsearchIcon = Icon(Icons.cancel_outlined);
                  });
                } else {
                  setState(() {
                    customHeaderApp = Text("Auteurs");
                    issearch = false;
                    customsearchIcon = Icon(Icons.search_rounded);
                  });
                }
              },
              icon: customsearchIcon)
        ],
      ),
      body: Container(
        child: FutureBuilder<List<AuteurItem>>(
          future: authorlistfilter,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  AuteurItem ai = snapshot.data![index];
                  return InkWell(
                    onTap: () {},
                    child: Container(
                        child: Stack(
                      children: [
                        Container(
                          width: size.width - 120,
                          height: 50,
                          color: Colors.amber.shade700,
                          margin: EdgeInsets.only(
                            left: 50,
                            top: index == 0 ? 10 : 0,
                            bottom: 10,
                          ),
                          padding: EdgeInsets.only(left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(ai.name),
                              Text(
                                ai.bio,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          left: 10,
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25)),
                            clipBehavior: Clip.antiAlias,
                            child: Image.network(
                              "$scheme://$authority/${snapshot.data![index].imagepath}",
                              fit: BoxFit.fill,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    )),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Icon(Icons.now_widgets);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
