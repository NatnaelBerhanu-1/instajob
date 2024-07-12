// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/check_kyc_availability/check_kyc_availability_bloc.dart';
import 'package:insta_job/bloc/check_kyc_availability/check_kyc_availability_state.dart';
import 'package:insta_job/bloc/company_bloc/company_bloc.dart';
import 'package:insta_job/bloc/company_bloc/company_event.dart';
import 'package:insta_job/bloc/company_bloc/company_state.dart';
import 'package:insta_job/bloc/job_position/job_poision_bloc.dart';
import 'package:insta_job/bloc/job_position/job_pos_event.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/screens/bank_info/add_bank_info_screen.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/search_pages/add_new_company.dart';
import 'package:insta_job/screens/insta_recruit/send_money/send_money_bottom_sheet_child.dart';
import 'package:insta_job/screens/kyc/upload_kyc_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_app_bar.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_cards/assign_companies_tile.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/custom_divider.dart';
import 'package:insta_job/widgets/custom_text_field.dart';

import '../../../../bloc/bottom_bloc/bottom_bloc.dart';
import 'search_company.dart';

class AssignCompany extends StatefulWidget {
  const AssignCompany({Key? key}) : super(key: key);

  @override
  State<AssignCompany> createState() => _AssignCompanyState();
}

class _AssignCompanyState extends State<AssignCompany> {
  @override
  void initState() {
    super.initState();
    context.read<CompanyBloc>().add(LoadCompanyListEvent());
    context.read<JobPositionBloc>().add(
        LoadJobPosListEvent()); //TODO: double check if this is necessary, IDTS
    String userId = (Global.userModel?.id  ?? "").toString();
    context.read<CheckKycAvailabilityCubit>().execute(userId: userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, kToolbarHeight),
          child: CustomAppBar(
            onTap: () {},
            leadingImage: "",
            title: "Assigned Companies",
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: MyColors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: BlocBuilder<CompanyBloc, CompanyState>(builder: (context, state) {
                          return Column(
                            children: [
                              IconTextField(
                                readOnly: true,
                                hint: "Search Companies",
                                color: MyColors.lightgrey,
                                borderRadius: 25,
                                prefixIcon: ImageButton(
                                  image: MyImages.searchGrey,
                                  color: MyColors.userFont,
                                  padding: EdgeInsets.all(14),
                                  height: 10,
                                  width: 10,
                                ),
                                onPressed: () {
                                  AppRoutes.push(context, SearchCompany());
                                },
                              ),
                            ],
                          );
                        }),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                          flex: 0,
                          child: CustomCommonCard(
                            onTap: () {
                              context.read<BottomBloc>().add(SetScreenEvent(true, screenName: AddNewCompany()));
                              // context.read<BottomCubit>().setSelectedScreen(
                              //     true,
                              //     screenName: AddNewCompany());
                              // AppRoutes.push(context, AddNewCompany());
                            },
                            borderRadius: BorderRadius.circular(40),
                            bgColor: MyColors.blue,
                            child: Padding(
                              padding: const EdgeInsets.all(9.0),
                              child: Icon(
                                Icons.add,
                                color: MyColors.white,
                              ),
                            ),
                          )
                          // FloatingActionButton(
                          //   backgroundColor: MyColors.blue,
                          //   elevation: 0,
                          //   onPressed: () {},
                          //   child: Icon(Icons.add),
                          // ),
                          )
                    ],
                  ),
                ),
              ),
              divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 20),
                child: BlocBuilder<CheckKycAvailabilityCubit, 
                  CheckKycAvailabilityState>(
                  builder: (context, state) {
                    // if (state is CheckKycAvailabilityNotFound) {
                    // }
                    debugPrint("STATE: $state");
                    return CustomButton(
                      // width: 240,
                      height: 50,
                      loading: false,
                      loadingIndicatorHeight: 22,
                      loadingIndicatorWidth: 22,
                      loadingIndicatorSeparatorWidth: 8,
                      onTap: () {
                        if (state is CheckKycAvailabilityFound) {
                          showPaymentFlowBottomSheet(context);
                        } else if (state is CheckKycAvailabilityNotFound) {
                          AppRoutes.push(context, UploadKycScreen());
                        } else if (state is CheckKycAvailabilityErrorState) {
                          AppRoutes.push(context, UploadKycScreen());
                        } else { //loading, initial state etc
                        }
                
                            },
                      title: "Pay your employees",
                    );
                  }
                ),
              ),
              SizedBox(height: 10,),
              BlocBuilder<CompanyBloc, CompanyState>(builder: (context, state) {
                if (state is CompanyLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is ErrorState) {
                  // showToast(state.error);
                  return Center(child: Text(state.error));
                }
                if (state is CompanyLoaded) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.companyList.length,
                      itemBuilder: (c, i) {
                        var data = context.read<CompanyBloc>();
                        data.companyModel = state.companyList[i];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 20),
                          child: AssignCompaniesTile(
                            companyModel: data.companyModel,
                          ),
                        );
                      });
                }
                return Container();
              }),
              // showPaymentRelatedScreensTempButton(context),
              // showKycRelatedScreensTempButton(context),
              // showAddBankingInfoScreensTempButton(context),
            ],
          ),
        ));
  }
}


  TextButton showAddBankingInfoScreensTempButton(BuildContext context) {
    return TextButton(
            onPressed: () {
              AppRoutes.push(context, AddBankInfoScreen());
            },
            child: Text("Add Banking Info screens"),
          );
  }

  TextButton showKycRelatedScreensTempButton(BuildContext context) {
    return TextButton(
            onPressed: () {
              AppRoutes.push(context, UploadKycScreen());
            },
            child: Text("Kyc related screens"),
          );
  }

  TextButton showPaymentRelatedScreensTempButton(BuildContext context) {
    return TextButton(
            onPressed: () {
              showPaymentFlowBottomSheet(context);
            },
            child: Text("Payment related screens"),
          );
  }

  Future<dynamic> showPaymentFlowBottomSheet(BuildContext context) {
    return showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              // isDismissible: true,
              showDragHandle: true, 
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              builder: (context) {
                return Builder(
                    // return DraggableScrollableSheet(
                    // initialChildSize: 0.75,
                    // maxChildSize: 0.75,
                    // minChildSize: 0.75,
                    // builder: (BuildContext context, ScrollController scrollController) {
                    builder: (BuildContext context) {
                  return SendMoneyBottomSheetChild();
                });
              },
            );
  }