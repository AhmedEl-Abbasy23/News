import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/module/business_screen/business_screen.dart';
import 'package:news/module/science_screen/science_screen.dart';
import 'package:news/module/sports_screen/sports_screen.dart';
import 'package:news/module/technology_screen/technology_screen.dart';
import 'package:news/shared/cubit/states.dart';
import 'package:news/shared/network/local/cache_helper.dart';
import 'package:news/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.work,
      ),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.computer,
      ),
      label: 'Technology',
    ),
  ];

  void changeIndex(index) {
    currentIndex = index;
    if (currentIndex == 1) getSportsData();
    if (currentIndex == 2) getScienceData();
    if (currentIndex == 3) getTechnologyData();
    emit(NewsBottomNavBarState());
  }

  bool isDark = false;

  void changeMode({bool? fromSharedPref}) {
    if (fromSharedPref != null) {
      isDark = fromSharedPref;
      emit(NewsChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(NewsChangeModeState());
      }).catchError((error) {
        // ignore: avoid_print
        print(error.toString());
      });
    }
  }

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    TechnologyScreen(),
  ];
  List<dynamic> businessData = [];
  List<dynamic> sportsData = [];
  List<dynamic> scienceData = [];
  List<dynamic> technologyData = [];
  List<dynamic> searchData = [];

  void getBusinessData() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '65c24ae726ee4fbd93e6f967b1519c9d',
      },
    ).then((value) {
      businessData = value.data['articles'];
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      emit(NewsGetBusinessErrorState(error.toString()));
      // ignore: avoid_print
      print(error.toString());
    });
  }

  void getSportsData() {
    emit(NewsGetSportsLoadingState());
    if (sportsData.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': '65c24ae726ee4fbd93e6f967b1519c9d',
        },
      ).then((value) {
        sportsData = value.data['articles'];
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        emit(NewsGetSportsErrorState(error.toString()));
        print(error.toString());
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  void getScienceData() {
    emit(NewsGetScienceLoadingState());

    if (scienceData.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': '65c24ae726ee4fbd93e6f967b1519c9d',
        },
      ).then((value) {
        scienceData = value.data['articles'];
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        emit(NewsGetScienceErrorState(error.toString()));
        print(error.toString());
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  void getTechnologyData() {
    emit(NewsGetTechnologyLoadingState());
    if (technologyData.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'technology',
          'apiKey': '65c24ae726ee4fbd93e6f967b1519c9d',
        },
      ).then((value) {
        technologyData = value.data['articles'];
        emit(NewsGetTechnologySuccessState());
      }).catchError((error) {
        emit(NewsGetTechnologyErrorState(error.toString()));
        print(error.toString());
      });
    } else {
      emit(NewsGetTechnologySuccessState());
    }
  }

  void getSearchData(String value) {
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': value,
        'apiKey': '65c24ae726ee4fbd93e6f967b1519c9d',
      },
    ).then((value) {
      searchData = value.data['articles'];
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      emit(NewsGetSearchErrorState(error.toString()));
      // ignore: avoid_print
      print(error.toString());
    });
  }
}
