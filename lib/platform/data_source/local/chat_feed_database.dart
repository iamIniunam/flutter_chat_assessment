import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ChatFeedDatabase {
  static final ChatFeedDatabase instance = ChatFeedDatabase._internal();
  static Database? _database;

  ChatFeedDatabase._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'chat_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        avatar_url TEXT NOT NULL,
        is_online INTEGER DEFAULT 0,
        last_seen INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE chats (
        id TEXT PRIMARY KEY,
        user_id TEXT NOT NULL,
        last_message TEXT NOT NULL,
        last_message_time INTEGER NOT NULL,
        unread_count INTEGER DEFAULT 0,
        message_status TEXT NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE INDEX idx_chats_last_message_time 
      ON chats (last_message_time DESC)
    ''');
  }

  Future<void> seedSampleData() async {
    final db = await database;

    await db.delete('chats');
    await db.delete('users');

    final users = [
      {
        'id': 'user_1',
        'name': 'John Doe',
        'avatar_url': 'https://i.pravatar.cc/150?img=12',
        'is_online': 1,
        'last_seen': DateTime.now().millisecondsSinceEpoch,
      },
      {
        'id': 'user_2',
        'name': 'Michal',
        'avatar_url': 'https://i.pravatar.cc/150?img=33',
        'is_online': 0,
        'last_seen': DateTime.now()
            .subtract(const Duration(hours: 2))
            .millisecondsSinceEpoch,
      },
      {
        'id': 'user_3',
        'name': 'My Love',
        'avatar_url': 'https://i.pravatar.cc/150?img=45',
        'is_online': 1,
        'last_seen': DateTime.now().millisecondsSinceEpoch,
      },
      {
        'id': 'user_4',
        'name': 'Shamus',
        'avatar_url': 'https://i.pravatar.cc/150?img=52',
        'is_online': 0,
        'last_seen': DateTime.now()
            .subtract(const Duration(hours: 5))
            .millisecondsSinceEpoch,
      },
      {
        'id': 'user_5',
        'name': 'Aliesa sham',
        'avatar_url': 'https://i.pravatar.cc/150?img=47',
        'is_online': 0,
        'last_seen': DateTime.now()
            .subtract(const Duration(days: 1))
            .millisecondsSinceEpoch,
      },
      {
        'id': 'user_6',
        'name': 'Klerence',
        'avatar_url': 'https://i.pravatar.cc/150?img=68',
        'is_online': 0,
        'last_seen': DateTime.now()
            .subtract(const Duration(days: 2))
            .millisecondsSinceEpoch,
      },
      // Story users
      {
        'id': 'user_john',
        'name': 'John',
        'avatar_url': 'https://i.pravatar.cc/150?img=11',
        'is_online': 0,
        'last_seen': DateTime.now()
            .subtract(const Duration(hours: 3))
            .millisecondsSinceEpoch,
      },
      {
        'id': 'user_sheril',
        'name': 'Sheril',
        'avatar_url': 'https://i.pravatar.cc/150?img=23',
        'is_online': 1,
        'last_seen': DateTime.now().millisecondsSinceEpoch,
      },
      {
        'id': 'user_mark',
        'name': 'Mark',
        'avatar_url': 'https://i.pravatar.cc/150?img=15',
        'is_online': 0,
        'last_seen': DateTime.now()
            .subtract(const Duration(hours: 1))
            .millisecondsSinceEpoch,
      },
      {
        'id': 'user_aler',
        'name': 'Aler',
        'avatar_url': 'https://i.pravatar.cc/150?img=60',
        'is_online': 0,
        'last_seen': DateTime.now()
            .subtract(const Duration(hours: 4))
            .millisecondsSinceEpoch,
      },
    ];

    for (final user in users) {
      await db.insert('users', user);
    }

    final now = DateTime.now();
    final chats = [
      {
        'id': 'chat_1',
        'user_id': 'user_1',
        'last_message': 'Hi how are you?',
        'last_message_time':
            now.subtract(const Duration(hours: 2)).millisecondsSinceEpoch,
        'unread_count': 2,
        'message_status': 'delivered',
      },
      {
        'id': 'chat_2',
        'user_id': 'user_2',
        'last_message': 'I am going out bro',
        'last_message_time':
            now.subtract(const Duration(hours: 3)).millisecondsSinceEpoch,
        'unread_count': 1,
        'message_status': 'delivered',
      },
      {
        'id': 'chat_3',
        'user_id': 'user_3',
        'last_message': 'What are you doing darling',
        'last_message_time':
            now.subtract(const Duration(hours: 5)).millisecondsSinceEpoch,
        'unread_count': 0,
        'message_status': 'read',
      },
      {
        'id': 'chat_4',
        'user_id': 'user_4',
        'last_message': 'Hi how are you?',
        'last_message_time':
            now.subtract(const Duration(hours: 8)).millisecondsSinceEpoch,
        'unread_count': 0,
        'message_status': 'sent',
      },
      {
        'id': 'chat_5',
        'user_id': 'user_5',
        'last_message': 'Hi how are you?',
        'last_message_time':
            now.subtract(const Duration(days: 1)).millisecondsSinceEpoch,
        'unread_count': 0,
        'message_status': 'delivered',
      },
      {
        'id': 'chat_6',
        'user_id': 'user_6',
        'last_message': 'See you tomorrow!',
        'last_message_time':
            now.subtract(const Duration(days: 2)).millisecondsSinceEpoch,
        'unread_count': 0,
        'message_status': 'sent',
      },
    ];

    for (final chat in chats) {
      await db.insert('chats', chat);
    }
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
