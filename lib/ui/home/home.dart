import 'package:file_dgr/generated/l10n.dart';
import 'package:file_dgr/ui/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// The home screen
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _viewModel = HomeViewModel();

  /// Initializes the state and retrieves the data.
  @override
  void initState() {
    super.initState();
    _viewModel.getData();
  }

  /// Disposes the [_viewModel].
  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Consumer<HomeViewModel>(
        builder: (_, __, ___) => Stack(
          children: [
            if (!_viewModel.progressBarStatus) ...[
              Center(
                child: Text(S.current.hello_(_viewModel.contentText)),
              ),
            ] else ...[
              Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
