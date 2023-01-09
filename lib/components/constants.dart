import 'package:flutter/material.dart';

const spaceVertical = SizedBox(
  height: 15,
);
const spaceHorizontal = SizedBox(
  width: 15,
);


            // }

              // return SingleChildScrollView(
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       SizedBox(
              //         height: 500,
              //         child: ListView.builder(
              //           physics: const AlwaysScrollableScrollPhysics(),
              //           shrinkWrap: true,
              //           itemCount: list.length,
              //           itemBuilder: ((context, index) {
              //             return Padding(
              //               padding: const EdgeInsets.all(8.0),
              //               child: Dismissible(
              //                 confirmDismiss: (direction) async {
              //                   return (list[index].done == true);
              //                 },
              //                 // direction: DismissDirection.endToStart,
              //                 resizeDuration: const Duration(seconds: 1),
              //                 direction: DismissDirection.endToStart,
              //                 background: const CustomDismissedContainer(
              //                     isDelete: true,
              //                     color: Colors.red,
              //                     icon: Icons.delete),
              //                 onDismissed: (direction) {
              //                   print('before deletion ${list.length}');
              //                   TodoManager.completedCounter--;
              //                   viewModel.store
              //                       .dispatch(RemoveAction(index: index));
              //                   print(
              //                       'after deletion ${list.length},  ${list.last.title} ');
              //                   previewSuccess(
              //                       message: 'todo item deleted',
              //                       context: context);
              //                 },
              //                 key: PageStorageKey(list[index]),
              //                 child: TextCard(
              //                   iconSecondary: Icons.edit,
              //                   ontapIconSecondary: () {
              //                     editDialog(context, index, viewModel.store);
              //                   },
              //                   time: list[index].createdAt.year.toString() +
              //                       list[index].createdAt.month.toString(),
              //                   todoName: '${list[index].title}',
              //                   icon: list[index].done
              //                       ? Icons.check_circle_outline_outlined
              //                       : Icons.circle_outlined,
              //                   ontapIcon: () {
              //                     setState(() {});
              //                     viewModel.store.dispatch(
              //                         ToggleItemSelection(index: index));
              //                     if (list[index].done == true) {
              //                       Map<String, dynamic> dataToSave = {
              //                         'done': !isCompleted,
              //                       };

              //                       //   FirebaseFirestore.instance
              //                       //       .collection('newUsers')
              //                       //       .doc(firebaseUser!.uid)
              //                       //       .collection('todos')
              //                       //       .doc(firebaseUser!.uid)
              //                       //       .update(dataToSave);
              //                       // } else {
              //                       //   Map<String, dynamic> dataToSave = {
              //                       //     'done': isCompleted,
              //                       //   };

              //                       //   FirebaseFirestore.instance
              //                       //       .collection('newUsers')
              //                       //       .doc(firebaseUser!.uid)
              //                       //       .collection('todos')
              //                       //       .doc(firebaseUser!.uid)
              //                       //       .update(dataToSave);
              //                     }

              //                     (list[index].done == true)
              //                         ? TodoManager.completedCounter++
              //                         : TodoManager.completedCounter--;
              //                     (list[index].done == false)
              //                         ? TodoManager.notCompletedCounter++
              //                         : TodoManager.notCompletedCounter--;
              //                   },
              //                   color: viewModel.store.state
              //                               .itemListState[index].done ==
              //                           false
              //                       ? Colors.red
              //                       : Colors.green,
              //                 ),
              //               ),
              //             );
              //           }),
              //         ),
              //       ),
              //       const SizedBox(
              //         height: 30,
              //       ),
              //       TodoManager(
              //         text: '${TodoManager.completedCounter}',
              //         color: Colors.green,
              //         title: 'Completed',
              //         icon: Icons.price_check_outlined,
              //         isCompleted: true,
              //       ),
              //       TodoManager(
              //         text: '${TodoManager.notCompletedCounter}',
              //         color: Colors.red,
              //         title: 'In Progress',
              //         icon: Icons.hourglass_bottom,
              //         isCompleted: true,
              //       )
              //     ],
              //   ),
              // );