import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/get_hired_job_position/get_hired_candidates_bloc.dart';
import 'package:insta_job/bloc/get_hired_job_position/get_hired_candidates_state.dart';
import 'package:insta_job/bloc/get_payment_link_bloc/get_payment_link_bloc.dart';
import 'package:insta_job/bloc/get_payment_link_bloc/get_payment_link_state.dart';
import 'package:insta_job/model/hired_candidate.dart';
import 'package:insta_job/model/payment_user.dart';
import 'package:insta_job/screens/insta_recruit/send_money/amount_page.dart';
import 'package:insta_job/screens/insta_recruit/send_money/payment_user_tile.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/debouncer.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_text_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SendMoneyBottomSheetChild extends StatefulWidget {
  const SendMoneyBottomSheetChild({super.key});

  @override
  State<SendMoneyBottomSheetChild> createState() => _SendMoneyBottomSheetChildState();
}

class _SendMoneyBottomSheetChildState extends State<SendMoneyBottomSheetChild> {
  // final debouncer = Debouncer(milliseconds: 1000);
  final debouncer = Debouncer(milliseconds: 10);
  final TextEditingController searchController = TextEditingController();
  var users = [];
  // var searchResults = []; //for search results
  var searchResults = []; //for search results
  int? selectedUserIndexFromRecentUsers;
  int? selectedUserIndexFromSearchResults;
  
  get userIsSelected {
    var res = selectedUserIndexFromRecentUsers != null || selectedUserIndexFromSearchResults != null;
    return res;
  }
  HiredCandidate? get selectedUser {
    if (selectedUserIndexFromRecentUsers != null) {
      return users[selectedUserIndexFromRecentUsers!];
    } else if (selectedUserIndexFromSearchResults != null) {
      return searchResults[selectedUserIndexFromSearchResults!];
    }
    return null;
  }
  
  @override
  void initState() {
    super.initState();
    context.read<GetHiredCandidatesCubit>().execute();
  }

  
  void updateSelectedUser(value) {
    setState(() {
      selectedUserIndexFromRecentUsers = value;
    });
  }
  


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12).copyWith(top: 0)
          .copyWith(top: 0),
      height: MediaQuery.of(context).size.height * 0.84,
      child: BlocBuilder<GetHiredCandidatesCubit, GetHiredCandidatesState>(
          builder: (context, state) {
            if (state is GetHiredCandidatesLoaded) {
              users = state.hiredList;
              searchResults = state.hiredList;
            }
          return SingleChildScrollView(
            child: Column(children: [
              const Text(
                "Send Money",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Choose an employee to continue",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: MyColors.greyTxt,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              BlocConsumer<GetPaymentLinkCubit, GetPaymentLinkState>(listener: (context, state) {
                debugPrint('State: $state');
                if (state is GetPaymentLinkLoaded) {
                  var link = state.linkUrl; 
                  showModalBottomSheet(
                    context: context, 
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
                    ),
                    //enableDrag: true,
                    isScrollControlled: true,
                    showDragHandle: true,
                    builder:(context) => _openLinkInBottomSheet(context, link),
                  );
                }
              }, builder: (context, state) {
                return CustomIconButton(
                  image: MyImages.arrowWhite,
                  title: "Pay",
                  backgroundColor: MyColors.blue,
                  fontColor: MyColors.white,
                  loading: state is GetPaymentLinkLoading ? true : false,
                  borderColor: MyColors.blue,
                  iconColor: MyColors.white,
                  onclick: () async {
                    context.read<GetPaymentLinkCubit>().getPaymentLink('1', '1', 1000);
                  },
                );
              }), 
              const SizedBox(height: 20,),
              IconTextField(
                controller: searchController,
                prefixIcon: ImageButton(
                  image: MyImages.searchGrey,
                  padding: const EdgeInsets.all(14),
                  height: 10,
                  width: 10,
                ),
                borderRadius: 25,
                hint: "search",
                onChanged: (value) {
                  debouncer.run(() {
                    debugPrint("value $value");
                    searchController.text = value;
                    selectedUserIndexFromRecentUsers = null; // nothing is selected when search text field is updating, selectedItem(if any) goes unselected
                    selectedUserIndexFromSearchResults = null; // nothing is selected when search text field is updating, selectedItem(if any) goes unselected
                    setState(() {});
                  });
                },
              ),
              if (state is GetHiredCandidatesLoading) 
               const Column(
                 children: [
                  SizedBox(height: 50,),
                   Center(child: CircularProgressIndicator()),
                 ],
               ),
              if (state is GetHiredCandidatesLoaded) 
                Column(
                  children: [
                    if (searchController.text.isEmpty)
                      Column(
                        mainAxisSize: MainAxisSize.min,//remove ig june
                        children: [
                          const SizedBox(height: 16,),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                // _buildEmployeeAvatarAndName(),
                                // _buildEmployeeAvatarAndName(),
                                // _buildEmployeeAvatarAndName(isSelected: true),
                                // _buildEmployeeAvatarAndName(),
                                // _buildEmployeeAvatarAndName(),
                                ...users.asMap().entries.map((item) => _buildEmployeeAvatarAndName(hiredCandidate: item.value, currentIdx: item.key, isSelected: selectedUserIndexFromRecentUsers == item.key, updateSelectedUser: updateSelectedUser)).toList(),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24,),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Recent Transactions",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16,),
                          ListView.separated(
                            itemCount: 4,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            separatorBuilder: (context, state) {
                              return const SizedBox(height: 12);
                            },
                            itemBuilder: (context, index) {
                              return const TransactionTile();
                          }),
                          const SizedBox(height: 32,),
                        ]
                      ),
                    if (searchController.text.isNotEmpty)
                      Column(
                        children: [
                          const SizedBox(height: 40,),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Search Results",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16,),
                          ListView.separated(
                            itemCount: searchResults.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            separatorBuilder: (context, state) {
                              return const SizedBox(height: 12);
                            },
                            itemBuilder: (context, index) {
                              return PaymentUserTile(
                                onClick: () {
                                  setState(() {
                                    selectedUserIndexFromSearchResults = index;
                                  });
                                },
                                index: index,
                                selectedIndex: selectedUserIndexFromSearchResults,
                                image: MyImages.visaCardBlue,
                                isSelectMode: true,
                                hiredCandidate: searchResults[index],
                              );
                          }),
                          const SizedBox(height: 32,),
                        ]
                      ),
                      CustomButton(
                        title: "Continue",
                        fontColor: MyColors.white,
                        bgColor: userIsSelected ? MyColors.blue : MyColors.grey,
                        borderColor: userIsSelected ? MyColors.blue : MyColors.grey,
                        onTap: userIsSelected ? () {
                          AppRoutes.push(context, const PaymentAmountScreen());
                        } : null,
                      ),
                  ],
                ),
              const SizedBox(height: 48,),
            ]),
          );
        }
      ),
    );
  }

  _openLinkInBottomSheet(BuildContext context, String url) {
    final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
      Factory(() => EagerGestureRecognizer())
    }; 
    return DraggableScrollableSheet( 
      initialChildSize: 0.8, // 80% of screen height
      maxChildSize: 1.0,
      minChildSize: 0.5,
      expand: false,
      builder: (context, scrollController) {
        //return PayrexxGatewayWidget(gatewayUrl: url,);
        return Container(
          child: WebView(
            initialUrl: url,
            gestureRecognizers: gestureRecognizers,
            javascriptMode: JavascriptMode.unrestricted,
            navigationDelegate: (NavigationRequest request) async {
              // if (isPaymentCompleteUrl(request.url) && invoiceId != null) {
              //   //final redirectResult = extractRedirectResult(request.url);
              //   await verifyPayment(invoiceId!);
              //   Navigator.pop(context);
              //   return NavigationDecision.prevent; // Prevents the WebView from navigating to the next page
              // }
              return NavigationDecision.navigate; 
            },
          ),
        );
      }
    );
  }

  Widget _buildEmployeeAvatarAndName({bool isSelected = false, required HiredCandidate hiredCandidate, required int currentIdx, required void Function(dynamic value) updateSelectedUser}) {
    // var namesMock = ["Alex A.", "Nicholas M." , "Sarah D.", "Omar M.", "Sarah D.", "Mariam", "Omar", "Henry", "Adam", "Jacob", "Russell"];
    // namesMock.shuffle();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          //TODO:
          debugPrint("idx $currentIdx");
          updateSelectedUser(currentIdx);
        },
        child: Column(
          children: [
            Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? MyColors.blue : null,
              ),
              child: Center(
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 26, 26, 26),
                      ),
                      child: const CircleAvatar(
                        radius: 28,
                        backgroundImage: CachedNetworkImageProvider(""),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              // "Alex A.",
              hiredCandidate.user.name ?? "",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: isSelected ? MyColors.blue : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionTile extends StatelessWidget {
  final bool showDate;
  const TransactionTile({
    super.key,
    this.showDate = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: MyColors.grey.withOpacity(.15)),
          ),
      child: ListTile(
        onTap: () {
        },
        shape: RoundedRectangleBorder(side: BorderSide(color: MyColors.grey), borderRadius: BorderRadius.circular(10)),
        // contentPadding: EdgeInsets.all(6),
        tileColor: MyColors.white,
        // leading: ImageButton(
        //   // image: "${EndPoint.imageBaseUrl}${companyModel?.uploadPhoto}",
        //   image: MyImages.businessAndTrade,
        // ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: showDate ? 0 : 4),
        leading: const CircleAvatar(),
        title: Text(
          "Nicholas M.",
          style: TextStyle(
            fontSize: 16,
            color: MyColors.black,
            overflow: TextOverflow.clip,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),
        subtitle: showDate == true ? Text(
          "Mar 22, 2024",
          style: TextStyle(
            fontSize: 16,
            color: MyColors.lightBlack,
            overflow: TextOverflow.clip,
            fontWeight: FontWeight.w400,
          ),
        ) : null,
        trailing: Text(
          "\$90.5",
          style: TextStyle(
            fontSize: 16,
            color: MyColors.black,
            overflow: TextOverflow.clip,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}