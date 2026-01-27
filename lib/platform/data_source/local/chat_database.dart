import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

class ChatDatabase {
  static final ChatDatabase instance = ChatDatabase._internal();
  static Database? _database;

  final _uuid = const Uuid();

  ChatDatabase._internal();

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
      CREATE TABLE messages (
        id TEXT PRIMARY KEY,
        chat_id TEXT NOT NULL,
        content TEXT NOT NULL,
        timestamp INTEGER NOT NULL,
        is_sent_by_me INTEGER DEFAULT 0,
        status TEXT NOT NULL,
        FOREIGN KEY (chat_id) REFERENCES chats (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE INDEX idx_chats_last_message_time 
      ON chats (last_message_time DESC)
    ''');

    await db.execute('''
      CREATE INDEX idx_messages_chat_id_timestamp 
      ON messages (chat_id, timestamp DESC)
    ''');
  }

  Future<void> seedSampleData() async {
    final db = await database;

    // Clear existing data
    await db.delete('messages');
    await db.delete('chats');
    await db.delete('users');

    // Sample users data
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

    // Insert users
    for (final user in users) {
      await db.insert('users', user);
    }

    // Sample chats data
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

    // Sample messages for each chat
    final messages = [
      // Chat 1 messages
      {
        'id': _uuid.v4(),
        'chat_id': 'chat_1',
        'content': 'Hey there! How have you been?',
        'timestamp':
            now.subtract(const Duration(hours: 10)).millisecondsSinceEpoch,
        'is_sent_by_me': 1,
        'status': 'read',
      },
      {
        'id': _uuid.v4(),
        'chat_id': 'chat_1',
        'content': 'I\'m doing great, thanks!',
        'timestamp':
            now.subtract(const Duration(hours: 9)).millisecondsSinceEpoch,
        'is_sent_by_me': 0,
        'status': 'read',
      },
      {
        'id': _uuid.v4(),
        'chat_id': 'chat_1',
        'content': 'Want to catch up later?',
        'timestamp': now
            .subtract(const Duration(hours: 2, minutes: 30))
            .millisecondsSinceEpoch,
        'is_sent_by_me': 0,
        'status': 'delivered',
      },
      {
        'id': _uuid.v4(),
        'chat_id': 'chat_1',
        'content': 'Hi how are you?',
        'timestamp':
            now.subtract(const Duration(hours: 2)).millisecondsSinceEpoch,
        'is_sent_by_me': 0,
        'status': 'delivered',
      },
      // Chat 2 messages
      {
        'id': _uuid.v4(),
        'chat_id': 'chat_2',
        'content': 'What are you up to today?',
        'timestamp':
            now.subtract(const Duration(hours: 5)).millisecondsSinceEpoch,
        'is_sent_by_me': 1,
        'status': 'read',
      },
      {
        'id': _uuid.v4(),
        'chat_id': 'chat_2',
        'content': 'I am going out bro',
        'timestamp':
            now.subtract(const Duration(hours: 3)).millisecondsSinceEpoch,
        'is_sent_by_me': 0,
        'status': 'delivered',
      },
      // Chat 3 messages
      {
        'id': _uuid.v4(),
        'chat_id': 'chat_3',
        'content': 'Missing you ❤️',
        'timestamp':
            now.subtract(const Duration(hours: 6)).millisecondsSinceEpoch,
        'is_sent_by_me': 1,
        'status': 'read',
      },
      {
        'id': _uuid.v4(),
        'chat_id': 'chat_3',
        'content': 'What are you doing darling',
        'timestamp':
            now.subtract(const Duration(hours: 5)).millisecondsSinceEpoch,
        'is_sent_by_me': 0,
        'status': 'read',
      },
      {
        'id': _uuid.v4(),
        'chat_id': 'chat_3',
        'content': 'Just working, will call you soon 😊',
        'timestamp': now
            .subtract(const Duration(hours: 4, minutes: 45))
            .millisecondsSinceEpoch,
        'is_sent_by_me': 1,
        'status': 'read',
      },
      // Chat 4 messages
      {
        'id': _uuid.v4(),
        'chat_id': 'chat_4',
        'content': 'Hi how are you?',
        'timestamp':
            now.subtract(const Duration(hours: 8)).millisecondsSinceEpoch,
        'is_sent_by_me': 0,
        'status': 'delivered',
      },
      {
        'id': _uuid.v4(),
        'chat_id': 'chat_4',
        'content': 'Good! What about you?',
        'timestamp': now
            .subtract(const Duration(hours: 7, minutes: 30))
            .millisecondsSinceEpoch,
        'is_sent_by_me': 1,
        'status': 'delivered',
      },
    ];

    // Insert messages
    for (final message in messages) {
      await db.insert('messages', message);
    }
  }

  Future<void> close() async {
    final db = await database;
    db.close();
  }
}
