import 'package:ebook_admin/features/user/controller/AllUserController.dart';
import 'package:ebook_admin/features/user/widgets/MyUserRowData.dart';
import 'package:ebook_admin/features/user/widgets/MyUserRowHeading.dart';
import 'package:ebook_admin/helper/MyFooterLayout.dart';
import 'package:ebook_admin/helper/MySearchLayout.dart';
import 'package:ebook_admin/helper/MyToast.dart';
import 'package:ebook_admin/utils/colors.dart';
import 'package:ebook_admin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AllUsersScreen extends StatefulWidget {
  AllUsersScreen({super.key});

  @override
  State<AllUsersScreen> createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {
  final AllUserController _allUserController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: Constants.isDesktop(context) ? 40 : 10),

        ///Search
        MySearchLayout(
          textEditingController: _allUserController.seacrhController,
          heading: "All Users",
          searchLabel: "Search By Email",
          searchCallback: () async {
            await _allUserController.searchUser(
              email: _allUserController.seacrhController.text,
            );
          },
          iconData: Iconsax.user,
        ),
        SizedBox(height: Constants.isDesktop(context) ? 40 : 20),

        ///Heading
        MyUserRowHeading(),
        Divider(thickness: 2),

        ///Data
        Expanded(
          child: Obx(
            () => _allUserController.isLoading.value
                ? Center(
                    child: CircularProgressIndicator(
                      color: ThemeColors.primaryColor,
                    ),
                  )
                ///if loading complete check data is avialable or not
                : (_allUserController.userModelList.value.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.only(bottom: 20),
                          itemBuilder: (context, index) => MyUserRowData(
                            index: index,
                            allUserController: _allUserController,
                            userModel:
                                _allUserController.userModelList.value[index],
                          ),
                          itemCount:
                              _allUserController.userModelList.value.length,
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(FontAwesomeIcons.faceFrown, size: 30),
                              SizedBox(height: 10),
                              Text(
                                "No User Available",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        )),
          ),
        ),

        ///footer
        Obx(
          () => MyFooterLayout(
            current: _allUserController.currentPage.value,
            total: _allUserController.totalPage.value,
            leftcallback: () {
              final page = int.parse(_allUserController.currentPage.value);
              if (page <= 1) {
                MyToast.showError(message: "No more pages available");
                return;
              }
              _allUserController.allUsersData(page: (page - 1).toString());
            },
            rightcallback: () {
              final page = int.parse(_allUserController.currentPage.value);
              final total = int.parse(_allUserController.totalPage.value);
              if (page >= total) {
                MyToast.showError(message: "No more pages available");
                return;
              }
              _allUserController.allUsersData(page: (page + 1).toString());
            },
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _allUserController.allUsersData(page: "1");
  }
}
