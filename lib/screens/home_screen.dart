import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:master_of_getx/consts.dart';
import 'package:master_of_getx/controllers/assets_controller.dart';
import 'package:master_of_getx/models/tracked_asset.dart';
import 'package:master_of_getx/screens/details_page.dart';
import 'package:master_of_getx/utils.dart';
import 'package:master_of_getx/widgets/add_asset_dialog.dart';

class HomeScreen extends StatelessWidget {
  AssetsController assetsController = Get.find();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(context),
      body: _buildUI(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const CircleAvatar(
        backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=3"),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Get.dialog(AddAssetDialog());
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }

  Widget _buildUI(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Column(
          children: [
            _portfolioValue(context),
            _trackedAssetsList(context),
          ],
        ),
      ),
    );
  }

  Widget _portfolioValue(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      margin: EdgeInsets.symmetric(
        vertical: (MediaQuery.sizeOf(context).height * 0.03),
      ),
      child: Center(
        child: Text.rich(
          textAlign: TextAlign.center,
          TextSpan(
            children: [
              TextSpan(
                text: "\$",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text:
                    "${assetsController.getPorfolioValue().toStringAsFixed(2)}\n",
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text: "Portfolio value",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _trackedAssetsList(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: (MediaQuery.sizeOf(context).width * 0.03),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: (MediaQuery.sizeOf(context).height * 0.05),
              child: const Text(
                "Portfolio",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.black38,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: ListView.builder(
                itemCount: assetsController.trackedAssets.length,
                itemBuilder: (context, index) {
                  TrackedAsset trackedAsset =
                      assetsController.trackedAssets[index];
                  return Dismissible(
                    key: UniqueKey(),
                    background: slideLeftBackground(),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      assetsController.removeTrackedAsset(index);
                    },
                    child: ListTile(
                      leading: Image.network(
                        getCyptoImageURL(trackedAsset.name!),
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset(IconConstant.notFound),
                      ),
                      title: Text(trackedAsset.name!),
                      subtitle: Text(
                          "USD: ${assetsController.getAssetPrice(trackedAsset.name!).toStringAsFixed(2)}"),
                      trailing: Text(trackedAsset.amount.toString()),
                      onTap: () {
                        Get.to(() {
                          return DetailsPage(
                            coin: assetsController
                                .getCoinData(trackedAsset.name!)!,
                          );
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget slideRightBackground() {
    return Container(
      color: Colors.green,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.edit,
              color: Colors.white,
            ),
            Text(
              " Edit",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }
}
