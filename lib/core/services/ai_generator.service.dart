import 'dart:convert';

import 'package:google_generative_ai/google_generative_ai.dart';

import '../../core.dart';
import '../config/env.dart';
import '../models/training_plan.model.dart';

part 'ai_generator.service.g.dart';

@riverpod
AiGeneratorService aiGeneratorService(Ref ref) {
  return AiGeneratorService();
}

class AiGeneratorService {
  final model = GenerativeModel(
    model: "gemini-2.0-flash",
    apiKey: Env.geminiApiKey,
    generationConfig: GenerationConfig(responseMimeType: "application/json"),
  );

  Future<TrainingPlan> generateMockData() async {
    return TrainingPlan(
      title: "Mock Training Plan",
      plans: [
        PlanItem(exercise: "Push-ups", sets: 3, reps: [10, 15, 20], weights: [0, 0, 0]),
        PlanItem(exercise: "Pull-ups", sets: 3, reps: [10, 15, 20], weights: [0, 0, 0]),
      ],
    );
  }

  Future<TrainingPlan> generateWithGemini(String userInput) async {
    final prompt =
        '''
        Convert this into a JSON training plan with training-title,
        
        Format:
        {
          "title": "training-title",
          "plans": [
              {
                "exercise": "exercise-name",
                "sets": int,
                "reps": [int, int, ...],
                "weights": [double, double, ...]
              },
          ],
        }
        
        Example:
        {
          "title": "Push-ups",
          "plans": [
              {
                "exercise": "Push-ups",
                "sets": 3,
                "reps": [15, 12, 11],
                "weights": [0.0, 0.0, 0.0],
                },
              {
                "exercise": "Pull-ups",
                "sets": 3,
                "reps": [15, 12, 11],
                "weights": [0.0, 0.0, 0.0],
              },
              {
                "exercise": "Squats",
                "sets": 3,
                "reps": [15, 12, 11],
                "weights": [70.0, 75.0, 80.0],
              }
            ],  
            }
            
            You are a Personal Trainer. Create a Training plan based on the user's input with corresponding weights and reps in each set.
            The weight has to increase with each set, and the reps should decrease with each set.
            Note: dont send response in List<dynamic> format it should be json object.
    User Input: $userInput
    ''';

    final result = await model.generateContent([Content.text(prompt)]);
    final content = result.text;

    if (content == null || content.isEmpty) {
      throw Exception('No Content Generated');
    }
    return TrainingPlan.fromJson(jsonDecode(content));
  }
}
