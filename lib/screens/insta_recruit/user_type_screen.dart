// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/global_cubit/global_cubit.dart';
import 'package:insta_job/model/user_model.dart';
import 'package:insta_job/screens/insta_recruit/welcome_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/custom_cards/custom_user_type_card.dart';

import '../../bloc/global_cubit/global_state.dart';

String userType = "";

class UserTypeScreen extends StatefulWidget {
  const UserTypeScreen({Key? key}) : super(key: key);

  @override
  State<UserTypeScreen> createState() => _UserTypeScreenState();
}

class _UserTypeScreenState extends State<UserTypeScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    var selectedIndex = context.watch<GlobalCubit>().sIndex;
    return Scaffold(
        backgroundColor: MyColors.white,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(MyImages.bg_search_girl),
                  fit: BoxFit.cover)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 70),
              Center(
                child: CommonText(
                  text: "Welcome",
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Image.asset(
                  MyImages.logo,
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fitHeight,
                ),
              ),
              BlocBuilder<GlobalCubit, InitialState>(builder: (context, state) {
                return Row(
                  children: [
                    Expanded(
                        child: UserTypeCard(
                      onTap: () {
                        index = 2;
                        context.read<GlobalCubit>().changeIndex(index);
                        UserModel userModel = UserModel();
                        userModel.type = "recruiters";
                        userType = userModel.type!;
                        print("TYPE2-> $userType");
                        AppRoutes.push(context, WelcomeScreen());
                      },
                      image: MyImages.businessAndTrade,
                      title: "Recruiters",
                      index: 2,
                      selectedIndex: selectedIndex,
                    )),
                    Expanded(
                        child: UserTypeCard(
                      onTap: () {
                        index = 3;
                        context.read<GlobalCubit>().changeIndex(index);
                        UserModel userModel = UserModel();
                        userModel.type = "user";
                        userType = userModel.type!;
                        print("TYPE2-> $userType");
                        setState(() {});
                        AppRoutes.push(context, WelcomeScreen());
                      },
                      image: MyImages.suitcase,
                      index: 3,
                      selectedIndex: selectedIndex,
                      title: "Job Search",
                    )),
                  ],
                );
              }),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 29.0, bottom: 20),
                child: Column(
                  children: [
                    Image.asset(MyImages.instaLogo_),
                    SizedBox(height: 5),
                    CommonText(
                      text: "Employ instantly",
                      // fontWeight: FontWeight.bold,
                      fontColor: MyColors.grey,
                      fontSize: 13,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
