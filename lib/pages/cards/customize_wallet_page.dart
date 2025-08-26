import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/utils/others.dart';

class CustomizeWalletPage extends StatefulWidget {
  const CustomizeWalletPage({super.key});

  @override
  State<CustomizeWalletPage> createState() => _CustomizeWalletPageState();
}

class _CustomizeWalletPageState extends State<CustomizeWalletPage> {
  final CarouselSliderController _controller = CarouselSliderController();
  int selectedWalletIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: ListView(
        children: [
          _changeWalletSection(),
          Container(
            margin: EdgeInsets.only(
              left: defaultMargin,
              right: defaultMargin,
              bottom: 40,
            ),
            child: Column(
              children: [
                Text(
                  'Premium Theme',
                  style: blackTextStyle.copyWith(
                    fontWeight: semibold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Made from stainless steel, our exlusive Metal card will make your stand out from the crowd',
                  style: greyTextStyle,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 55,
              margin: EdgeInsets.symmetric(horizontal: defaultMargin),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: kThirdV2Color,
              ),
              child: Text(
                "Save",
                style: whiteTextStyle.copyWith(
                  fontWeight: bold,
                  fontSize: 16,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      surfaceTintColor: kSecondBaseColor,
      backgroundColor: kSecondBaseColor,
      title: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.chevron_left, color: Colors.black),
            ),
          ),
          Expanded(
            child: Text(
              toTitleCase("Customize"),
              textAlign: TextAlign.center,
              style: blackTextStyle.copyWith(fontSize: 18),
            ),
          ),
          const SizedBox(width: 40, height: 40),
        ],
      ),
    );
  }

  Widget _changeWalletSection() {
    Widget changeColorItem({double bottom = 6, int index = 0}) {
      return GestureDetector(
        onTap: () {
          setState(() {
            _controller.animateToPage(index);
          });
        },
        child: Container(
          height: 25,
          width: 25,
          margin: EdgeInsets.only(bottom: bottom),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: kRedColor,
          ),
        ),
      );
    }

    Widget cardItem(EdgeInsets margin) {
      return Container(
        margin: margin, // Menambahkan margin kanan
        height: 300,
        width: 300,
        decoration: BoxDecoration(
          color: kRedColor,
          borderRadius: BorderRadius.circular(14),
        ),
      );
    }

    return Container(
      height: 400,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(bottom: 20),
      color: kSecondBaseColor,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Container(
            height: 350,
            color: kSecondBaseColor,
            width: MediaQuery.of(context).size.width,
            child: CarouselSlider(
              carouselController: _controller,
              items: [
                cardItem(const EdgeInsets.only(right: 20)),
                cardItem(const EdgeInsets.only(right: 20)),
                cardItem(const EdgeInsets.only(right: 20)),
                cardItem(const EdgeInsets.only(right: 20)),
              ],
              options: CarouselOptions(
                height: 350,
                aspectRatio: 1 / 2,
                viewportFraction: 0.7,
                initialPage:
                    selectedWalletIndex, // Menggunakan selectedWalletIndex
                enableInfiniteScroll: false,
                reverse: true,
                autoPlay: false,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                onPageChanged: (index, reason) {
                  setState(() {
                    selectedWalletIndex =
                        index; // Memperbarui selectedWalletIndex saat halaman berubah
                  });
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
          Container(
            height: 150,
            width: 50,
            decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                bottomLeft: Radius.circular(14),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                changeColorItem(index: 0),
                changeColorItem(index: 1),
                changeColorItem(index: 2),
                changeColorItem(bottom: 0, index: 3),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
