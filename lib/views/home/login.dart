import 'package:flutter/material.dart';

import 'package:chess/constants/breakpoints.dart';
import 'package:chess/models/provider/breakpoint_provider.dart';
import 'package:chess/services/lichess_service.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const _Header(),
        const SizedBox(height: 10),
        _TextField(controller: _controller),
        const SizedBox(height: 10),
        _Button(controller: _controller),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  static const chessLogo = 'assets/images/logo_dark.png';

  @override
  Widget build(BuildContext context) {
    final style = switch (context.watch<DeviceState>().windowSize) {
      WindowSize.extended => Theme.of(context).textTheme.bodyLarge,
      WindowSize.medium => Theme.of(context).textTheme.bodyMedium,
      WindowSize.compact => Theme.of(context).textTheme.bodySmall,
    };

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
          flex: 3,
          child: Image.asset(chessLogo),
        ),
        Flexible(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Profile, Stats', style: style),
                  Text(
                    '... and many more!',
                    style: style!.copyWith(color: Colors.blue),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TextField extends StatelessWidget {
  const _TextField({required this.controller});

  final TextEditingController controller;

  static const labelText = 'Enter your Lichess Username';

  @override
  Widget build(BuildContext context) {
    final windowSize = context.watch<DeviceState>().windowSize;

    final labelStyle = switch (windowSize) {
      WindowSize.extended => Theme.of(context).textTheme.bodyLarge,
      WindowSize.medium => Theme.of(context).textTheme.bodyMedium,
      WindowSize.compact => Theme.of(context).textTheme.bodySmall,
    };

    return TextField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
        labelStyle: labelStyle,
      ),
      controller: controller,
      onSubmitted: (_) async {
        await authenticateUsername(context, controller);
      },
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({required this.controller});

  final TextEditingController controller;

  static const buttonHeight = 40.0;

  @override
  Widget build(BuildContext context) {
    final windowSize = context.watch<DeviceState>().windowSize;

    final style = switch (windowSize) {
      WindowSize.extended => Theme.of(context).textTheme.bodyLarge,
      WindowSize.medium => Theme.of(context).textTheme.bodyMedium,
      WindowSize.compact => Theme.of(context).textTheme.bodySmall,
    };

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(buttonHeight),
      ),
      onPressed: () async => authenticateUsername(context, controller),
      child: Text('Enter', style: style),
    );
  }
}

Future<void> authenticateUsername(
  BuildContext context,
  TextEditingController controller,
) async {
  final id = controller.text;
  final response =
      await http.head(Uri.parse('https://lichess.org/api/user/$id'));

  if (response.statusCode == 200 && context.mounted) {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => LichessService(id: id),
      ),
    );
  } else {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username does not exist.')),
      );
    }
  }
}
