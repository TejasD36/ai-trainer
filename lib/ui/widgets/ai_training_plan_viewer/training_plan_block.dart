import '../../../core.dart';
import '../../../core/models/training_plan.model.dart';

class TrainingPlanBlock extends StatelessWidget {
  final int index;
  final PlanItem plan;

  const TrainingPlanBlock({super.key, required this.index, required this.plan});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.all(14),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.cyan.shade200),
      child: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${index + 1}", style: textTheme.displaySmall),
          Text(plan.exercise, style: textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold)),
          const Divider(),
          Row(
            spacing: 5,
            children: [
              Text("${plan.sets}", style: textTheme.titleLarge),
              Text("SETS"),
            ],
          ),
          Row(
            spacing: 5,
            children: [
              Text(plan.reps.join(" | "), style: textTheme.titleLarge),
              Text("REPS"),
            ],
          ),
          Row(
            spacing: 5,
            children: [
              Text(plan.weights.join(" | "), style: textTheme.titleLarge),
              Text("WEIGHTS"),
            ],
          ),
        ],
      ),
    );
  }
}
