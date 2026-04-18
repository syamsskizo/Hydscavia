import 'package:flutter/material.dart';

class AnimatedListItem extends StatefulWidget {
  final Widget child;
  final int index;
  final bool isVertical;

  const AnimatedListItem({
    super.key,
    required this.child,
    required this.index,
    required this.isVertical,
  });

  @override
  State<AnimatedListItem> createState() => _AnimatedListItemState();
}

class _AnimatedListItemState extends State<AnimatedListItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _slideAnimation;

  @override
void initState() {
  super.initState();
  // 1. Inisialisasi controller SEKARANG, jangan nunggu delay
  _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 600),
  );

  // 2. Definisi animasi juga langsung di sini
  _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
    CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
    ),
  );

  _slideAnimation = Tween<double>(
    begin: widget.isVertical ? 20 : 15, 
    end: 0.0
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
    ),
  );

  // 3. Nah, baru deh perintah JALAN-nya yang di-delay
  final delay = widget.index * 60;
  Future.delayed(Duration(milliseconds: delay), () {
    if (mounted) {
      _controller.forward();
    }
  });
}

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Transform.scale(
        scale: _scaleAnimation.value,
        child: Transform.translate(
          offset: widget.isVertical
              ? Offset(0, _slideAnimation.value)
              : Offset(_slideAnimation.value, 0),
        child: Opacity(opacity: _scaleAnimation.value,child: child),
        ),
      ),
      child: widget.child,
    );
  }
}
