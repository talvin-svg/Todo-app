import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';
import 'package:todo_new/Appstate/appstate.dart';
import 'package:todo_new/components/app_text.dart';
import 'package:todo_new/components/constants.dart';

class ViewTodoScreen extends StatefulWidget {
  const ViewTodoScreen(
      {super.key,
      required this.backgroundColor,
      required this.dueDate,
      required this.title,
      required this.description,
      required this.createdAt,
      required this.timeLeft});

  final Color backgroundColor;
  final String title;
  final String description;
  final DateTime createdAt;
  final String timeLeft;
  final DateTime dueDate;

  @override
  State<ViewTodoScreen> createState() => _ViewTodoScreenState();
}

class _ViewTodoScreenState extends State<ViewTodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          GestureDetector(
            onTap: () {},
            child: const Icon(
              Icons.more_horiz_rounded,
              color: Colors.white,
            ),
          ),
          spaceHorizontal
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 40),
        decoration: BoxDecoration(color: widget.backgroundColor),
        child: StoreConnector<AppState, _ViewModel>(
          converter: (store) => _ViewModel(store: store, context: context),
          builder: (context, vm) {
            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black, width: 0.5)),
                      width: 150,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: AppText(
                            text: 'Sweet  Home',
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Flexible(
                      child: AppText(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        text: widget.title,
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 60,
                      ),
                    ),
                    spaceVertical,
                    AppText(
                      text: 'Time Left',
                      fontSize: 15,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    spaceVertical,
                    AppText(
                      text: dueDateCalculator(widget.dueDate),
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                    AppText(
                        fontWeight: FontWeight.w600,
                        text: DateFormat('MMM d, yyyy')
                            .format(widget.dueDate)
                            .toString()),
                    const SizedBox(
                      height: 20,
                    ),
                    AppText(
                      text: 'Additional Description',
                      fontSize: 15,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    spaceVertical,
                    AppText(
                      text: widget.description,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AppText(
                      text: 'Created At',
                      fontSize: 15,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    spaceVertical,
                    AppText(
                        fontWeight: FontWeight.w600,
                        text: DateFormat('MMMM dd yyyy')
                            .format(widget.createdAt)
                            .toString()),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String dueDateCalculator(DateTime endDate) {
    DateTime now = DateTime.now();
    DateTime dueDate = endDate;

    Duration timeLeft = dueDate.difference(now);
    dynamic day = (timeLeft.inDays == 0) ? '' : timeLeft.inDays;
    return '${day}d ${timeLeft.inHours.remainder(24)}h ${timeLeft.inMinutes.remainder(60)}m';
  }
}

class _ViewModel {
  const _ViewModel({required this.store, required this.context});
  final Store<AppState> store;
  final BuildContext context;
}
