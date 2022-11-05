import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/screens/loading/loading.dart';
import 'package:news_app/utils/routes.dart';
import 'package:news_app/widgets/widgets.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoadingBloc()..add(const GetStatus()),
      child: const LoadingView(),
    );
  }
}

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoadingBloc, LoadingState>(
        listener: (context, state) {
          if (state is CountrySet) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.news,
              (route) => false,
            );
          } else if (state is CountryNotSet) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.landing,
              (route) => false,
            );
          }
        },
        child: const Empty(),
      ),
    );
  }
}
