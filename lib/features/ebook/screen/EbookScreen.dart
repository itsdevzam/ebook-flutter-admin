import 'package:ebook_admin/features/ebook/controller/EbookController.dart';
import 'package:ebook_admin/features/ebook/widget/MyEbookDialog.dart';
import 'package:ebook_admin/features/ebook/widget/MyEbookRowData.dart';
import 'package:ebook_admin/features/ebook/widget/MyEbookRowHeading.dart';
import 'package:ebook_admin/helper/MyFooterLayout.dart';
import 'package:ebook_admin/helper/MySearchLayout.dart';
import 'package:ebook_admin/helper/MyToast.dart';
import 'package:ebook_admin/utils/colors.dart';
import 'package:ebook_admin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class EbookScreen extends StatefulWidget {
  EbookScreen({super.key});

  @override
  State<EbookScreen> createState() => _EbookScreenState();
}

class _EbookScreenState extends State<EbookScreen> {
  final EbookController _ebookController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: Constants.isDesktop(context) ? 40 : 10),

        ///Search
        MySearchLayout(
          textEditingController: _ebookController.searchEbookController,
          heading: "Ebooks",
          searchLabel: "Search By Title",
          searchCallback: () => {
            _ebookController.searchBook(
              title: _ebookController.searchEbookController.text,
            ),
          },
          iconData: Iconsax.book,
        ),
        SizedBox(height: Constants.isDesktop(context) ? 40 : 20),

        ///Heading
        MyEbookRowHeading(),
        Divider(thickness: 2),

        ///Data
        Expanded(
          child: Stack(
            children: [
              Obx(
                () => _ebookController.isLoading.value
                    ? Center(
                        child: CircularProgressIndicator(
                          color: ThemeColors.primaryColor,
                        ),
                      )
                    ///if loading complete check data is avialable or not
                    : (_ebookController.ebookModelList.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.only(bottom: 20),
                              itemBuilder: (context, index) => MyEbookRowData(
                                index: index,
                                ebookController: _ebookController,
                                ebookModel: _ebookController.ebookModelList[index],
                              ),
                              itemCount: _ebookController.ebookModelList.length,
                            )
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(FontAwesomeIcons.faceFrown, size: 30),
                                  SizedBox(height: 10),
                                  Text(
                                    "No Ebook Available",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                            )),
              ),
              Positioned(
                bottom: 30,
                right: Constants.isDesktop(context) ? 50 : 20,
                child: FloatingActionButton(
                  heroTag: "EbookScreen",
                  onPressed: () async => {
                    ///empty so user can add values for add
                    _ebookController.titleTextController.text = "",
                    _ebookController.urlTextController.text = "",
                    _ebookController.descTextController.text = "",
                    _ebookController.ebookInitOptionValue.value = 0,
                    await _ebookController.getBookCatList(),
                    if (_ebookController.ebookCatListMap.keys.first.isNaN)
                      {_ebookController.ebookCatOptionValue.value = -1}
                    else
                      {
                        _ebookController.ebookCatOptionValue.value =
                            _ebookController.ebookCatListMap.keys.first,
                      },
                    ///set pdf empty
                    _ebookController.isPdfPicked.value=false,

                    ///so user see image picker placeholder
                    _ebookController.isImagePicked.value = false,
                    MyEbookDialog().MyAddEbookDialog(
                      ebookController: _ebookController,
                    ),
                  },
                  backgroundColor: ThemeColors.primaryColor,
                  child: Icon(Iconsax.add, color: Colors.white),
                ),
              ),
            ],
          ),
        ),

        ///footer
        ///footer
        Obx(
          () => MyFooterLayout(
            current: _ebookController.currentPage.value,
            total: _ebookController.totalPage.value,
            leftcallback: () {
              final page = int.parse(_ebookController.currentPage.value);
              if (page <= 1) {
                MyToast.showError(message: "No more pages available");
                return;
              }
              _ebookController.allEbooksData(page: (page - 1).toString());
            },
            rightcallback: () {
              final page = int.parse(_ebookController.currentPage.value);
              final total = int.parse(_ebookController.totalPage.value);
              if (page >= total) {
                MyToast.showError(message: "No more pages available");
                return;
              }
              _ebookController.allEbooksData(page: (page + 1).toString());
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
    _ebookController.allEbooksData(page: "1");
  }
}
