import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/shared/components/components.dart';
import 'package:news/shared/cubit/cubit.dart';
import 'package:news/shared/cubit/states.dart';

class BusinessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).businessData;
        return articleBuilder(list,context);
      },
    );
  }
}

/*ConditionalBuilder(
condition: state is! NewsGetBusinessLoadingState,
builder: (BuildContext context) => ListView.separated(
itemBuilder: (context, index) => buildArticleItem(),
separatorBuilder: (context, index) => Padding(
padding: const EdgeInsets.symmetric(horizontal: 10.0),
child: Container(
height: 3,
width: double.infinity,
color: Colors.grey,
),
),
itemCount: 10,
),
fallback: (BuildContext context) =>
Center(child: CircularProgressIndicator()),
);*/
