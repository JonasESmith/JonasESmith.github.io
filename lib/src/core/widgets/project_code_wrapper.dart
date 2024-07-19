import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio/src/core/core.dart';

class CodeWrapperWidget extends StatefulWidget {
  final Widget child;
  final String text;
  final String language;

  const CodeWrapperWidget(
    this.child,
    this.text,
    this.language, {
    super.key,
  });

  @override
  State<CodeWrapperWidget> createState() => _PreWrapperState();
}

class _PreWrapperState extends State<CodeWrapperWidget> {
  late Widget _switchWidget;
  bool hasCopied = false;

  @override
  void initState() {
    super.initState();
    _switchWidget = Icon(
      Icons.copy_rounded,
      key: UniqueKey(),
      size: 16,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(kPad / 2),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: kPad,
          sigmaY: kPad,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: theme.cardColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(kPad / 2),
            border: Border.all(
              color: theme.colorScheme.primary.withOpacity(0.3),
            ),
          ),
          child: Stack(
            children: [
              widget.child,
              Positioned(
                right: kPad,
                top: kPad,
                child: VoxButton(
                  onPressed: () async {
                    if (hasCopied) return;
                    await Clipboard.setData(ClipboardData(text: widget.text));
                    _switchWidget = Icon(
                      Icons.check,
                      key: UniqueKey(),
                      size: 16,
                      color: theme.colorScheme.primary,
                    );
                    refresh();
                    Future.delayed(const Duration(seconds: 2), () {
                      hasCopied = false;
                      _switchWidget = Icon(
                        Icons.copy_rounded,
                        key: UniqueKey(),
                        size: 16,
                        color: theme.colorScheme.tertiary,
                      );
                      refresh();
                    });
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      kPad / 2 - 4,
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 10,
                        sigmaY: 10,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: theme.cardColor.withOpacity(0.7),
                          border: Border.all(
                            width: 0.5,
                            color: theme.colorScheme.primary.withOpacity(0.3),
                          ),
                        ),
                        padding: const EdgeInsets.all(kPad / 2),
                        child: Row(
                          children: [
                            if (widget.language.isNotEmpty) ...{
                              SelectionContainer.disabled(
                                child: Container(
                                  margin: const EdgeInsets.only(right: 2),
                                  padding: const EdgeInsets.all(2),
                                  child: Text(
                                    widget.language,
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                ),
                              ),
                              const HPad.half(),
                            },
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              child: _switchWidget,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void refresh() {
    if (mounted) setState(() {});
  }
}
