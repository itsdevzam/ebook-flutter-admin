import 'package:ebook_admin/features/user/controller/AllUserController.dart';
import 'package:ebook_admin/features/user/model/UserModel.dart';
import 'package:ebook_admin/features/user/widgets/MyUserDialog.dart';
import 'package:ebook_admin/helper/MyDeleteDialog.dart';
import 'package:ebook_admin/helper/MyLoadingDialog.dart';
import 'package:ebook_admin/helper/MyText.dart';
import 'package:ebook_admin/utils/colors.dart';
import 'package:ebook_admin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class MyUserRowData extends StatelessWidget {
  int index;
  UserModel userModel;
  AllUserController allUserController;

  MyUserRowData({
    super.key,
    required this.index,
    required this.userModel,
    required this.allUserController,
  });

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Obx(() {
        if (allUserController.isLoading.value) {
          MyLoadingDialog();
          return SizedBox.shrink();
        } else {
          return Card(
            elevation: 2,
            color: Colors.grey[100],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        children: [
                          SizedBox(width: 10),
                          MyText(text: "${index + 1}", fontSize: 15),
                          SizedBox(width: 10),
                          SizedBox(
                            width: Constants.isDesktop(context) ? 120 : 80,
                            child: MyText(
                              text: userModel.name!,
                              fontSize: 15,
                              isOverFlow: true,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: MyText(
                              text: userModel.email!,
                              fontSize: 15,
                              isOverFlow: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: MyText(text: userModel.isPro!, fontSize: 15),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: IconButton(
                            onPressed: () => {
                              allUserController.nameTEC.text = userModel.name!,
                              allUserController.emailTEC.text =
                                  userModel.email!,
                              allUserController.proUserTEC.text =
                                  userModel.isPro!,
                              allUserController.expiryTEC.text =
                                  userModel.expiryDate != null
                                  ? DateFormat(
                                      "dd-MM-yyyy",
                                    ).format(userModel.expiryDate!)
                                  : "Null",
                              MyUserDialog().MyViewUserDialog(
                                nameTEC: allUserController.nameTEC,
                                emailTEC: allUserController.emailTEC,
                                proUserTEC: allUserController.proUserTEC,
                                expiryTEC: allUserController.expiryTEC,
                              ),
                            },
                            icon: Icon(Iconsax.eye, size: 18),
                          ),
                        ),
                        IconButton(
                          onPressed: () => {
                            MyDeleteDialog(
                              callback: () => {
                                Get.back(),
                                allUserController.deleteUser(
                                  uid: userModel.uid!,
                                ),
                                allUserController.allUsersData(page: "1"),
                              },
                            ),
                          },
                          icon: Icon(FontAwesomeIcons.trash, size: 18),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
