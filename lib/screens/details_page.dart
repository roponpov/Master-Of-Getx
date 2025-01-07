import 'package:flutter/material.dart';
import 'package:master_of_getx/models/coin_data.dart';
import 'package:master_of_getx/utils.dart';

class DetailsPage extends StatelessWidget {
  final CoinData coin;

  const DetailsPage({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildUI(context),
    );
  }

  Widget _buildUI(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: (MediaQuery.sizeOf(context).width * 0.02),
        ),
        child: Column(
          children: [
            _assetPrice(context),
            _assetInfo(context),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(coin.name!),
    );
  }

  Widget _assetPrice(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.10,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.network(
              getCyptoImageURL(coin.name!),
            ),
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: "\$ ${coin.values?.uSD?.price?.toStringAsFixed(2)}\n",
                    style: TextStyle(fontSize: 25)),
                TextSpan(
                    text:
                        "${coin.values?.uSD?.percentChange24h?.toStringAsFixed(2)} %",
                    style: TextStyle(
                        fontSize: 15,
                        color: coin.values!.uSD!.percentChange24h! > 0
                            ? Colors.green
                            : Colors.red)),

                // 1:28:32
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _assetInfo(BuildContext context) {
    return Expanded(
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.9,
        ),
        children: [
          _infoCard("Circulating Supply", coin.circulatingSupply.toString()),
          _infoCard("Maximum Supply", coin.maxSupply.toString()),
          _infoCard("Total Supply", coin.totalSupply.toString()),
        ],
      ),
    );
  }

  Widget _infoCard(String title, String subtitle) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}
