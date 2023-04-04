import 'package:file_dgr/ui/about/about_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// The about screen
class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  final _viewModel = AboutViewModel();

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
      child: Consumer<AboutViewModel>(
        builder: (_, __, ___) => Stack(
          children: [
            Center(
              child: Text(_viewModel.contentText),
            ),
            if (_viewModel.progressBarStatus) ...[
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
