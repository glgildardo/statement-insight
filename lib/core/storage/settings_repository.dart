abstract class SettingsRepository {
  Future<bool> isProUnlocked();

  Future<void> setProUnlocked(bool value);
}
