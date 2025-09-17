// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_plan.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TrainingPlan _$TrainingPlanFromJson(Map<String, dynamic> json) =>
    _TrainingPlan(
      title: json['title'] as String,
      plans: (json['plans'] as List<dynamic>)
          .map((e) => PlanItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TrainingPlanToJson(_TrainingPlan instance) =>
    <String, dynamic>{
      'title': instance.title,
      'plans': instance.plans.map((e) => e.toJson()).toList(),
    };

_PlanItem _$PlanItemFromJson(Map<String, dynamic> json) => _PlanItem(
  exercise: json['exercise'] as String,
  sets: json['sets'] as num,
  reps: (json['reps'] as List<dynamic>).map((e) => e as num).toList(),
  weights: (json['weights'] as List<dynamic>).map((e) => e as num).toList(),
);

Map<String, dynamic> _$PlanItemToJson(_PlanItem instance) => <String, dynamic>{
  'exercise': instance.exercise,
  'sets': instance.sets,
  'reps': instance.reps,
  'weights': instance.weights,
};
