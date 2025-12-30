import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/utils/others.dart';

import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'dart:math' as math;
import 'package:tracking/utils/wallet_style.dart';

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
              crossAxisAlignment: CrossAxisAlignment.start,
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
    Widget changeColorItem({
      required String title,
      double bottom = 6,
      int index = 0,
      required Color topColor,
      required Color bottomColor,
    }) {
      return GestureDetector(
        onTap: () {
          setState(() {
            _controller.animateToPage(index);
          });
        },
        child: Transform.rotate(
          angle: math.pi / 2, // rotasi 90° → kamu bisa ubah kapan saja
          child: Container(
            margin: EdgeInsets.only(bottom: bottom),
            height: 25,
            width: 25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: kBlackColor.withOpacity(.1),
                width: 1,
              ),
            ),
            child: CustomPaint(
              painter: HalfCirclePainter(
                topColor: topColor,
                bottomColor: bottomColor,
              ),
            ),
          ),
        ),
      );
    }

    Widget itemCard(String title, String subtitle) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: whiteTextStyle.copyWith(
              fontSize: 12,
              color: kWhiteColor.withOpacity(.8),
            ),
          ),
          Text(
            subtitle,
            style: whiteTextStyle.copyWith(
              fontSize: 14,
              color: kWhiteColor,
              fontWeight: semibold,
            ),
          ),
        ],
      );
    }

    Widget cardItem(String title, EdgeInsets margin, WalletTheme colorStyle) {
      return FutureBuilder(
        future: getRotatedDecorationImage(imgUrl: 'assets/img_background.png'),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const SizedBox();

          return Container(
            margin: margin,
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              color: colorStyle.primaryColor, // <-- pakai warna dari theme
              borderRadius: BorderRadius.circular(14),
              image: snapshot.data, // rotated bg
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final containerHeight = constraints.maxHeight;
                double spacing = containerHeight / 5;

                return Container(
                  padding: EdgeInsets.symmetric(
                    vertical: spacing / 1.5,
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Transform.rotate(
                      angle: -math.pi / 2,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "****.****.1234",
                            style: whiteTextStyle.copyWith(
                              fontSize: 28,
                              fontWeight: semibold,
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              text: "15%",
                              children: [
                                TextSpan(
                                  text: " from last month",
                                  style: whiteTextStyle.copyWith(
                                    fontWeight: light,
                                  ),
                                ),
                              ],
                              style: whiteTextStyle.copyWith(
                                fontWeight: semibold,
                              ),
                            ),
                          ),
                          Text(
                            "XXXX  XXXX  XXXX  1234",
                            style: whiteTextStyle.copyWith(
                              fontSize: 20,
                              fontWeight: light,
                            ),
                          ),
                          SizedBox(height: spacing),
                          Row(
                            children: [
                              itemCard("Number", "**** 1234"),
                              const SizedBox(width: 12),
                              itemCard("Exp", "00/00"),
                              const SizedBox(width: 12),
                              itemCard("Currency", "USD"),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(bottom: 20),
      color: kSecondBaseColor,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Container(
            height: 400,
            color: kSecondBaseColor,
            width: MediaQuery.of(context).size.width,
            child: CarouselSlider(
              carouselController: _controller,
              items: [
                cardItem(
                  "neumorphismLite",
                  const EdgeInsets.only(right: 20),
                  WalletThemeData.get(WalletThemeType.neumorphismLite),
                ),
                cardItem(
                  "neonPurple",
                  const EdgeInsets.only(right: 20),
                  WalletThemeData.get(WalletThemeType.neonPurple),
                ),
                cardItem(
                  "oceanBreeze",
                  const EdgeInsets.only(right: 20),
                  WalletThemeData.get(WalletThemeType.oceanBreeze),
                ),
                cardItem(
                  "emeraldGlow",
                  const EdgeInsets.only(right: 20),
                  WalletThemeData.get(WalletThemeType.emeraldGlow),
                ),
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
            padding: const EdgeInsets.symmetric(vertical: 15),
            width: 50,
            decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                bottomLeft: Radius.circular(14),
              ),
              boxShadow: [
                BoxShadow(
                  color: kBlackColor.withOpacity(.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                changeColorItem(
                  title: "neumorphismLite",
                  index: 0,
                  topColor: WalletThemeData.get(WalletThemeType.neumorphismLite)
                      .primaryColor,
                  bottomColor:
                      WalletThemeData.get(WalletThemeType.neumorphismLite)
                          .secondaryColor,
                ),
                changeColorItem(
                  title: "neonPurple",
                  index: 1,
                  topColor: WalletThemeData.get(WalletThemeType.neonPurple)
                      .primaryColor,
                  bottomColor: WalletThemeData.get(WalletThemeType.neonPurple)
                      .secondaryColor,
                ),
                changeColorItem(
                  title: "oceanBreeze",
                  index: 2,
                  topColor: WalletThemeData.get(WalletThemeType.oceanBreeze)
                      .primaryColor,
                  bottomColor: WalletThemeData.get(WalletThemeType.oceanBreeze)
                      .secondaryColor,
                ),
                changeColorItem(
                  title: "emeraldGlow",
                  index: 3,
                  topColor: WalletThemeData.get(WalletThemeType.emeraldGlow)
                      .primaryColor,
                  bottomColor: WalletThemeData.get(WalletThemeType.emeraldGlow)
                      .secondaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<DecorationImage> getRotatedDecorationImage(
    {required String imgUrl}) async {
  final data = await rootBundle.load(imgUrl);
  final bytes = data.buffer.asUint8List();

  // Decode image menjadi dart:ui image
  final codec = await ui.instantiateImageCodec(bytes);
  final frame = await codec.getNextFrame();
  final original = frame.image;

  // Rotate 90 derajat
  final recorder = ui.PictureRecorder();
  final canvas = ui.Canvas(recorder);

  canvas.translate(original.height.toDouble(), 0);
  canvas.rotate(math.pi / 2);
  canvas.drawImage(original, ui.Offset.zero, ui.Paint());

  final rotated =
      await recorder.endRecording().toImage(original.height, original.width);

  final rotatedBytes = await rotated.toByteData(format: ui.ImageByteFormat.png);
  final Uint8List finalBytes = rotatedBytes!.buffer.asUint8List();

  return DecorationImage(
    image: MemoryImage(finalBytes),
    fit: BoxFit.contain,
    alignment: Alignment.centerLeft,
    colorFilter: ColorFilter.mode(
      kWhiteColor.withOpacity(.15),
      BlendMode.srcIn,
    ),
  );
}

class HalfCirclePainter extends CustomPainter {
  final Color topColor;
  final Color bottomColor;

  HalfCirclePainter({
    required this.topColor,
    required this.bottomColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;

    final paintTop = Paint()
      ..color = topColor
      ..style = PaintingStyle.fill;

    final paintBottom = Paint()
      ..color = bottomColor
      ..style = PaintingStyle.fill;

    final rect =
        Rect.fromCircle(center: Offset(radius, radius), radius: radius);

    // Atas (top)
    canvas.drawArc(
      rect,
      -3.14 / 2, // -90°
      3.14, // 180°
      true,
      paintTop,
    );

    // Bawah (bottom)
    canvas.drawArc(
      rect,
      3.14 / 2, // 90°
      3.14, // 180°
      true,
      paintBottom,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
