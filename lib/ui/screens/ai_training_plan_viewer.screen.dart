import '../../core.dart';
import '../../core/screens_controllers/ai_trainer.notifier.dart';
import '../widgets/ai_training_plan_viewer/training_plan_block.dart';

class AiTrainingPlanViewer extends ConsumerWidget {
  final _pageController = PageController(viewportFraction: 0.85);

  AiTrainingPlanViewer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final state = ref.watch(aiTrainerNotifierProvider);
    final val = state.value;
    return Scaffold(
      appBar: AppBar(
        title: Text("AI Trainer", style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: state.isLoading
          ? Center(child: CircularProgressIndicator.adaptive())
          : state.hasError
          ? Center(
              child: Text(state.error.toString(), style: TextStyle(color: Colors.red)),
            )
          : val == null
          ? Center(
              child: Text("No workouts plan found", style: TextStyle(fontWeight: FontWeight.bold)),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
                  child: ListTile(
                    leading: Icon(Icons.fitness_center, color: theme.primaryColor),
                    title: Text("${val.title} (${val.plans.length} exercises)", style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                      "Date: ${val.startDate.day} / ${val.startDate.month} / ${val.startDate.year}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: val.plans.length,
                    itemBuilder: (context, index) {
                      return TrainingPlanBlock(index: index, plan: val.plans[index]);
                    },
                  ),
                ),
                TextButton(
                  child: Chip(
                    label: Text("Next", style: theme.textTheme.titleLarge?.copyWith(color: theme.primaryColor)),
                  ),
                  onPressed: () {
                    _pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
                  },
                ),
                Spacer(),
              ],
            ),
    );
  }
}
