class RecipeModel {
  late String applabel;
  late String appimgurl;
  late double appcalories;
  late String appurl;
  late double apptotaltime;
  late String appSource;
  late double appTotalWeigth;
  late List appingredients;

  RecipeModel({
    this.applabel = "Label",
    this.appimgurl = "image",
    this.appcalories = 2.000,
    this.apptotaltime = 60,
    this.appurl = "url",
    this.appSource = "serious",
    this.appTotalWeigth = 23232.23,
    required this.appingredients,
  });

  factory RecipeModel.fromMap(Map recipe) {
    return RecipeModel(
      applabel: recipe["label"],
      appcalories: recipe["calories"],
      appimgurl: recipe["image"],
      appurl: recipe["url"],
      apptotaltime: recipe["totalTime"],
      appSource: recipe["source"],
      appTotalWeigth: recipe["totalWeight"],
      appingredients: recipe["ingredientLines"],
    );
  }
}
