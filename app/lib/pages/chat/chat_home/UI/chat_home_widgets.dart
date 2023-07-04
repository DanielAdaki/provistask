import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provitask_app/common/conexion_common.dart';
import 'package:provitask_app/controllers/location/location_controller.dart';
import 'package:provitask_app/models/data/client_information.dart';
import 'package:provitask_app/pages/chat/chat_conversation/UI/chat_conversation_controller.dart';
import 'package:provitask_app/pages/chat/chat_conversation/propuestas/chat_propuesta_controller.dart';
import 'package:provitask_app/pages/chat/chat_home/UI/chat_home_controller.dart';
import 'package:provitask_app/controllers/home/home_controller.dart';
import 'package:provitask_app/pages/profile_provider/UI/profile_provider_controller.dart';

class ChatHomeWidgets {
  final _controller = Get.put<ChatHomeController>(ChatHomeController());

  AppBar chatHomeAppBar() {
    return AppBar(
      title: Text(
        'Chat',
        style: TextStyle(
          color: Colors.amber[800],
          fontSize: 28,
        ),
      ),
      leading: IconButton(
          onPressed: () {
            if (ClientInformation.clientIsProvider!) {
              Get.put<ProfileProviderController>(ProfileProviderController());
              Get.toNamed('/profile_provider');
            } else {
              Get.put<HomeController>(HomeController());
              Get.toNamed('/home');
            }
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.amber[800],
          )),
      backgroundColor: Colors.white,
      foregroundColor: Colors.amber[800],
      elevation: 0,
    );
  }

  Widget chatHomeSearchBar() {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: Get.width * 0.7,
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(90),
            ),
            suffixIcon: const Icon(Icons.search),
          ),
        ),
      ),
    );
  }

  Widget chatHomeChats() {
    return SizedBox(
      height: Get.height * 0.8,
      width: Get.width * 1,
      child: Center(
        child: ListView(
          children: List.generate(
            _controller.conversation.length,
            (index) => _chatTile(_controller.conversation[index]),
          ),
        ),
      ),
    );
  }

  Widget _chatTile(item) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        InkWell(
          onTap: () {
            // Get.put<ChatConversationController>(ChatConversationController());
            // elimino el controlador anterior para que no se acumulen los mensajes
            Get.delete<ChatConversationController>();
            Get.delete<ChatPropuestaController>();
            // elimino controlador de location para que no se acumulen los mensajes
            Get.delete<LocationController>();

            Get.toNamed('/chat/${item["id"]}');
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(children: [
              Stack(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    margin: const EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: item["attributes"]["contact"]["avatar_image"] !=
                                null
                            ? NetworkImage(ConexionCommon.hostBase +
                                item["attributes"]["contact"]["avatar_image"])
                            : const AssetImage(
                                    "assets/images/REGISTER TASK/avatar.jpg")
                                as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: item["attributes"]["contact"]["online"] == true
                            ? Colors.green
                            : Colors.red,
                      ),
                      child: Icon(
                        Icons.circle,
                        color: item["attributes"]["contact"]["online"] == true
                            ? Colors.green
                            : Colors.red,
                        size: 15,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item["attributes"]["contact"]["name"] +
                        " " +
                        item["attributes"]["contact"]["lastname"],
                    style: TextStyle(
                        color: Colors.indigo[800],
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: Get.width * 0.4,
                    child: Text(
                      item["attributes"]["lastMessage"] != false &&
                              item["attributes"]["lastMessage"] != null
                          ? item["attributes"]["lastMessage"]["message"]
                          : "No messages",
                      maxLines: 2,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                //muestro la hora item["attributes"]["lastMessage"]["createdAt"] formteado con la forma Mes dia, hora:minuto
                item["attributes"]["lastMessage"] != false &&
                        item["attributes"]["lastMessage"] != null
                    ? _formatDateTime(
                        item["attributes"]["lastMessage"]["createdAt"])
                    : "",

                style: TextStyle(
                    color: Colors.indigo[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              )
            ]),
          ),
        ),
        Divider(
          color: Colors.grey[400],
          thickness: 1,
          height: 30,
          endIndent: 10,
          indent: 10,
        ),
      ],
    );
  }

  List<ChatTile> chatList = [
    ChatTile('assets/images/person.jpeg', 'Name Client',
        'Hello client apdoaj spdoaj psodja psodjap ojdpao sj', '12:30 pm', 1),
    ChatTile('assets/images/person.jpeg', 'Name Client', 'Hello client',
        '12:30 pm', 2),
    ChatTile('assets/images/person.jpeg', 'Name Client', 'Hello client',
        '12:30 pm', 3),
  ];
}

String _formatDateTime(String dateTimeString) {
  // Parsea el String de fecha y hora a un objeto DateTime
  DateTime dateTime = DateTime.parse(dateTimeString);

  // Formatea la fecha y hora en el formato "MMM dd, HH:mm"
  String formattedDateTime = DateFormat('MMM dd, HH:mm').format(dateTime);

  return formattedDateTime;
}

class ChatTile {
  String avatarImage;
  String name;
  String message;
  String time;
  int idClient;

  ChatTile(this.avatarImage, this.name, this.message, this.time, this.idClient);
}
