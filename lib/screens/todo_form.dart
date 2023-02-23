import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:todo_new/Appstate/appstate.dart';
import 'package:todo_new/async_actions.dart';
import 'package:todo_new/components/app_text.dart';
import 'package:todo_new/components/app_text_input_field.dart';
import 'package:todo_new/components/constants.dart';
import 'package:todo_new/list/model.dart';
import 'package:todo_new/list/selectors.dart';

class TodoForm extends StatefulWidget {
  const TodoForm({Key? key}) : super(key: key);

  @override
  State<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  late TextEditingController detailsController;
  late TextEditingController titleController;
  late TextEditingController dateController;
  final formKey = GlobalKey<FormState>();
  // bool onCategorySelected;
  Color? _selectedColor;
  int selectedIndex = 0;

  List<Color> todoColors = [
    Colors.yellow,
    Colors.green,
    Colors.purple,
    Colors.pink
  ];

  List<Categories> categories = [
    Categories.urgent,
    Categories.personal,
    Categories.work
  ];

  @override
  void initState() {
    super.initState();
    detailsController = TextEditingController();
    titleController = TextEditingController();
    dateController = TextEditingController();
  }

  @override
  void dispose() {
    detailsController.dispose();
    titleController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      converter: (Store<AppState> store) =>
          _ViewModel(context: context, store: store),
      builder: (BuildContext context, _ViewModel vm) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.black,
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: AppText(
                        fontSize: 15,
                        text: 'Cancel',
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    AppText(
                      fontWeight: FontWeight.bold,
                      text: 'New Todo',
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    GestureDetector(
                        onTap: () {
                          addTodo(
                              (dateController.text.isNotEmpty)
                                  ? DateTime.parse(dateController.text)
                                  : DateTime.now(),
                              category: categories[selectedIndex],
                              store: vm.store,
                              context: context,
                              details: detailsController.text,
                              title: titleController.text,
                              color: _selectedColor ?? Colors.white);

                          Navigator.pop(context);
                        },
                        child: AppText(
                          fontSize: 15,
                          text: 'Add',
                          color: Theme.of(context).colorScheme.primary,
                        )),
                  ],
                ),
                const SizedBox(height: 20),
                Form(
                  key: formKey,
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
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      spaceVertical,
                      DateTimePicker(
                        controller: dateController,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        dateLabelText: 'Due Date',
                        icon: const Icon(Icons.event),
                        onChanged: (value) {},
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      AppText(
                        text: 'Select a Category',
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: category(context)),
                      const SizedBox(
                        height: 30,
                      ),
                      AppText(
                        text: 'Pick a color',
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      spaceVertical,
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: todoColors.map((color) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedColor = color;
                                  });
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  margin: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      border: (_selectedColor == color)
                                          ? Border.all(
                                              width: 3, color: Colors.white)
                                          : null,
                                      shape: BoxShape.circle,
                                      color: color),
                                ),
                              );
                            }).toList()),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> category(BuildContext context) {
    return List.generate(categories.length, (index) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: (selectedIndex == index)
                      ? LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Theme.of(context).colorScheme.primary,
                            Colors.indigo,
                          ],
                        )
                      : null,
                  color: !(selectedIndex == index) ? Colors.black : null),
              padding: const EdgeInsets.all(8),
              height: 80,
              width: 80,
              child: Column(
                children: [
                  AppText(
                    text: categorySeletor(categories[index]),
                    color: Theme.of(context).colorScheme.onBackground,
                    maxLines: 2,
                    fontSize: 17,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  iconSelector(categories[index])
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class _ViewModel {
  final Store<AppState> store;
  final BuildContext context;

  const _ViewModel({required this.context, required this.store});
}
