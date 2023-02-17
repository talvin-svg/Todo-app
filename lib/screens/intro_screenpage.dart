import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:todo_new/Appstate/appstate.dart';
import 'package:todo_new/Appstate/reducer.dart';
import 'package:todo_new/components/app_text.dart';
import 'package:todo_new/components/app_text_input_field.dart';
import 'package:todo_new/components/constants.dart';
import 'package:todo_new/components/scaffold_error_message.dart';
import 'package:todo_new/components/todo_manager.dart';
import 'package:todo_new/list/actions/actions.dart';
import 'package:todo_new/list/model.dart';
import 'package:todo_new/list/state.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});
  static const String id = 'intro';
  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  bool onTaskSelected = true;
  bool onActiveSelected = true;
  int selectedIndex = -1;
  final TextEditingController detailsController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    detailsController.dispose();
    dateController.dispose();
    titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back_ios)),
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
              boardsAndActive(context, vm.store),
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
              Expanded(
                child: ListView.builder(
                    itemCount: vm.filtered.length,
                    itemBuilder: (context, index) {
                      final item = vm.filtered.elementAt(index);
                      if (vm.filtered.isEmpty) {
                        return TodoManager(
                          color: Theme.of(context).colorScheme.primary,
                          title:
                              'Click the icon on the top right to get started! , ',
                          details: 'This is an auto generated todo item',
                          dueDate: '',
                          icon: const Icon(Icons.check),
                        );
                      }
                      return Padding(
                          padding: const EdgeInsets.all(10),
                          child: TodoManager(
                            color: item.color!,
                            title: item.title!,
                            ontap: () {},
                            details: detailsController.text,
                            dueDate: dateController.text,
                            icon: const Icon(Icons.check),
                          ));
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: FloatingActionButton(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          child: Icon(
                            Icons.add,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                                backgroundColor: Colors.black,
                                context: context,
                                builder: (context) {
                                  return Column(
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () => Navigator.pop(context),
                                            child: AppText(
                                              text: 'Cancel',
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                          ),
                                          AppText(
                                            text: 'New Todo',
                                            fontSize: 20,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground,
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                _addTodo(vm.store);
                                                Navigator.pop(context);
                                              },
                                              child: AppText(
                                                text: 'Add',
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              )),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      addTodoForm(context)
                                    ],
                                  );
                                });
                          })),
                ],
              )
            ],
          );
        },
      ),
    );
  }

  void _addTodo(Store<AppState> store) {
    if (detailsController.text.isNotEmpty && titleController.text.isNotEmpty) {
      final itemTitle = titleController.text;
      final itemDetails = detailsController.text;
      store.dispatch(
        AddItemAction(
          item: Item(
              color: Colors.yellow, title: itemTitle, details: itemDetails),
        ),
      );
      detailsController.text = '';
      titleController.text = '';
    } else {
      previewError(
          message: 'Please make sure every field is not empty',
          context: context);
    }
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
                store.dispatch(const ChangeFilterAction(ItemFilter.active));
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
                  store.dispatch(const ChangeFilterAction(ItemFilter.done));
                });
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

  Widget addTodoForm(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            Card(
              child: Column(
                children: [
                  AppRichTextInputField(
                    context,
                    hintText: 'Title',
                    controller: titleController,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ],
              ),
            ),
            const Divider(),
            Card(
              child: AppRichTextInputField(
                context,
                hintText: 'Description',
                controller: detailsController,
                color: Colors.grey,
              ),
            ),
            spaceVertical,
            DateTimePicker(
              controller: dateController,
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              dateLabelText: 'Date',
              icon: const Icon(Icons.event),
              onChanged: (value) {
                print(value);
              },
            )
          ],
        ));
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
