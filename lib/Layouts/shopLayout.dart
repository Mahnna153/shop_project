import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_project/cubit/shopCubit.dart';
import 'package:shop_project/cubit/states.dart';
import 'package:shop_project/modules/SearchScreen.dart';
import 'package:shop_project/shared/constants.dart';

class ShopLayout extends StatelessWidget {
  bool showBottomSheet = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is HomeSuccessState)
          int cartLen = ShopCubit.get(context).cartModel.data!.cartItems.length;
      },
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 10,
            title: Row(
              children: [
                Text('Shop App :)'),
              ],
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context, SearchScreen(ShopCubit.get(context)));
                  },
                  icon: Icon(Icons.search)),
            ],
          ),
          bottomSheet: showBottomSheet
              ? ShopCubit.get(context).cartModel.data!.cartItems.length != 0
                  ? Container(
                      width: double.infinity,
                      height: 60,
                      color: Colors.white,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: ElevatedButton(
                        onPressed: () {},
                        //shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                        child: Text(
                          'Check Out',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      width: 0,
                      height: 0,
                    )
              : Container(
                  width: 0,
                  height: 0,
                ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.navBar,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              if (index == 3)
                showBottomSheet = true;
              else if (ShopCubit.get(context)
                      .cartModel
                      .data!
                      .cartItems
                      .length ==
                  0)
                showBottomSheet = false;
              else
                showBottomSheet = false;
              return cubit.changeBottomNav(index);
            },
          ),
        );
      },
    );
  }
}
