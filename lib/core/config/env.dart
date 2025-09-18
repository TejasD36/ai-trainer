import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'GEMINI_API_KEY')
  static const String geminiApiKey = _Env.geminiApiKey;

  @EnviedField(varName: 'OPEN_AI_API_KEY')
  static const String openAiApiKey = _Env.openAiApiKey;

  @EnviedField(varName: 'DEEPSEEK_API_KEY')
  static const String deepseekApiKey = _Env.deepseekApiKey;

  @EnviedField(varName: 'DEEPSEEK_BASE_URL')
  static const String deepseekBaseUrl = _Env.deepseekBaseUrl;
}
