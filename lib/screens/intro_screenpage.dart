import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:todo_new/Appstate/appstate.dart';
import 'package:todo_new/components/app_text.dart';
import 'package:todo_new/components/todo_manager.dart';
import 'package:todo_new/list/model.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});
  static const String id = 'intro';
  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  bool onTaskSelected = true;
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          leading: const CircleAvatar(),
          actions: [
            Column(
              children: const [
                CircleAvatar(
                  child: Icon(Icons.notifications),
                ),
              ],
            ),
            const SizedBox(
              width: 5,
            ),
            const CircleAvatar(
              child: Icon(Icons.add),
            )
          ]),
      body: StoreConnector<AppState, _ViewModel>(
        converter: (store) => _ViewModel(context: context, store: store),
        builder: (context, vm) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(
                  text: "Good Morning ",
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 60,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 2.0),
                child: Row(
                  children: [
                    AppText(
                        text: 'Today is Monday',
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.onBackground),
                    Expanded(child: Container()),
                    AppText(
                        text: '75% Done',
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.onBackground),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                ),
                child: Row(
                  children: [
                    AppText(
                        text: 'Dec 12, 2022',
                        fontSize: 12,
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.3)),
                    Expanded(child: Container()),
                    AppText(
                        text: 'Completed Tasks',
                        fontSize: 12,
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.3)),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              tasksOrBoards(context, vm),
              lineWidget(context),
              boardsAndActive(context),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: weekdays(context),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const TodoManager(
                  color: Colors.blue,
                  title: 'Test',
                  icon: Icons.check,
                  text: 'Tester'),
            ],
          );
        },
      ),
    );
  }

  Widget tasksOrBoards(BuildContext context, _ViewModel vm) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(
        children: [
          Container(
            width: 30,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onBackground,
                borderRadius: BorderRadius.circular(10)),
            child: Center(child: AppText(text: '${vm.notComplete()}')),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              if (onTaskSelected == true) return;

              setState(() {
                onTaskSelected = !onTaskSelected;
              });
            },
            child: AppText(
              text: "Tasks",
              fontSize: 40,
              fontWeight: FontWeight.w200,
              color: onTaskSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onBackground,
            ),
          ),
          Expanded(child: Container()),
          Container(
            width: 30,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onBackground,
                borderRadius: BorderRadius.circular(10)),
            child: const Center(child: AppText(text: '3')),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              if (onTaskSelected == false) return;

              setState(() {
                onTaskSelected = !onTaskSelected;
              });
            },
            child: AppText(
              text: "Boards",
              fontSize: 40,
              fontWeight: FontWeight.w200,
              color: !onTaskSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ],
      ),
    );
  }

  Widget lineWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Row(
        children: [
          Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width / 2 - 10),
            height: 2,
            width: double.infinity,
            color: (onTaskSelected == true)
                ? Colors.white
                : Colors.white.withOpacity(0.1),
          ),
          Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width / 2 - 10),
            height: 2,
            width: double.infinity,
            color: (onTaskSelected == true)
                ? Colors.white.withOpacity(0.1)
                : Colors.white,
          )
        ],
      ),
    );
  }

  Widget boardsAndActive(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 35,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1),
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).colorScheme.background,
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.primary),
                    width: 25,
                    child: Center(
                      child: AppText(
                        text: '0',
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                AppText(
                  text: 'Boards',
                  color: Theme.of(context).colorScheme.onBackground,
                )
              ],
            ),
          ),
          Expanded(child: Container()),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 100,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: const Center(
                child: AppText(
                  text: 'Active',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 100,
              height: 35,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).colorScheme.background,
              ),
              child: const Center(
                child: AppText(
                  text: 'Done',
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> weekdays(BuildContext context) {
    List weeks = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return List.generate(weeks.length, (index) {
      return Expanded(
        child: GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
          },
          child: SizedBox(
            child: Center(
              child: AppText(
                text: '${weeks[index]}',
                color: (selectedIndex == index)
                    ? Colors.white
                    : Colors.white.withOpacity(0.3),
              ),
            ),
          ),
        ),
      );
    });
  }
}

class _ViewModel {
  const _ViewModel({required this.store, required this.context});

  final Store<AppState> store;
  final BuildContext context;

  List<Item> get filtered => store.state.filteredItems;

  int complete() => store.state.itemListState.completed;
  int notComplete() => store.state.itemListState.notCompleted;
}
