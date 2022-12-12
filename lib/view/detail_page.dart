// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:recipe_app/model/model.dart';

class Detail extends StatefulWidget {
  final RecipeModel url;

  const Detail({super.key, required this.url});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Card(
            child: Stack(
              children: [
                Hero(
                  tag: widget.url,
                  child: Container(
                    height: size.height * 0.55,
                    child: Image.network(
                      widget.url.appimgurl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                DraggableScrollableSheet(
                    maxChildSize: 1,
                    initialChildSize: 0.6,
                    minChildSize: 0.6,
                    builder: (context, scrollController) {
                      return SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.all(35),
                          height: 800,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.url.applabel,
                                      style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "By ${widget.url.appSource}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border:
                                              Border.all(color: Colors.grey),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Column(
                                          children: [
                                            const Text(
                                              "Timer",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 146, 142, 142)),
                                            ),
                                            Text(
                                              "${widget.url.apptotaltime.round()} min",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 34, 33, 33)),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border:
                                              Border.all(color: Colors.grey),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Column(
                                          children: [
                                            const Text(
                                              "Calories",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 146, 142, 142)),
                                            ),
                                            Text(
                                              "${widget.url.appcalories.round().toString()} Kcal",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 34, 33, 33)),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border:
                                              Border.all(color: Colors.grey),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Column(
                                          children: [
                                            const Text(
                                              "Tota Weight",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 146, 142, 142)),
                                            ),
                                            Text(
                                              "${widget.url.appTotalWeigth.round()} g",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 34, 33, 33)),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                "Ingredients",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                child: Text(
                                  widget.url.appingredients.join(", \n\n"),
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
