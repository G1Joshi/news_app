import 'package:flutter/material.dart';

import 'package:news_app/utils/routes.dart';
import 'package:news_app/utils/strings.dart';
import 'package:news_app/utils/styles.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class Header extends StatelessWidget {
  const Header(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: Styles.bold20,
    );
  }
}

class SomethingWentWrong extends StatelessWidget {
  const SomethingWentWrong({Key? key, required this.onRetry}) : super(key: key);

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.signal_wifi_connected_no_internet_4,
          size: 50,
        ),
        const SizedBox(height: 15),
        const Text(
          Strings.somethingWentWrong,
          style: Styles.bold20,
        ),
        const SizedBox(height: 15),
        ElevatedButton(
          onPressed: onRetry,
          child: const Text(
            Strings.tryAgain,
            style: Styles.white18,
          ),
        ),
      ],
    );
  }
}

class NoResultFound extends StatelessWidget {
  const NoResultFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(
          Icons.file_copy,
          size: 50,
        ),
        SizedBox(height: 15),
        Text(
          Strings.noResultFound,
          style: Styles.bold20,
        ),
      ],
    );
  }
}

class SearchButton extends StatelessWidget {
  const SearchButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pushNamed(
          context,
          Routes.search,
        );
      },
      icon: const Icon(Icons.search),
    );
  }
}

class Empty extends StatelessWidget {
  const Empty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
