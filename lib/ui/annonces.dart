import 'package:flutter/material.dart';

class Annonces extends StatefulWidget {
  // static const List<String> srcs=["https://www.c3editions.com/sites/default/files/styles/manual_crop_640_672/public/slider%20welcome%20mobile.jpg","b"];
  const Annonces({Key? key}) : super(key: key);

  @override
  _AnnoncesState createState() => _AnnoncesState();
}

class _AnnoncesState extends State<Annonces> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: 350,
      width: size.width,
      // color: Colors.black,
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Text(
                    "Annonces",
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
                    onPressed: () {},
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
            height: 300,
            child: PageView.builder(
              itemBuilder: (context, index) {
                var indices = index + 1;
                return Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  height: 200,
                  margin: EdgeInsets.only(left: 10, right: index == 9 ? 10 : 0),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset(
                    "asset/img$indices.jpeg",
                    fit: BoxFit.fill,
                  ),
                );
              },
              itemCount: 8,
              scrollDirection: Axis.horizontal,
            ),
          )
        ],
      ),
    );
  }
}
