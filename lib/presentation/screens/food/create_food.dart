import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macro_tracker_2/constants/colors.dart';
import 'package:macro_tracker_2/constants/strings.dart';
import 'package:macro_tracker_2/data/helpers/firestore/food_repository.dart';
import 'package:macro_tracker_2/data/models/food_model.dart';

import '../../../data/helpers/auth_helper.dart';
import '../../widgets/textfield.dart';
import '../../widgets/toast.dart';

class CreateFood extends StatefulWidget {
  const CreateFood({Key? key}) : super(key: key);

  @override
  State<CreateFood> createState() => _CreateFoodState();
}

class _CreateFoodState extends State<CreateFood> {
  TextEditingController nameCont = TextEditingController();
  TextEditingController kcalCont = TextEditingController();
  TextEditingController proteinCont = TextEditingController();
  TextEditingController carbCont = TextEditingController();
  TextEditingController fatCont = TextEditingController();

  late String unit;

  @override
  void initState() {
    unit = Lists.units.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.main,
      appBar: AppBar(
        backgroundColor: ConstColors.sec,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          splashRadius: 20,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Create a food',
              style: TextStyle(
                color: Colors.white,
                fontFamily: "F",
              ),
            ),
            IconButton(
              onPressed: () async {
                if (int.parse(kcalCont.text) > 10000) {
                  toastBuilder('Food can\'t exceed 1000 kcal', context);
                }
                if (double.parse(proteinCont.text) * 4 +
                        double.parse(carbCont.text) * 4 +
                        double.parse(fatCont.text) * 9 >
                    int.parse(kcalCont.text)) {
                  toastBuilder(
                      'Macro nutrients are exceeding the calories in the food',
                      context);
                } else {
                  FoodRepository.instance.addFood(
                      context,
                      FoodModel(
                          name: nameCont.text,
                          kcal: int.parse(kcalCont.text),
                          unit: unit,
                          uid: AuthenticationHelper
                              .instance.auth.currentUser!.uid,
                          protein: double.parse(proteinCont.text),
                          carb: double.parse(carbCont.text),
                          fat: double.parse(fatCont.text)));
                  Navigator.pop(context);
                }
              },
              icon: const Icon(
                Icons.done,
                color: Colors.white,
              ),
              splashRadius: 20,
            )
          ],
        ),
      ),
      body: Column(
        children: [
          UnderLineTextField(
            label: "Food name",
            keyboard: TextInputType.text,
            controller: nameCont,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.ideographic,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: UnderLineTextField(
                  label: "Calories",
                  keyboard: TextInputType.number,
                  controller: kcalCont,
                ),
              ),
              DropdownButton<String>(
                value: unit,
                icon: const Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color: Colors.white54,
                ),
                elevation: 16,
                dropdownColor: Colors.grey[800],
                style: const TextStyle(color: Colors.white, fontFamily: "F"),
                underline: Container(
                  height: 1,
                  color: Colors.greenAccent,
                ),
                onChanged: (String? value) {
                  unit = value!;
                  setState(() {});
                },
                items: Lists.units.map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
              ),
              const SizedBox(
                width: 1,
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: UnderLineTextField(
                  label: "Protein",
                  keyboard:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: proteinCont,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: UnderLineTextField(
                  label: "Carb",
                  keyboard:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: carbCont,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: UnderLineTextField(
                  label: "Fat",
                  keyboard:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: fatCont,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
