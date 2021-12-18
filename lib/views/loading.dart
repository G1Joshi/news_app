import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/logic/country_bloc/country_bloc.dart';
import 'package:news_app/views/home_page.dart';
import 'package:news_app/views/news_screen/news_page.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CountryBloc()..add(const GetStatus()),
      child: Scaffold(
        body: BlocListener<CountryBloc, CountryState>(
          listener: (context, state) {
            if (state is CountrySet) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const NewsPage(),
                ),
                (route) => false,
              );
            } else if (state is CountryNotSet) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
                (route) => false,
              );
            }
          },
          child: const SizedBox.shrink(),
        ),
      ),
    );
  }
}
