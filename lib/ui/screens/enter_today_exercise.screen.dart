import '../../core.dart';
import '../../core/screens_controllers/ai_trainer.notifier.dart';
import 'ai_training_plan_viewer.screen.dart';

class EnterTodayExercise extends ConsumerWidget {
  final formKey = GlobalKey<FormState>();
  final inputController = TextEditingController();

  EnterTodayExercise({super.key});

  void _onSubmitted(BuildContext context, WidgetRef ref) {
    if (formKey.currentState!.validate()) {
      ref.read(aiTrainerNotifierProvider.notifier).generate(inputController.text);
      Navigator.push(context, MaterialPageRoute(builder: (_) => AiTrainingPlanViewer()));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: formKey,
          child: Column(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.sports_martial_arts, size: 63, color: theme.primaryColor),
              Text(
                "What Exercise are we doing Today?",
                style: theme.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
                textAlign: TextAlign.center,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "abs workout, full body workout, etc."),
                controller: inputController,
                validator: (value) {
                  return ref.read(aiTrainerNotifierProvider.notifier).inputValidator(value);
                },
                onFieldSubmitted: (value) {
                  _onSubmitted(context, ref);
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _onSubmitted(context, ref);
        },
        child: Icon(Icons.send),
      ),
    );
  }
}
