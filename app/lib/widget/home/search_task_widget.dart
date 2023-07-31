import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:provitask_app/controllers/home/home_controller.dart';

class SearchTask extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();

  SearchTask({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TypeAheadFormField(
              textFieldConfiguration: TextFieldConfiguration(
                enableSuggestions: false,
                enableInteractiveSelection: false,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'Try "moving" or "air repair"',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(90),
                    borderSide: const BorderSide(color: Color(0xFFA0A0A0)),
                  ),
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: controller.loadingSearch.value == false
                      ? null
                      : const CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                ),
              ),
              suggestionsCallback: (pattern) async {
                if (pattern.length > 2) {
                  controller.onTextChanged(pattern);
                  controller.searchText.value = pattern;

                  // Retorna la lista de sugerencias del controlador.
                }
                return controller.suggestions;
              },
              itemBuilder: (context, Map suggestion) {
                return ListTile(
                  title: Text(suggestion['name']),
                );
              },
              onSuggestionSelected: (Map suggestion) {
                // Llama al método onSuggestionSelected del controlador cuando se selecciona una sugerencia.
                // mando a register_task con el id de la categoria

                Get.toNamed('/register_task', arguments: {
                  'id': suggestion['id'],
                  'name': suggestion['name'],
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
