import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insta_job/bloc/bottom_bloc/bottom_bloc.dart';
import 'package:insta_job/bloc/global_cubit/global_cubit.dart';
import 'package:insta_job/screens/auth_screen/login_screen.dart';
import 'package:insta_job/screens/insta_recruit/splash_screen.dart';
import 'package:insta_job/screens/insta_recruit/user_type_screen.dart';
import 'package:insta_job/screens/insta_recruit/welcome_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GuestLoginInfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/svg/login.svg", height: 140,),
          const SizedBox(height: 20,),
          const Text("You need to login to use this functionality.", textAlign: TextAlign.center,),
          const SizedBox(height: 20,),
          CustomButton(title: "Login", height: 50, onTap: ()async{
            SharedPreferences pref = await SharedPreferences.getInstance();
            pref.setString("type", "user");
            var index = 3;
            context.read<GlobalCubit>().changeIndex(index);

            userType = "user";
            print("TYPE2-> $userType");
            AppRoutes.pushAndRemoveUntil(context, WelcomeScreen(onBackPressed: (BuildContext context){
                pref.remove("type");
                context.read<BottomBloc>().add(ResetIndex());
                AppRoutes.pushAndRemoveUntil(context, UserTypeScreen());
            },));
            
          },),
        ],
      ),
    );
  }
}