import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provitask_app/models/tasks/task_approced_model.dart';

import 'package:provitask_app/pages/freelancers/UI/freelancers_controller.dart';
import 'package:provitask_app/pages/tasks/UI/tasks_controller.dart';
import 'package:provitask_app/services/preferences.dart';
import 'package:provitask_app/widget/provider/provider_perfil_dialog.dart';
import 'package:provitask_app/widget/tasks/task_details_widget.dart';

final prefs = Preferences();

class TasksWidgets {
  // llamo la spreferencias de usaurio

  //user

  final user = prefs.user;

  final _controller = Get.put<TasksController>(TasksController());

  final _freelancersController = Get.put<FreelancersController>(
      FreelancersController()); // llamo al controlador de freelancers

  Widget tasksFloatingButton() {
    return Material(
        type: MaterialType.transparency,
        child: prefs.user?["isProvider"] == true
            ? Container()
            : Ink(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[400]!, width: 3.5),
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: InkWell(
                  //This keeps the splash effect within the circle
                  borderRadius: BorderRadius.circular(
                      1000.0), //Something large to ensure a circle
                  onTap: () {
                    Get.toNamed('/register_task');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.add,
                      size: 45.0,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
              ));
  }

  Widget tasksTitleTop() {
    return Container(
      width: Get.width,
      height: Get.height * 0.1,
      padding: const EdgeInsets.only(left: 10),
      alignment: Alignment.bottomLeft,
      child: Text(
        'Tasks',
        style: TextStyle(
          fontSize: 20,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
          color: Colors.amber[900],
        ),
      ),
    );
  }

  Widget tasksSelectionType() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () async => {
            _controller.programmedOrCompleted.value = 1,
            _controller.currentPage = 1,
            await _controller.getTasks(),
          },
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: _controller.programmedOrCompleted.value != 1
                ? MaterialStateProperty.all(Colors.transparent)
                : MaterialStateProperty.all(Colors.amber[800]),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(90),
                  side: BorderSide(
                      color: _controller.programmedOrCompleted.value != 1
                          ? Colors.grey
                          : Colors.transparent)),
            ),
          ),
          child: Text(
            'Programmed',
            style: TextStyle(
              color: _controller.programmedOrCompleted.value != 1
                  ? Colors.grey
                  : Colors.white,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () async => {
            _controller.programmedOrCompleted.value = 0,
            _controller.currentPage = 1,
            await _controller.getTasks(),
          },
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: _controller.programmedOrCompleted.value != 0
                ? MaterialStateProperty.all(Colors.transparent)
                : MaterialStateProperty.all(Colors.amber[800]),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(90),
                  side: BorderSide(
                      color: _controller.programmedOrCompleted.value != 0
                          ? Colors.grey
                          : Colors.transparent)),
            ),
          ),
          child: Text(
            'Completed',
            style: TextStyle(
              color: _controller.programmedOrCompleted.value != 0
                  ? Colors.grey
                  : Colors.white,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () async => {
            _controller.programmedOrCompleted.value = 2,
            // reseteo la paginacion

            _controller.currentPage = 1,

            await _controller.getTasks(),
          },
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: _controller.programmedOrCompleted.value != 2
                ? MaterialStateProperty.all(Colors.transparent)
                : MaterialStateProperty.all(Colors.amber[800]),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(90),
                  side: BorderSide(
                      color: _controller.programmedOrCompleted.value != 2
                          ? Colors.grey
                          : Colors.transparent)),
            ),
          ),
          child: Text(
            'Canceled',
            style: TextStyle(
              color: _controller.programmedOrCompleted.value != 2
                  ? Colors.grey
                  : Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget tasksNoCompleted() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Image.asset(
            'assets/images/no_tasks.png',
            width: Get.width,
            height: Get.height * 0.4,
          ),
          // texto condicional de acuerdo al valor de  programmedOrCompleted

          Text(
            _controller.programmedOrCompleted.value == 1
                ? 'You have no tasks programmed'
                : _controller.programmedOrCompleted.value == 2
                    ? 'You have no tasks canceled'
                    : 'You have no tasks completed',
            style: TextStyle(
              fontSize: 20,
              color: Colors.indigo[900],
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Book a task today.',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'When the task is completed, you can see it here',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 15,
            ),
          )
        ],
      ),
    );
  }

  Widget taskProCard(TaskData item) {
    return GestureDetector(
      onTap: () async {
        try {
          _controller.isLoading.value = true;

          List<Future> futures = [
            _controller.getTask(item.id),
            // controller.getComments(item.id),
          ];

          // Ejecutar las funciones en paralelo
          await Future.wait(futures);

          Get.dialog(
            Dialog(
              insetPadding: const EdgeInsets.all(0),
              child: TaskDetailDialog(task: _controller.task),
            ),
          );
          _controller.isLoading.value = false;
        } catch (e) {
          _controller.isLoading.value = false;
        }
      },
      child: Container(
        width: Get.width * 9,
        height: Get.height * 0.23,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Center(
          child: Stack(
            children: [
              Container(
                width: Get.width * 1,
                height: Get.height * 0.23,
                padding: const EdgeInsets.only(top: 10, bottom: 15, right: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ]),
                child: Row(
                  children: [
                    Flexible(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () async {
                          //ProgressDialog pd = ProgressDialog(context: Get.context);
                          try {
                            _controller.isLoading.value = true;

                            List<Future> futures = [
                              _freelancersController.getPerfilProvider(
                                  item.provider.id, true)
                              // controller.getComments(item.id),
                            ];

                            // Ejecutar las funciones en paralelo
                            await Future.wait(futures);

                            Get.dialog(
                              Dialog(
                                insetPadding: const EdgeInsets.all(0),
                                child: ProfileDialog(
                                  perfilProvider: _freelancersController
                                      .perfilProvider.value,
                                  general: true,
                                ),
                              ),
                            );
                            _controller.isLoading.value = false;
                          } catch (e) {
                            _controller.isLoading.value = false;
                          }
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: Get.width * 0.3,
                              height: Get.width * 0.2,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  // si item.avatar es null, se usa el avatar por defecto

                                  image: NetworkImage(item.provider.avatar),

                                  fit: BoxFit.cover,
                                ),
                                shape: BoxShape.circle,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: Text(
                                item.provider.name +
                                    ' ' +
                                    item.provider.lastname,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 4,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                //las primeras 10 letras de la descripcion item["attributes"]["description"] capitalizando la primera letra
                                Tooltip(
                                  message: item.skill.name,
                                  child: Text(
                                    item.skill.shortName,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.indigo[800],
                                      fontWeight: FontWeight.w800,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 16,
                                width: 16,
                                margin: const EdgeInsets.only(right: 8),
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/REGISTER TASK/marca-de-verificacion.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Text(
                                /* texto condicional de acuerdo a longitud de la tarea item["attributes"]["taskLength"]
                                  que puede tener balores "small", "medium" o "large
                                */
                                item.taskLength == "small"
                                    ? 'Short task - 1 hour'
                                    : item.taskLength == "medium"
                                        ? 'Medium task - 3 hours'
                                        : 'Long task - 5 hours',
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 16,
                                width: 16,
                                margin: const EdgeInsets.only(right: 8),
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/REGISTER TASK/verificado.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              // muestro la fecha y hora de la tarea item["attributes"]["datetime"]
                              Text(
                                formatDateTime(item.datetime, item.time),
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 16,
                                width: 16,
                                margin: const EdgeInsets.only(right: 8),
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/REGISTER TASK/entrega.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  formatTransporte(item.transportation),
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            // alineo a la derecha
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed('/chat/${item.conversation}');
                                },
                                child: const Text(
                                  'View chat',
                                  style: TextStyle(
                                    color: Color(0xFF2B1B99),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.blue,
                                size: 12,
                              ),
                            ],
                          ),

                          // un row con dos botones hechos con iconos uno de check y otro para descartar
                          /*  item.status == "acepted"
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        // muestro dialog con dos botones y un texto que dice que marcará la tarea como finalziada
    
                                        Get.defaultDialog(
                                          title: 'Finish task',
                                          content: const Text(
                                              'Are you sure you want to finish this task?'),
                                          textConfirm: 'Yes',
                                          textCancel: 'No',
                                          confirmTextColor: Colors.white,
                                          buttonColor: Colors.green,
                                          cancelTextColor: Colors.black,
                                          onConfirm: () {
                                            // si el usuario confirma, se marca la tarea como finalizada
                                            // y se muestra un snackbar con un texto de confirmació
    
                                            _controller.finishTask(item["id"]);
    
                                            _controller.getTasks();
    
                                            Get.back();
                                            Get.snackbar(
                                              'Task finished',
                                              'The task has been finished',
                                              backgroundColor: Colors.green,
                                              colorText: Colors.white,
                                              snackPosition: SnackPosition.BOTTOM,
                                              duration:
                                                  const Duration(seconds: 3),
                                            );
    
                                            // si el usuario cancela, se cierra el dialog
                                          },
                                          onCancel: () {
                                            // cierro el dialog sin usar back
                                          },
                                        );
                                      },
                                      child: const Icon(
                                        Icons.check,
                                        color: Colors.green,
                                        size: 25,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      onTap: null,
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.red,
                                        size: 25,
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),*/
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

String formatDateTime(DateTime dateTime, String time) {
  String formattedString = '${dateTime.day.toString().padLeft(2, '0')}/'
      '${dateTime.month.toString().padLeft(2, '0')}/'
      '${dateTime.year.toString().padLeft(4, '0')} '
      '${time.substring(0, 5)}';

  return formattedString;
}

String formatTransporte(String transport) {
  return transport == "not_necessary"
      ? "Transport not necessary"
      : transport == "motorcycle"
          ? "Motorcycle"
          : transport == "car"
              ? "Car"
              : "Truck";
}
