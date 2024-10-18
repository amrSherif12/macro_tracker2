import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:macro_tracker_2/data/helpers/auth_helper.dart';

import '../../../constants/colors.dart';
import '../../../data/models/food_model.dart';
import '../../../logic/food/food_cubit.dart';
import '../../widgets/food_tile.dart';

class FoodTab extends StatefulWidget {
  final Function refresh;
  const FoodTab({super.key, required this.refresh});

  @override
  State<FoodTab> createState() => _FoodTabState();
}

class _FoodTabState extends State<FoodTab> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodCubit, FoodState>(
      builder: (context, state) {
        if (state is FoodLoaded) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return Column(
                children: [
                  index == 0
                      ? const SizedBox(
                          height: 20,
                        )
                      : const SizedBox(),
                  BlocProvider(
                    create: (context) => FoodCubit(),
                    child: FoodTile(
                      food: FoodModel(
                          id: state.food[index].id!,
                          food: state.food[index].food,
                          kcal: state.food[index].kcal,
                          uid: state.food[index].uid,
                          unit: state.food[index].unit),
                      refresh: widget.refresh,
                    ),
                  ),
                ],
              );
            },
            itemCount: state.food.length,
          );
        } else if (state is FoodNoData) {
          return Center(
              child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 350,
                  child: Image.asset('assets/imgs/nofood.png'),
                ),
                const Text(
                  'No Food Saved',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'f',
                  ),
                ),
                const Text(
                  'You can save food by creating or searching it.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'f',
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ));
        } else if (state is FoodNoInternet) {
          return Center(
              child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 350,
                  child: Image.asset('assets/imgs/nointernet.png'),
                ),
                const Text(
                  'No Internet',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'f',
                  ),
                ),
                const Text(
                  'Try reloading the page or checking you internet connection.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'f',
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ));
        } else {
          return Center(
              child: LoadingAnimationWidget.discreteCircle(
                  color: ConstColors.secMid,
                  size: 30,
                  secondRingColor: ConstColors.secMidOff,
                  thirdRingColor: ConstColors.secOff));
        }
      },
    );
  }
}