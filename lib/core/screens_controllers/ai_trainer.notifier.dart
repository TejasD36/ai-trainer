import '../../core.dart';
import '../models/training_plan.model.dart';
import '../services/ai_generator.service.dart';

part 'ai_trainer.notifier.g.dart';

@Riverpod(keepAlive: true)
class AiTrainerNotifier extends _$AiTrainerNotifier {
  AiGeneratorService get _aiService => ref.read(aiGeneratorServiceProvider);

  @override
  FutureOr<TrainingPlan?> build() async {
    return null;
  }

  Future<void> generate(String? userInput) async {
    try {
      state = AsyncLoading();
      final result = await _aiService.generateMockData();
      state = AsyncData(result);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  String? inputValidator(String? value) {
    if (value == null || value.isEmpty) return "Please enter a value!";
    if (value.length <= 4) return "Please enter at least 5 Characters!";
    return null;
  }
}
