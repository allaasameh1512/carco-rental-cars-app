import 'constants.dart';
import 'package:flutter/material.dart';

class BrandList extends StatefulWidget {
  const BrandList({Key? key});

  @override
  State<BrandList> createState() => _BrandListState();
}

class _BrandListState extends State<BrandList> {
  int _brandCategoryindex = 0;

  var brandList = [
    {
      "name": "all",
      "icon": "",
    },
    {
      "name": "opel",
      "icon": "assets/logos/opel logo.png",
    },
    {
      "name": "toyota",
      "icon": "assets/logos/toyota logo.png",
    },
    {
      "name": "mercedes",
      "icon": "assets/logos/Mercedes logo.png",
    },
    {
      "name": "bmw",
      "icon": "assets/logos/bmw logo.png",
    },
  ];

  void setBrandIndex(int currentIndex) {
    setState(() {
      _brandCategoryindex = currentIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              'Brands',
              style: TextConstants.titleSection,
            ),
          ),
          Container(
            height: 100,
            width: double.infinity,
            child: ListView.builder(
              itemCount: brandList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return ElevatedButton(
                    onPressed: () {
                      setBrandIndex(index);
                      print(brandList[index]["name"]);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: (_brandCategoryindex == index)
                          ? Color.fromRGBO(0, 99, 124, 1)
                          : Colors.white,
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: Text(
                      "All",
                      style: TextConstants.titleSection,
                    ),
                  );
                } else {
                  return ElevatedButton(
                    onPressed: () {
                      setBrandIndex(index);
                      print(brandList[index]["name"]);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: (_brandCategoryindex == index)
                          ? Color.fromRGBO(0, 99, 124, 1)
                          : Colors.white,
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: Image.asset(
                      brandList[index]["icon"]!,
                      width: 70,
                      height: 70,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}