import 'dart:convert';

import 'package:dart_openai/dart_openai.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../../core.dart';
import '../config/env.dart';
import '../models/training_plan.model.dart';

part 'ai_generator.service.g.dart';

@riverpod
AiGeneratorService aiGeneratorService(Ref ref) {
  OpenAI.apiKey = Env.openAiApiKey;
  // OpenAI.baseUrl = Env.deepseekBaseUrl;
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

  Future<TrainingPlan> generate(String userInput) async {
    final systemPrompt = """
      The user will provide a request for a training plan. Your task is to convert this request into a structured JSON format that represents a training plan. The JSON should include the title of the training, the date, and a list of exercises with their respective sets, reps, and weights for each reps.

      EXAMPLE INPUT: 
      full body workout

      EXAMPLE JSON OUTPUT:
      {
        "title": "Full Body Workout",
        "date": "2023-10-01",
        "plan": [
          {"exercise": "Squats", "sets": 3, "reps": [15, 12, 10], "weight": [70.0, 75.0, 80.0]},
          {"exercise": "Overhead Press", "sets": 3, "reps": [12, 10, 8], "weight": [40.0, 45.0, 50.0]},
          {"exercise": "Deadlifts", "sets": 1, "reps": [12], "weight": [80.0]},
        ],
      }
    """;

    // the system message that will be sent to the request.
    final systemMessage = OpenAIChatCompletionChoiceMessageModel(
      role: OpenAIChatMessageRole.system,
      content: [OpenAIChatCompletionChoiceMessageContentItemModel.text(systemPrompt)],
    );

    final userMessage = OpenAIChatCompletionChoiceMessageModel(
      role: OpenAIChatMessageRole.user,
      content: [OpenAIChatCompletionChoiceMessageContentItemModel.text(userInput)],
    );

    final requestMessages = [systemMessage, userMessage];
    final response = await OpenAI.instance.chat.create(
      temperature: 0,
      model: "deepseek-chat",
      messages: requestMessages,
      responseFormat: {"type": "json_object"},
    );

    final t = response.choices.first.message.content?.first.text;
    if (t == null || t.isEmpty) {
      throw Exception('No response from model');
    }

    final List<dynamic> jsonList = jsonDecode(t);
    return TrainingPlan.fromJson(jsonList.first);
  }
}
