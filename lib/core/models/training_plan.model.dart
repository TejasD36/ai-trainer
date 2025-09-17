import '../../core.dart';

part 'training_plan.model.freezed.dart';

@freezed
sealed class TrainingPlan with _$TrainingPlan {
  const factory TrainingPlan({required String title, required DateTime startDate, required List<PlanItem> plans}) = _TrainingPlan;
}

@freezed
sealed class PlanItem with _$PlanItem {
  const factory PlanItem({required String exercise, required num sets, required List<num> reps, required List<num> weights}) = _PlanItem;
}
