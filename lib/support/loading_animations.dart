// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class loadingAnimation extends StatefulWidget {
  const loadingAnimation({super.key});

  @override
  State<loadingAnimation> createState() => _loadingAnimationState();
}

class _loadingAnimationState extends State<loadingAnimation> {
  get tabletWidth => MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: tabletWidth < 600
          ? const EdgeInsets.only(top: 300)
          : const EdgeInsets.only(top: 400),
      child: LoadingAnimationWidget.inkDrop(
        color: const Color.fromARGB(
          255,
          3,
          116,
          18,
        ),
        size: 50,
      ),
    );
  }
}
