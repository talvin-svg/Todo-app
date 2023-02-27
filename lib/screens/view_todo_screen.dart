import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:redux/redux.dart';
import 'package:todo_new/Appstate/appstate.dart';
import 'package:todo_new/components/app_text.dart';
import 'package:todo_new/components/constants.dart';
import 'package:todo_new/list/model.dart';
import 'package:todo_new/list/selectors.dart';

class ViewTodoScreen extends StatefulWidget {
  const ViewTodoScreen({super.key, required this.item });

  final Item item;

  @override
  State<ViewTodoScreen> createState() => _ViewTodoScreenState();
}

class _ViewTodoScreenState extends State<ViewTodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).colorScheme.onBackground,
            )),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.more_horiz_rounded,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          spaceHorizontal
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 40),
        decoration: BoxDecoration(color: widget.item.color),
        child: StoreConnector<AppState, _ViewModel>(
          converter: (store) => _ViewModel(store: store, context: context),
          builder: (context, vm) {
            final items = vm.getItems();
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
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: Theme.of(context).colorScheme.onBackground,
                              width: 0.5)),
                      width: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(
                            text: categorySeletor(widget.item.category!),
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                          // spaceHorizontal,
                          iconSelector(widget.item.category!)
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Flexible(
                      child: AppText(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        text: widget.item.title,
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 60,
                      ),
                    ),
                    spaceVertical,
                    AppText(
                      text: 'Time Left',
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    spaceVertical,
                    AppText(
                      text: dueDateCalculator(widget.item.dueDate!),
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    AppText(
                      fontWeight: FontWeight.w600,
                      text: DateFormat('MMM d, yyyy')
                          .format(widget.item.dueDate!)
                          .toString(),
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AppText(
                      text: 'Additional Description',
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    spaceVertical,
                    AppText(
                      maxLines: 5,
                      text: widget.item.details,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AppText(
                      text: 'Created At',
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    spaceVertical,
                    AppText(
                      fontWeight: FontWeight.w600,
                      text: DateFormat('MMMM dd yyyy')
                          .format(widget.item.createdAt)
                          .toString(),
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // LiteRollingSwitch(
                    //     onTap: () {},
                    //     onDoubleTap: onDoubleTap,
                    //     onSwipe: onSwipe,
                    //     onChanged: onChanged)
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
    dynamic day = (timeLeft.inDays == 0)
        ? '${timeLeft.inHours.remainder(24)}h ${timeLeft.inMinutes.remainder(60)}m'
        : '${timeLeft.inDays}d ${timeLeft.inHours.remainder(24)}h ${timeLeft.inMinutes.remainder(60)}m';

    return day;
  }
}

class _ViewModel {
  const _ViewModel({required this.store, required this.context});
  final Store<AppState> store;
  final BuildContext context;

  List<Item> getItems () => store.state.itemListState.itemList;
}
