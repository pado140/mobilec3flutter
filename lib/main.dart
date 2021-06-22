import 'package:flutter/material.dart';
import 'package:flutter_app_c3_mobile/services/cart_services.dart';
import 'package:flutter_app_c3_mobile/ui/annonces.dart';
import 'package:flutter_app_c3_mobile/ui/authors_view.dart';
import 'package:flutter_app_c3_mobile/ui/books_all.dart';
import 'package:flutter_app_c3_mobile/ui/books_view.dart';
import 'package:flutter_app_c3_mobile/ui/cart_view.dart';
import 'package:flutter_app_c3_mobile/ui/categories.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'C3 Editions',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.amber.shade700,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          unselectedItemColor: Colors.black87,
          selectedItemColor: Colors.orange,
          unselectedLabelStyle: TextStyle(
            color: Colors.black87,
          ),
        ),
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(title: 'C3 Editions'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int bottomselected = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.indigo),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.pink[700],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                "Abonnement",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Categories(),
              ],
            ),
            Row(
              children: [
                Annonces(),
              ],
            ),
            Divider(
              thickness: 3,
            ),
            Row(
              children: [
                BooksView(titre: "Nos Livres Littéraires", criteres: {}),
              ],
            ),
            Divider(
              thickness: 3,
            ),
            AuthorsView(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return CartView();
            }),
          );
        },
        child: Stack(children: [
          Icon(
            Icons.shopping_cart_rounded,
            size: 42,
            color: Colors.white,
          ),
          Positioned(
              top: 9,
              left: 15,
              child: Text(
                Cart.items.length.toString(),
                style: TextStyle(color: Colors.orange),
              ))
        ]),
        backgroundColor: Colors.amber[800],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
        child: Container(
          child: BottomAppBar(
            elevation: 2,
            shape: CircularNotchedRectangle(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return MyHomePage(
                          title: "C3 Editions",
                        );
                      }),
                    )
                  },
                  icon: Icon(
                    Icons.home,
                  ),
                ),
                IconButton(
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return BooksAll();
                      }),
                    )
                  },
                  icon: Icon(Icons.search_rounded),
                ),
                IconButton(
                  onPressed: () => {},
                  icon: Icon(
                    Icons.home,
                  ),
                ),
                IconButton(onPressed: () => {}, icon: Icon(Icons.settings))
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: "Acceuil",
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.search),
      //       label: "Rechercher",
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.bookmark),
      //       label: "Signet",
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.settings),
      //       label: "Parametres",
      //     )
      //   ],
      //   backgroundColor: Colors.white,
      //   currentIndex: bottomselected,
      //   onTap: (value) => {
      //     print("on vient de cliquer sur le button numero $value"),
      //     setState(
      //       () => {
      //         bottomselected = value,
      //       },
      //     )
      //   },
      //   selectedLabelStyle: TextStyle(
      //     fontWeight: FontWeight.bold,
      //   ),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
