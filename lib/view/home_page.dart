// ignore_for_file: sized_box_for_whitespace

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:http/http.dart';

import 'package:recipe_app/model/model.dart';
import 'package:recipe_app/view/detail_page.dart';
import 'package:recipe_app/view/search.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoaded = true;
  List<RecipeModel> recipeList = <RecipeModel>[];
  TextEditingController searchController = TextEditingController();
  List<RecipeModel> recipeRecommended = <RecipeModel>[];

  getRecipes(String query) async {
    String url =
        "https://api.edamam.com/search?q=$query&app_id=ebb6041c&app_key=3c33ad913ab23b8554082bfb5fdd78b5";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    setState(() {
      data["hits"].forEach((element) {
        RecipeModel recipeModel = RecipeModel(appingredients: []);
        recipeModel = RecipeModel.fromMap(element["recipe"]);
        recipeList.add(recipeModel);

        setState(() {
          isLoaded = false;
        });
      });

      log(recipeList.toString());
    });

    for (var Recipe in recipeList) {
      print(Recipe.applabel);
      print(Recipe.appcalories);
    }
  }

  getRecommended() async {
    String url =
        "https://api.edamam.com/search?q=recommended&app_id=ebb6041c&app_key=3c33ad913ab23b8554082bfb5fdd78b5";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    setState(() {
      data["hits"].forEach((element) {
        RecipeModel recipeModel = RecipeModel(appingredients: []);
        recipeModel = RecipeModel.fromMap(element["recipe"]);
        recipeRecommended.add(recipeModel);
        setState(() {
          isLoaded = false;
        });
        log(recipeRecommended.toString());
      });
    });

    for (var Recipe in recipeRecommended) {
      print(Recipe.applabel);
      print(Recipe.appcalories);
    }
  }

  @override
  void initState() {
    super.initState();
    getRecipes("Recipe");
    getRecommended();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoaded
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0x00ffffff), Color(0x00ffffff)]),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      //Search Bar
                      SafeArea(
                        child: Container(
                          //Search Wala Container

                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 20),
                          decoration: BoxDecoration(
                              color: const Color(0xffF1F1F1),
                              borderRadius: BorderRadius.circular(24)),
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(3, 0, 7, 0),
                                child: const Icon(
                                  Icons.search,
                                  color: Color(0xff181818),
                                  size: 25,
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  onEditingComplete: () {
                                    if ((searchController.text)
                                            .replaceAll(" ", "") ==
                                        "") {
                                      print("Blank search");
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Search(
                                                  searchController.text)));
                                    }
                                  },
                                  controller: searchController,
                                  decoration: const InputDecoration(
                                      fillColor: Color(0xffF1F1F1),
                                      filled: true,
                                      border: InputBorder.none,
                                      hintText: "Search for your query",
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      )),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "What would you like to Cook?",
                              style: TextStyle(
                                  fontSize: 33,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //     child: isLoaded
                      //         ? const CircularProgressIndicator()
                      //         : ListView.builder(
                      //             physics: const NeverScrollableScrollPhysics(),
                      //             shrinkWrap: true,
                      //             itemCount: recipeList.length,
                      //             itemBuilder: (context, index) {
                      //               return InkWell(
                      //                 onTap: () {},
                      //                 child: Card(
                      //                   margin: const EdgeInsets.all(20),
                      //                   shape: RoundedRectangleBorder(
                      //                     borderRadius: BorderRadius.circular(10),
                      //                   ),
                      //                   elevation: 0.0,
                      //                   child: Stack(
                      //                     children: [
                      //                       ClipRRect(
                      //                           borderRadius:
                      //                               BorderRadius.circular(10.0),
                      //                           child: Image.network(
                      //                             recipeList[index].appimgurl,
                      //                             fit: BoxFit.cover,
                      //                             width: double.infinity,
                      //                             height: 200,
                      //                           )),
                      //                       Positioned(
                      //                           left: 0,
                      //                           right: 0,
                      //                           bottom: 0,
                      //                           child: Container(
                      //                               padding:
                      //                                   const EdgeInsets.symmetric(
                      //                                       vertical: 5,
                      //                                       horizontal: 10),
                      //                               decoration: const BoxDecoration(
                      //                                   color: Colors.black26),
                      //                               child: Text(
                      //                                 recipeList[index].applabel,
                      //                                 style: const TextStyle(
                      //                                     color: Colors.white,
                      //                                     fontSize: 20),
                      //                               ))),
                      //                       Positioned(
                      //                         right: 0,
                      //                         height: 40,
                      //                         width: 80,
                      //                         child: Container(
                      //                             decoration: const BoxDecoration(
                      //                                 color: Colors.white,
                      //                                 borderRadius: BorderRadius.only(
                      //                                     topRight:
                      //                                         Radius.circular(10),
                      //                                     bottomLeft:
                      //                                         Radius.circular(10))),
                      //                             child: Center(
                      //                               child: Row(
                      //                                 mainAxisAlignment:
                      //                                     MainAxisAlignment.center,
                      //                                 children: [
                      //                                   const Icon(
                      //                                     Icons.local_fire_department,
                      //                                     size: 15,
                      //                                   ),
                      //                                   Text(recipeList[index]
                      //                                       .appcalories
                      //                                       .toString()
                      //                                       .substring(0, 6)),
                      //                                 ],
                      //                               ),
                      //                             )),
                      //                       )
                      //                     ],
                      //                   ),
                      //                 ),
                      //               );
                      //             })),
                      Container(
                        padding: const EdgeInsets.only(left: 18, top: 5),
                        alignment: Alignment.bottomLeft,
                        child: const Text(
                          "Today Recipe",
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 300,
                        child: ListView.builder(
                            itemCount: recipeList.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final url = recipeList[index];

                              return Container(
                                  child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Detail(
                                            url: url,
                                          )));
                                },
                                child: Card(
                                  margin: const EdgeInsets.all(20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  elevation: 0.0,
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        child: Image.network(
                                          recipeList[index].appimgurl,
                                          fit: BoxFit.cover,
                                          width: 200,
                                          height: 300,
                                        ),
                                      ),
                                      Positioned(
                                          left: 0,
                                          right: 0,
                                          bottom: 0,
                                          top: 0,
                                          child: Column(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5,
                                                        horizontal: 10),
                                                decoration: const BoxDecoration(
                                                    color: Colors.black54),
                                                child: Text(
                                                  textAlign: TextAlign.center,
                                                  recipeList[index].applabel,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 19),
                                                ),
                                              ),
                                            ],
                                          )),
                                      Positioned(
                                        bottom: 0,
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: const BoxDecoration(
                                              color: Color(0xffC7BCA1),
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10))),
                                          child: Center(
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.local_fire_department,
                                                  size: 15,
                                                ),
                                                Text(
                                                  textAlign: TextAlign.left,
                                                  "${recipeList[index].appcalories.round().toString()} Kcal",
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 19),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: const BoxDecoration(
                                              color: Color(0xffC7BCA1),
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10))),
                                          child: Center(
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.timer,
                                                  size: 15,
                                                ),
                                                Text(
                                                  textAlign: TextAlign.left,
                                                  "${recipeList[index].apptotaltime.round().toString()} min",
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 19),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                            }),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 18, top: 5),
                        alignment: Alignment.bottomLeft,
                        child: const Text(
                          "Recommended",
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: recipeRecommended.length,
                              itemBuilder: (context, index) {
                                final url = recipeRecommended[index];

                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => Detail(
                                                  url: url,
                                                )));
                                  },
                                  child: Card(
                                    margin: const EdgeInsets.all(20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 0.0,
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Image.network(
                                              recipeRecommended[index]
                                                  .appimgurl,
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              height: 200,
                                            )),
                                        Positioned(
                                            left: 0,
                                            right: 0,
                                            bottom: 0,
                                            child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5,
                                                        horizontal: 10),
                                                decoration: const BoxDecoration(
                                                    color: Colors.black54),
                                                child: Text(
                                                  recipeRecommended[index]
                                                      .applabel,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                ))),
                                        Positioned(
                                          right: 0,
                                          height: 40,
                                          width: 80,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                                color: Color(0xffC7BCA1),
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10))),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Icon(
                                                    Icons.local_fire_department,
                                                    size: 15,
                                                  ),
                                                  Text(
                                                      "${recipeRecommended[index].appcalories.round().toString()} Kcal"),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 0,
                                          height: 40,
                                          width: 80,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                                color: Color(0xffC7BCA1),
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10))),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Icon(
                                                    Icons.timer,
                                                    size: 15,
                                                  ),
                                                  Text(
                                                      "${recipeRecommended[index].apptotaltime.round().toString()} min"),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
