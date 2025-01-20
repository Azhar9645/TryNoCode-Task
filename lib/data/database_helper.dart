import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:trynocode_assignment/models/other_project.dart';
import 'package:trynocode_assignment/models/project.dart';
import 'package:trynocode_assignment/service/database_service.dart'; // Make sure to import the DatabaseService

class DatabaseHelper implements DatabaseService {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  @override
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'projects_database.db');
    return await openDatabase(
      path,
      version: 2,  // Incremented version to 2 for migration
      onCreate: onCreate,
      onUpgrade: onUpgrade,  // Handle upgrade here
    );
  }

  Future<void> onCreate(Database db, int version) async {
    await db.execute(''' 
      CREATE TABLE my_projects (
        projectId TEXT PRIMARY KEY,
        projectname TEXT,
        type TEXT,
        image TEXT,
        group_name TEXT,  -- Added this column
        membercount INTEGER,
        event_count INTEGER,
        soccsvalue INTEGER
      )
    ''');

    await db.execute(''' 
      CREATE TABLE other_projects (
        projectId TEXT PRIMARY KEY,
        projectname TEXT,
        type TEXT,
        image TEXT,
        group_name TEXT,  -- Added this column
        groupid TEXT,     -- This column already exists in your table
        description TEXT,
        membercount INTEGER,
        event_count INTEGER,
        soccsvalue INTEGER,
        page INTEGER
      )
    ''');
  }

  // Handle upgrades (migrations) between versions
  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // For both tables, add the new `group_name` column if it does not exist
      await db.execute('''
        ALTER TABLE my_projects ADD COLUMN group_name TEXT;
      ''');

      await db.execute('''
        ALTER TABLE other_projects ADD COLUMN group_name TEXT;
      ''');
    }
  }

  @override
  Future<void> insertMyProjects(List<ProjectModel> projects) async {
    final db = await database;
    for (var project in projects) {
      await db.insert(
        'my_projects',
        project.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  @override
  Future<void> insertOtherProjects(List<OtherProjectModel> projects) async {
    final db = await database;
    for (var project in projects) {
      await db.insert(
        'other_projects',
        project.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  @override
  Future<List<ProjectModel>> fetchMyProjects() async {
    final db = await database;
    final result = await db.query('my_projects');
    return result.map((e) => ProjectModel.fromJson(e)).toList();
  }

  @override
  Future<List<OtherProjectModel>> fetchOtherProjects() async {
    final db = await database;
    final result = await db.query('other_projects');
    return result.map((e) => OtherProjectModel.fromJson(e)).toList();
  }
}
