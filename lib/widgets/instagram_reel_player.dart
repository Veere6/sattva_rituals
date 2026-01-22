import 'dart:ui_web' as ui_web;
import 'dart:html';
import 'package:flutter/material.dart';

class InstagramReelPlayer extends StatefulWidget {
  final String reelId;
  final double width;
  final double height;

  const InstagramReelPlayer({
    super.key,
    required this.reelId,
    this.width = 320,
    this.height = 450,
  });

  @override
  State<InstagramReelPlayer> createState() => _InstagramReelPlayerState();
}

class _InstagramReelPlayerState extends State<InstagramReelPlayer> {
  late final String _viewId;

  @override
  void initState() {
    super.initState();
    _viewId =
    'ig-${widget.reelId}-${DateTime.now().millisecondsSinceEpoch}';

    _registerView();
  }

  void _registerView() {
    // ignore: undefined_prefixed_name
    ui_web.platformViewRegistry.registerViewFactory(
      _viewId,
          (int viewId) {
        final iframe = IFrameElement()
          ..src = 'https://www.instagram.com/reel/${widget.reelId}/embed'
          ..style.border = 'none'
          ..style.width = '100%'
          ..style.height = '100%' // 👈 taller than container
          ..setAttribute('scrolling', 'no');

        return iframe;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ClipRect(
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            Positioned(
              top: 0,          // keep header
              bottom: -300,    // 👈 push footer out
              left: 0,
              right: 0,
              child: HtmlElementView(viewType: _viewId),
            ),
          ],
        ),
      ),
    );
  }
}
