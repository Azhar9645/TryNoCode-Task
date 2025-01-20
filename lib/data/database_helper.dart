import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:trynocode_assignment/models/main_project.dart';
import 'package:trynocode_assignment/models/other_project.dart';

class DatabaseHelper {
  static const String _databaseName = 'project_database.db';
  static const int _databaseVersion = 1;
  static const String _myProjectTable = 'my_project_table';
  static const String _otherProjectTable = 'other_project_table';

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // Instantiate the database if it's null
    _database = await _initializeDatabase();
    return _database!;
  }

  Future<Database> _initializeDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_myProjectTable (
            projectId TEXT PRIMARY KEY,
            projectname TEXT,
            type TEXT,
            Image TEXT,
            group_name TEXT,
            description TEXT,
            membercount INTEGER,
            event_count INTEGER,
            soccsvalue INTEGER
          )
        ''');
        await db.execute('''
          CREATE TABLE $_otherProjectTable (
            projectId TEXT PRIMARY KEY,
            projectname TEXT,
            type TEXT,
            Image TEXT,
            group_name TEXT,
            groupid TEXT,
            description TEXT,
            membercount INTEGER,
            event_count INTEGER,
            soccsvalue INTEGER
          )
        ''');
      },
    );
  }

  // Insert a project into the "MyProjects" table
  Future<void> insertMyProject(ProjectModel project) async {
    final db = await database;
    await db.insert(
      _myProjectTable,
      project.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Insert a project into the "OtherProjects" table
  Future<void> insertOtherProject(OtherProjectModel project) async {
    final db = await database;
    await db.insert(
      _otherProjectTable,
      project.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Fetch all "MyProjects" from the database
  Future<List<ProjectModel>> getMyProjects() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_myProjectTable);
    return List.generate(maps.length, (i) {
      return ProjectModel.fromJson(maps[i]);
    });
  }

  // Fetch all "OtherProjects" from the database
  Future<List<OtherProjectModel>> getOtherProjects() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_otherProjectTable);
    return List.generate(maps.length, (i) {
      return OtherProjectModel.fromJson(maps[i]);
    });
  }

  // Clear all "MyProjects" data
  Future<void> clearMyProjects() async {
    final db = await database;
    await db.delete(_myProjectTable);
  }

  // Clear all "OtherProjects" data
  Future<void> clearOtherProjects() async {
    final db = await database;
    await db.delete(_otherProjectTable);
  }
}
