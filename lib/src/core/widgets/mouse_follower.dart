import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' as math;

class MouseFollower extends StatefulWidget {
  const MouseFollower({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _MouseFollowerState createState() => _MouseFollowerState();
}

class _MouseFollowerState extends State<MouseFollower> with SingleTickerProviderStateMixin {
  Offset _position = Offset.zero;
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _smallObjectRotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(_animationController);

    _smallObjectRotationAnimation = Tween<double>(
      begin: 0,
      end: 4 * math.pi,
    ).animate(_animationController);

    _startCircularAnimation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _startCircularAnimation() {
    if (!mounted) return;

    final random = math.Random();
    final duration = Duration(seconds: 15 + random.nextInt(10));

    _animationController.duration = duration;
    _animationController.repeat();

    if (mounted) {
      setState(() {
        _rotationAnimation = Tween<double>(
          begin: 0,
          end: 2 * math.pi,
        ).animate(_animationController);

        _smallObjectRotationAnimation = Tween<double>(
          begin: 0,
          end: 4 * math.pi + random.nextDouble() * 2 * math.pi,
        ).animate(_animationController);
      });
    }
  }

  void _updatePosition(PointerEvent details) {
    if (!mounted) return;

    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final newPosition = renderBox.globalToLocal(details.position);

    setState(() {
      _position = newPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const size = 1000.0;
    const smallSize = 300.0;

    return Container(
      color: theme.scaffoldBackgroundColor,
      child: MouseRegion(
        onHover: _updatePosition,
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Stack(
                  children: [
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.easeOutCubic,
                      left: _position.dx - (size / 2),
                      top: _position.dy - (size / 2),
                      child: Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateX(0.05)
                          ..rotateY(0.05)
                          ..rotateZ(_rotationAnimation.value),
                        alignment: Alignment.center,
                        child: Container(
                          width: size,
                          height: size,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              center: Alignment.center,
                              radius: 0.5,
                              colors: [
                                theme.colorScheme.primary.withOpacity(0.3),
                                theme.colorScheme.tertiary.withOpacity(0.1),
                                theme.colorScheme.secondary.withOpacity(0.0),
                              ],
                              stops: const [0.0, 0.5, 1.0],
                            ),
                          ),
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 1200),
                      curve: Curves.easeOutCubic,
                      left: _position.dx - (smallSize / 2) + 100 * math.cos(_smallObjectRotationAnimation.value),
                      top: _position.dy - (smallSize / 2) + 100 * math.sin(_smallObjectRotationAnimation.value),
                      child: Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.002)
                          ..rotateX(0.1)
                          ..rotateY(0.1)
                          ..rotateZ(_smallObjectRotationAnimation.value),
                        alignment: Alignment.center,
                        child: Container(
                          width: smallSize,
                          height: smallSize,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              center: Alignment.center,
                              radius: 0.5,
                              colors: [
                                theme.colorScheme.secondary.withOpacity(0.4),
                                theme.colorScheme.primary.withOpacity(0.2),
                                theme.colorScheme.tertiary.withOpacity(0.0),
                              ],
                              stops: const [0.0, 0.5, 1.0],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            const NoiseLayer(opacity: 0.05, density: 5000),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
              child: widget.child,
            ),
          ],
        ),
      ),
    );
  }
}

class NoiseLayer extends StatelessWidget {
  final double opacity;
  final int density;

  const NoiseLayer({
    Key? key,
    this.opacity = 0.1,
    this.density = 1000,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: NoisePainter(opacity: opacity, density: density),
      child: Container(),
    );
  }
}

class NoisePainter extends CustomPainter {
  final double opacity;
  final int density;
  final math.Random random = math.Random();

  NoisePainter({required this.opacity, required this.density});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(opacity);

    for (int i = 0; i < density; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      canvas.drawCircle(Offset(x, y), 0.5, paint);
    }
  }

  @override
  bool shouldRepaint(NoisePainter oldDelegate) => false;
}
