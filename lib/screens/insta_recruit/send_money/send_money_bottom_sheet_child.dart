import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:insta_job/screens/insta_recruit/send_money/amount_page.dart';
import 'package:insta_job/screens/insta_recruit/send_money/payment_user_tile.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/debouncer.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_text_field.dart';

class SendMoneyBottomSheetChild extends StatefulWidget {
  const SendMoneyBottomSheetChild({super.key});

  @override
  State<SendMoneyBottomSheetChild> createState() => _SendMoneyBottomSheetChildState();
}

class _SendMoneyBottomSheetChildState extends State<SendMoneyBottomSheetChild> {
  // final debouncer = Debouncer(milliseconds: 1000);
  final debouncer = Debouncer(milliseconds: 10);
  final TextEditingController searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12).copyWith(top: 0)
          .copyWith(top: 0),
      height: MediaQuery.of(context).size.height * 0.84,
      child: SingleChildScrollView(
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
          const Text(
            "Choose an employee to continue",
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
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
                setState(() {});
              });
            },
          ),
          if (searchController.text.isEmpty)
            Column(
              children: [
                const SizedBox(height: 16,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildEmployeeAvatarAndName(),
                      _buildEmployeeAvatarAndName(),
                      _buildEmployeeAvatarAndName(isSelected: true),
                      _buildEmployeeAvatarAndName(),
                      _buildEmployeeAvatarAndName(),
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
                  itemCount: 4,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, state) {
                    return const SizedBox(height: 12);
                  },
                  itemBuilder: (context, index) {
                     return PaymentUserTile(
                      onClick: () {
                      },
                      index: 1,
                      selectedIndex: 1,
                      image: MyImages.visaCardBlue,
                      isSelectMode: true,
                    );
                }),
                const SizedBox(height: 32,),
              ]
            ),
          CustomButton(
            title: "Continue",
            fontColor: MyColors.white,
            borderColor: MyColors.blue,
            onTap: () {
              AppRoutes.push(context, const PaymentAmountScreen());
            },
          ),
          const SizedBox(height: 48,),
        ]),
      ),
    );
  }

  Padding _buildEmployeeAvatarAndName({bool isSelected = false}) {
    var namesMock = ["Alex A.", "Nicholas M." , "Sarah D.", "Omar M.", "Sarah D.", "Mariam", "Omar", "Henry", "Adam", "Jacob", "Russell"];
    namesMock.shuffle();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? Colors.red : null,
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
            namesMock.first,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: isSelected ? MyColors.blue : null,
            ),
          ),
        ],
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
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}