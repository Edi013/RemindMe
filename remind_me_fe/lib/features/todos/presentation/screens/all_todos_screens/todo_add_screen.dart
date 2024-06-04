import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:remind_me_fe/core/layout/presentation/layout_by_orientation.dart';
import 'package:remind_me_fe/core/constants.dart';
import 'package:remind_me_fe/features/todos/presentation/controllers/add_controller.dart';

@RoutePage()
class TodoAddScreen extends StatelessWidget {
  const TodoAddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutByOrientation(TodoAddScreenContent());
  }
}

class TodoAddScreenContent extends StatelessWidget {
  final TodoAddController controller = TodoAddController();

  TodoAddScreenContent({Key? key}) : super(key: key);

  Future<void> _selectDate(
      BuildContext context, TextEditingController currentController) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      // ignore: use_build_context_synchronously
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final DateTime selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        currentController.text = controller.formatDate(selectedDateTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: controller.titleController,
                      decoration: const InputDecoration(labelText: 'Title'),
                      validator: (value) =>
                          controller.validateTitleFormField(value),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: controller.descriptionController,
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      validator: (value) =>
                          controller.validateDescriptionFormField(value),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: controller.startDateController,
                      decoration:
                          const InputDecoration(labelText: 'Start Date *'),
                      validator: (value) =>
                          controller.validateStartDateFormField(value),
                      onTap: () =>
                          _selectDate(context, controller.startDateController),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: controller.endDateController,
                      decoration: const InputDecoration(labelText: 'End Date'),
                      validator: (value) =>
                          controller.validateEndDateField(value),
                      onTap: () =>
                          _selectDate(context, controller.endDateController),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: controller.difficultyController,
                      decoration: const InputDecoration(
                        labelText: 'Difficulty *',
                        hintText: difficultyLabelHintText,
                      ),
                      validator: (value) =>
                          controller.validateDifficultyFormField(value),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () => controller.addItem(context),
                      child: const Text('Add Object'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
