import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:todo_new/Appstate/appstate.dart';
import 'package:todo_new/components/app_text.dart';
import 'package:todo_new/helpers.dart';
import 'package:todo_new/loader.dart';
import 'package:todo_new/loading/selectors.dart';

class RoundedButton extends StatelessWidget {
  final double? height;
  final double? width;
  final String text;
  final IconData? icon;
  final String? loadingKey;
  final Function onTap;
  final Color backgroundColor;
  final Color? onBackgroundColor;
  final double? radius;
  final double? fontSize;
  final double? iconSize;
  final bool isPill;
  final bool enableSolidColor;
  final bool withShadow;
  final List<BoxShadow>? shadow;

  const RoundedButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.backgroundColor,
    this.loadingKey,
    this.height,
    this.width,
    this.icon,
    this.onBackgroundColor,
    this.radius,
    this.fontSize,
    this.iconSize,
    this.isPill = false,
    this.enableSolidColor = false,
    this.withShadow = true,
    this.shadow,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
        converter: (Store<AppState> store) => _ViewModel(
              context: context,
              store: store,
              loadingKey: loadingKey,
            ),
        builder: (
          BuildContext context,
          _ViewModel viewModel,
        ) {
          return GestureDetector(
            onTap: () {
              if (!isEmptyOrNull(loadingKey) && viewModel.isLoading) return;
              onTap();
            },
            child: Center(
              child: Container(
                  height: isPill ? 40 : height,
                  width: width,
                  decoration: BoxDecoration(
                    boxShadow: withShadow ? shadow : null,
                    color: enableSolidColor ? backgroundColor : null,
                    gradient: !enableSolidColor
                        ? LinearGradient(
                            begin: const Alignment(-1.0, -4.0),
                            end: const Alignment(1.0, 4.0),
                            colors: [
                                backgroundColor.withOpacity(0.7),
                                backgroundColor
                              ])
                        : null,
                    borderRadius: BorderRadius.circular(radius ?? 10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: isPill ? 0 : 15,
                        bottom: isPill ? 0 : 15,
                        left: 10,
                        right: 10),
                    child: Center(
                      child: !isEmptyOrNull(loadingKey) && viewModel.isLoading
                          ? Loader(
                              height: 20,
                              width: 20,
                              colors: [onBackgroundColor ?? Colors.white],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (icon != null)
                                  Icon(
                                    icon,
                                    color: onBackgroundColor ?? Colors.white,
                                    size: iconSize ?? 20,
                                  ),
                                if (icon != null && text.isNotEmpty)
                                  const SizedBox(width: 5),
                                if (text.isNotEmpty)
                                  AppText(
                                    text: text,
                                    fontSize: fontSize ?? 15,
                                    color: onBackgroundColor ?? Colors.white,
                                  ),
                              ],
                            ),
                    ),
                  )),
            ),
          );
        });
  }
}

class _ViewModel {
  final BuildContext context;
  final Store<AppState> store;
  final String? loadingKey;

  _ViewModel({
    required this.context,
    required this.store,
    required this.loadingKey,
  });

  bool get isLoading => selectIsLoading(store.state, loadingKey);
}
