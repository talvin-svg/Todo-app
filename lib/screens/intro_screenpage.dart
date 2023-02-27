import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';

import 'package:redux/redux.dart';
import 'package:todo_new/Appstate/appstate.dart';
import 'package:todo_new/async_actions.dart';
import 'package:todo_new/components/app_text.dart';
import 'package:todo_new/components/app_text_input_field.dart';
import 'package:todo_new/components/constants.dart';
import 'package:todo_new/components/custom_button.dart';
import 'package:todo_new/components/dismissed_container.dart';
import 'package:todo_new/components/scaffold_error_message.dart';
import 'package:todo_new/components/todo_manager.dart';
import 'package:todo_new/helpers.dart';
import 'package:todo_new/list/model.dart';
import 'package:todo_new/list/selectors.dart';
import 'package:todo_new/list/state.dart';
import 'package:todo_new/screens/todo_form.dart';
import 'package:todo_new/screens/view_todo_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});
  static const String id = 'intro';
  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  bool onTaskSelected = true;
  bool onActiveSelected = true;
  String currentDay = getDayOfTheWeek();
  bool morning = isMorning();

  int selectedWeekIndex = DateTime.now().weekday - 1;
  int selectedCategoryIndex = 0;
  final detailsController = TextEditingController();
  final titleController = TextEditingController();
  final dateController = TextEditingController();
  final dialogController = TextEditingController();
  final dialogDetailsController = TextEditingController();

  List<String> weeks = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    detailsController.dispose();
    dateController.dispose();
    titleController.dispose();
    dialogController.dispose();
    dialogDetailsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back_ios)),
          actions: [
            const CircleAvatar(
              backgroundColor: Colors.black45,
              child: Icon(
                Icons.notifications,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            CircleAvatar(
              backgroundColor: Colors.black45,
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.9),
                      isScrollControlled: true,
                      backgroundColor: Colors.black,
                      context: context,
                      builder: (context) {
                        return const TodoForm();
                      });
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
          ]),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.teal,
              Colors.indigo,
            ],
          ),
        ),
        child: StoreConnector<AppState, _ViewModel>(
          converter: (store) => _ViewModel(context: context, store: store),
          builder: (context, vm) {
            List<Item> items = (onTaskSelected)
                ? vm.filteredByDay(weeks[selectedWeekIndex])
                : vm.filteredByCategory(category[selectedCategoryIndex]);
            return ListView(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppText(
                    text: morning ? 'Good Morning' : 'Good Evening',
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 50,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 2.0),
                  child: Row(
                    children: [
                      AppText(
                          text: 'Today is $currentDay',
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
                          text: getCurrentDate(),
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
                boardsAndActive(context, vm.store),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    children: weekdays(context) ?? [],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];

                      return (onTaskSelected == true)
                          ? Padding(
                              padding: const EdgeInsets.all(1),
                              child: Dismissible(
                                background: const CustomDismissedContainer(
                                  color: Colors.red,
                                  icon: Icons.delete,
                                  isDelete: true,
                                ),
                                onDismissed: (direction) {
                                  deleteTodo(
                                      context: context,
                                      store: vm.store,
                                      index: index);
                                  previewSuccess(
                                      message: 'Todo was successfully deleted',
                                      context: context);
                                },
                                key: PageStorageKey(item),
                                child: TodoManager(
                                  onclick: () {
                                    showModalBottomSheet(
                                        constraints: BoxConstraints(
                                            maxHeight: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.7),
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (context) => SizedBox(
                                                child: ViewTodoScreen(
                                              item: item,
                                            )));
                                  },
                                  color: item.color!,
                                  title: item.title!,
                                  ontap: () {
                                    editor(context, vm.store, index);
                                  },
                                  details: item.details!,
                                  dueDate: item.dueDate?.toIso8601String() ??
                                      'no time alloted',
                                  icon: Icon(
                                    Icons.more_horiz_rounded,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(
                              child: AppText(
                                text: 'Board',
                                fontSize: 50,
                              ),
                            );
                    }),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          onPressed: () {
            showModalBottomSheet(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.9),
                isScrollControlled: true,
                backgroundColor: Colors.black,
                context: context,
                builder: (context) {
                  return const TodoForm();
                });
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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

  Widget boardsAndActive(BuildContext context, Store<AppState> store) {
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
            onTap: () {
              if (onActiveSelected) {
                return;
              } else {
                setState(() {
                  onActiveSelected = !onActiveSelected;
                });

                showActiveTodo(
                    filter: ItemFilter.active, context: context, store: store);
              }
            },
            child: Container(
              width: 100,
              height: 35,
              decoration: BoxDecoration(
                border: onActiveSelected
                    ? null
                    : Border.all(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(20),
                color: (onActiveSelected)
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.background,
              ),
              child: Center(
                child: AppText(
                  text: 'Active',
                  fontWeight: (onActiveSelected) ? FontWeight.bold : null,
                  color: (onActiveSelected) ? Colors.black : Colors.white,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (onActiveSelected) {
                setState(() {
                  onActiveSelected = !onActiveSelected;
                });
                showActiveTodo(
                    filter: ItemFilter.done, context: context, store: store);
              }
            },
            child: Container(
              width: 100,
              height: 35,
              decoration: BoxDecoration(
                border: (onActiveSelected)
                    ? Border.all(color: Colors.white, width: 1)
                    : null,
                borderRadius: BorderRadius.circular(20),
                color: (onActiveSelected)
                    ? Theme.of(context).colorScheme.background
                    : Theme.of(context).colorScheme.primary,
              ),
              child: Center(
                child: AppText(
                  fontWeight: (onActiveSelected) ? null : FontWeight.bold,
                  text: 'Done',
                  color: (onActiveSelected) ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget>? weekdays(BuildContext context) {
    if (onTaskSelected == true) {
      return List.generate(weeks.length, (index) {
        return Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedWeekIndex = index;
              });
            },
            child: SizedBox(
              child: Center(
                child: AppText(
                  text: weeks[index],
                  color: (selectedWeekIndex == index)
                      ? Colors.white
                      : Colors.white.withOpacity(0.3),
                ),
              ),
            ),
          ),
        );
      });
    } else {
      return null;
    }
  }

  Future<dynamic> editor(
      BuildContext context, Store<AppState> store, int index) {
    return showDialog(
        context: context,
        builder: ((context) {
          return SimpleDialog(
              backgroundColor: Colors.black,
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                  side: BorderSide.none,
                  borderRadius: BorderRadius.circular(10)),
              title: AppText(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                text: 'Edit Todo',
                color: Theme.of(context).colorScheme.onBackground,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              children: [
                SizedBox(
                  height: 265,
                  width: 300,
                  child: Column(
                    children: [
                      AppRichTextInputField(
                          color: Theme.of(context).colorScheme.onBackground,
                          context,
                          hintText: 'Title',
                          controller: dialogController),
                      spaceVertical,
                      AppRichTextInputField(
                        color: Theme.of(context).colorScheme.onBackground,
                        context,
                        hintText: 'Description',
                        controller: dialogDetailsController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomButton(
                              title: 'Cancel',
                              ontap: () => Navigator.pop(context),
                              color: Colors.red),
                          spaceHorizontal,
                          CustomButton(
                              title: 'Update',
                              ontap: () async {
                                if (dialogController.text.isEmpty &&
                                    dialogDetailsController.text.isEmpty) {
                                  return;
                                } else {
                                  editTodo(
                                      context: context,
                                      store: store,
                                      details: dialogDetailsController.text,
                                      title: dialogController.text,
                                      index: index);
                                  setState(() {
                                    dialogController.text = '';
                                    dialogDetailsController.text = '';
                                  });
                                  Navigator.pop(context);
                                }
                              },
                              color: Colors.green),
                        ],
                      ),
                    ],
                  ),
                ),
              ]);
        }));
  }
}

class _ViewModel {
  const _ViewModel({required this.store, required this.context});

  final Store<AppState> store;
  final BuildContext context;

  List<Item> filteredByDay(String day) => selectItemsByDay(day, store);
  List<Item> filteredByCategory(Categories category) =>
      selectItemsByCategories(category, store);

  int complete() => store.state.itemListState.completed;
  int notComplete() => store.state.itemListState.notCompleted;
}
