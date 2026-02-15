import 'package:drift/drift.dart';

import 'settings_repository.dart';
import 'app_database.dart';

class DriftSettingsRepository implements SettingsRepository {
  DriftSettingsRepository(this._db);

  static const String _proUnlockKey = 'pro_unlocked';

  final AppDatabase _db;

  @override
  Future<bool> isProUnlocked() async {
    await _db.ensureReady();
    final rows = await _db.customSelect(
      'SELECT value FROM settings WHERE key = ? LIMIT 1;',
      variables: <Variable<Object>>[
        const Variable<String>(_proUnlockKey),
      ],
    ).get();

    if (rows.isEmpty) {
      return false;
    }
    return rows.first.read<String>('value') == 'true';
  }

  @override
  Future<void> setProUnlocked(bool value) async {
    await _db.ensureReady();
    await _db.customStatement(
      '''
      INSERT INTO settings (key, value) VALUES (?, ?)
      ON CONFLICT(key) DO UPDATE SET value = excluded.value;
      ''',
      <Object>[_proUnlockKey, value.toString()],
    );
  }
}
