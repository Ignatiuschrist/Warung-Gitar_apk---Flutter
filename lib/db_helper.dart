import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'toko_gitar.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        // Users table
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nama TEXT,
            username TEXT,
            email TEXT,
            password TEXT
          )
        ''');

        // Items table
        await db.execute('''
          CREATE TABLE items (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nama TEXT,
            tipe TEXT,
            harga TEXT,
            merk TEXT,
            gambar TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
            CREATE TABLE items (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              nama TEXT,
              tipe TEXT,
              harga TEXT,
              merk TEXT,
              gambar TEXT
            )
          ''');
        }
      },
    );
  }

  // Insert into database
  Future<void> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    await db.insert('users', user, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Get all users from database
  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await database;
    return await db.query('users');
  }

  // Update user in database
  Future<int> updateUser(int id, Map<String, dynamic> user) async {
    final db = await database;
    return await db.update('users', user, where: 'id = ?', whereArgs: [id]);
  }

  // Delete user from database
  Future<int> deleteUser(int id) async {
    final db = await database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  // Insert item into items table
  Future<void> insertItem(Map<String, dynamic> item) async {
    final db = await database;
    await db.insert('items', item, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Get all items from items table
  Future<List<Map<String, dynamic>>> getItems() async {
    final db = await database;
    return await db.query('items');
  }

  // Update item in items table
  Future<int> updateItem(int id, Map<String, dynamic> item) async {
    final db = await database;
    return await db.update('items', item, where: 'id = ?', whereArgs: [id]);
  }

  // Delete item from items table
  Future<int> deleteItem(int id) async {
    final db = await database;
    return await db.delete('items', where: 'id = ?', whereArgs: [id]);
  }

  // Get item by its id from items table
  Future<Map<String, dynamic>?> getItemById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'items',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return maps.first;
    }

    return null;
  }
}
