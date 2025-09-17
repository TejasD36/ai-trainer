import '../../core.dart';

part 'training_plan.model.freezed.dart';
part 'training_plan.model.g.dart';

@freezed
sealed class TrainingPlan with _$TrainingPlan {
  const factory TrainingPlan({required String title, required List<PlanItem> plans}) = _TrainingPlan;
  factory TrainingPlan.fromJson(Map<String, dynamic> json) => _$TrainingPlanFromJson(json);
}

@freezed
sealed class PlanItem with _$PlanItem {
  const factory PlanItem({required String exercise, required num sets, required List<num> reps, required List<num> weights}) = _PlanItem;
  factory PlanItem.fromJson(Map<String, dynamic> json) => _$PlanItemFromJson(json);
}
