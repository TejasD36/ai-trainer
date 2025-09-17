import 'package:ai_trainer/ui/screens/ai_training_plan_viewer.screen.dart';

import '../../core.dart';
import '../../core/screens_controllers/ai_trainer.notifier.dart';

class EnterTodayExercise extends ConsumerWidget {
  final formKey = GlobalKey<FormState>();
  final inputController = TextEditingController();

  EnterTodayExercise({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final stateNotifier = ref.read(aiTrainerNotifierProvider.notifier);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: formKey,
          child: Column(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.sports_gymnastics, size: 63, color: theme.primaryColor),
              Text(
                "What Exercise are we doing Today?",
                style: theme.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
                textAlign: TextAlign.center,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "abs workout, full body workout, etc."),
                controller: inputController,
                validator: (value) {
                  return stateNotifier.inputValidator(value);
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            stateNotifier.generate(inputController.text);
            Navigator.push(context, MaterialPageRoute(builder: (_) => AiTrainingPlanViewer()));
          }
        },
        child: Icon(Icons.send),
      ),
    );
  }
}
