import 'package:cloud_firestore/cloud_firestore.dart';

class DayModel {
  DateTime date;
  int kcalConsumed;
  int kcalGoal;
  int kcalBurned;
  double proteinCons;
  double proteinGoal;
  double carbCons;
  double carbGoal;
  double fatCons;
  double fatGoal;
  bool isFree;
  Map breakfastFood;
  Map breakfastRecipes;
  Map lunchFood;
  Map lunchRecipes;
  Map dinnerFood;
  Map dinnerRecipes;
  Map snacksFood;
  Map snacksRecipes;
  Map exercises;

  DayModel({
    required this.date,
    required this.kcalConsumed,
    required this.kcalGoal,
    required this.kcalBurned,
    required this.proteinCons,
    required this.proteinGoal,
    required this.carbCons,
    required this.carbGoal,
    required this.fatCons,
    required this.fatGoal,
    required this.isFree,
    required this.breakfastFood,
    required this.breakfastRecipes,
    required this.lunchFood,
    required this.lunchRecipes,
    required this.dinnerFood,
    required this.dinnerRecipes,
    required this.snacksFood,
    required this.snacksRecipes,
    required this.exercises,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'kcalGoal': kcalGoal,
      'kcalConsumed': kcalConsumed,
      'kcalBurned': kcalBurned,
      'proteinCons': proteinCons,
      'proteinGoal': proteinGoal,
      'carbCons': carbCons,
      'carbGoal': carbGoal,
      'fatCons': fatCons,
      'fatGoal': fatGoal,
      'isFree': isFree,
      'breakfastFood': breakfastFood,
      'breakfastRecipes': breakfastRecipes,
      'lunchFood': lunchFood,
      'lunchRecipes': lunchRecipes,
      'dinnerFood': dinnerFood,
      'dinnerRecipes': dinnerRecipes,
      'snacksFood': snacksFood,
      'snacksRecipes': snacksRecipes,
      'exercises': exercises,
    };
  }

  static DayModel fromMap(DocumentSnapshot map) {
    return DayModel(
      date: map["date"].toDate(),
      kcalConsumed: map["kcalConsumed"],
      kcalGoal: map["kcalGoal"],
      kcalBurned: map["kcalBurned"],
      proteinCons: map["proteinCons"],
      proteinGoal: map["proteinGoal"],
      carbCons: map["carbCons"],
      carbGoal: map["carbGoal"],
      fatCons: map["fatCons"],
      fatGoal: map["fatGoal"],
      isFree: map["isFree"],
      breakfastFood: map["breakfastFood"],
      breakfastRecipes: map["breakfastRecipes"],
      lunchFood: map["lunchFood"],
      lunchRecipes: map["lunchRecipes"],
      dinnerFood: map["dinnerFood"],
      dinnerRecipes: map["dinnerRecipes"],
      snacksFood: map["snacksFood"],
      snacksRecipes: map["snacksRecipes"],
      exercises: map["exercises"],
    );
  }
}
