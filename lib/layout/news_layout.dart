import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/module/search_screen/search_screen.dart';
import 'package:news/shared/components/components.dart';
import 'package:news/shared/cubit/cubit.dart';
import 'package:news/shared/cubit/states.dart';

// ignore: use_key_in_widget_constructors
class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('News'),
            titleSpacing: 18.0,
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(context,SearchScreen());
                },
                icon: const Icon(
                  Icons.search,
                ),
              ),
              IconButton(
                onPressed: (){
                  cubit.changeMode();
                },
                icon: const Icon(
                  Icons.brightness_4_outlined,
                ),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeIndex(index);
            },
            currentIndex: cubit.currentIndex,
            items: cubit.bottomItems,
          ),
        );
      },
    );
  }
}
