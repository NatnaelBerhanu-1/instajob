/* Row(
                  children: [
                    Expanded(
                      child: Container(
                          height: 40,
                          // width: MediaQuery.of(context).size.width - 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: MyColors.blue),
                              color: MyColors.white),
                          child: Row(
                            children: List.generate(
                                list.length,
                                (index) => Expanded(
                                      child: Container(
                                        height: 40,
                                        // width: MediaQuery.of(context).size.width - 30,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            border: Border.all(
                                                color: MyColors.white),
                                            color: MyColors.white),
                                        child: CustomFilterTile(
                                          onClick: () {
                                            sqIndex = index;
                                            setState(() {});
                                          },
                                          selectedIndex: sqIndex,
                                          index: index,
                                          title: list[index],
                                        ),
                                      ),
                                    )),
                          )),
                    ),
                    SizedBox(width: 7),
                    Expanded(
                        flex: 0,
                        child: Image.asset(
                          MyImages.filter,
                          height: 30,
                          width: 30,
                        ))
                  ],
                ),*/

import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_colors.dart';

class CustomFilterTile extends StatelessWidget {
  final String? title;
  final int? index;
  final int? selectedIndex;
  final void Function()? onClick;
  const CustomFilterTile(
      {Key? key, this.index, this.selectedIndex, this.onClick, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
          // height: MediaQuery.of(context).size.height,
          // width: MediaQuery.of(context).size.width * 0.3,
          decoration: BoxDecoration(
            color: index == selectedIndex ? MyColors.blue : MyColors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('$title',
                  style: TextStyle(
                      fontSize: 10,
                      color: index == selectedIndex
                          ? MyColors.white
                          : MyColors.blue)),
            ),
          )),
    );
  }
}
