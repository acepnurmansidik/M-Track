import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:tracking/cubit/action_delete/action_delete_cubit.dart";
import "package:tracking/cubit/page_cubit.dart";
import "package:tracking/pages/auth/cubit/auth_cubit.dart";
import "package:tracking/pages/cards/wallet_page.dart";
import "package:tracking/pages/dashboard/cubit/transaction_cubit.dart";
import "package:tracking/pages/dashboard/cubit/wallet_cubit.dart";
import "package:tracking/pages/dashboard/home_page.dart";
import "package:tracking/pages/setting/profile_page.dart";
import "package:tracking/pages/statistic/activity_page.dart";
import "package:tracking/theme.dart";
import "package:tracking/widgets/custom_buttom_navbar.dart";

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _timeCount = 5;
  Timer? _timer;
  String idTrx = "";

  @override
  void initState() {
    super.initState();

    context.read<AuthCubit>().checkToken(context);
    context.read<WalletCubit>().fetchUserWallet();
    context.read<TransactionCubit>().fetchInitiate();

    // Listen transaction success to refresh data
    context.read<TransactionCubit>().stream.listen((state) {
      if (state is TransactionActionSuccess) {
        context.read<TransactionCubit>().fetchInitiate();
      }
    });

    // Listen ActionDeleteCubit to start timer when isActive true
    context.read<ActionDeleteCubit>().stream.listen((state) {
      if (state.isActive) {
        _startNotificationTimer();
      } else {
        _cancelNotification();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startNotificationTimer() {
    // Jika timer sudah aktif, jangan buat timer baru
    if (_timer != null && _timer!.isActive) return;

    setState(() {
      _timeCount = 5;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeCount == 0) {
        timer.cancel();
        if (!mounted) return;
        setState(() {
          _timeCount = 5;
        });
        context.read<ActionDeleteCubit>().deleteData();
        context.read<ActionDeleteCubit>().deactivate();
        context.read<TransactionCubit>().fetchInitiate();
      } else {
        if (!mounted) return;
        setState(() {
          _timeCount -= 1;
        });
      }
    });
  }

  void _cancelNotification() {
    _timer?.cancel();
    _timer = null;
    if (!mounted) return;
    setState(() {
      _timeCount = 5;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isActive = context.watch<ActionDeleteCubit>().state.isActive;

    return Scaffold(
      backgroundColor: kBaseColors,
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height - 53,
            width: double.infinity,
            child: switch (context.watch<PageCubit>().state) {
              0 => const HomePage(),
              1 => const WalletPage(),
              2 => const ActivityPage(),
              3 => const ProfilePage(),
              int() => throw UnimplementedError(),
            },
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: CustomButtomNavbar(),
          ),
          if (isActive) _buildNotificationTimer(),
        ],
      ),
    );
  }

  Widget _buildNotificationTimer() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: () {
          context.read<ActionDeleteCubit>().deactivate();
          _cancelNotification();
        },
        child: Container(
          height: 45,
          width: MediaQuery.of(context).size.width / 1.12,
          margin: const EdgeInsets.only(bottom: 90),
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          decoration: BoxDecoration(
            color: kBackgroundNotifColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 26,
                    width: 26,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                          backgroundColor: kWhiteColor,
                          strokeWidth: 2.5,
                          value: _timeCount / 5,
                        ),
                        Text(
                          '$_timeCount',
                          style: whiteTextStyle.copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    "click for cancel",
                    style: whiteTextStyle.copyWith(fontSize: 14),
                  ),
                ],
              ),
              Text(
                "Undo",
                style: darkBlueTextStyle.copyWith(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
