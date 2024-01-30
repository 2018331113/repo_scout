
import 'package:flutter/material.dart';

/// Default screen when path is not found
class DefaultScreen extends StatelessWidget {
  
  final String? path;
  const DefaultScreen({
    super.key, this.path,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Not Found"),
      ),
      body: Center(
        child: Text('No path for $path'),
      ),
    );
  }
}
