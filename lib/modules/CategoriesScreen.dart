import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_project/cubit/shopCubit.dart';
import 'package:shop_project/cubit/states.dart';
import 'package:shop_project/models/categoriesModels/categoriesModel.dart';
import 'package:shop_project/shared/constants.dart';

import 'categoryProductsScreen.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) => buildCategoriesItem(
                ShopCubit.get(context).categoriesModel!.data!.data[index],
                context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount:
                ShopCubit.get(context).categoriesModel!.data!.data.length);
      },
    );
  }

  Widget buildCategoriesItem(DataModel model, context) {
    return InkWell(
      onTap: () {
        ShopCubit.get(context).getCategoriesDetailData(model.id);
        navigateTo(context, CategoryProductsScreen(model.name));
      },
      child: Container(
        padding: EdgeInsets.all(15),
        child: Row(
          children: [
            Image(
              image: NetworkImage('${model.image}'),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            separator(15, 0),
            Text(
              '${model.name}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios_rounded),
            separator(10, 0),
          ],
        ),
      ),
    );
  }
}
