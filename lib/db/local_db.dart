import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDB {
  static final LocalDB instance = LocalDB._init();
  static Database? _database;
  LocalDB._init();
  String tableRepos = 'repos';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('repos.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    // if(await isTableExists()) {
    //   return await openDatabase(path, version: 1);
    // }
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
      CREATE TABLE $tableRepos (
        ${RepoFields.id} $idType,
        ${RepoFields.name} $textType,
        ${RepoFields.ownerName} $textType,
        ${RepoFields.ownerImg} $textType,
        ${RepoFields.private} $integerType,
        ${RepoFields.description} $textType,
        ${RepoFields.stars} $integerType,
        ${RepoFields.watchers} $integerType,
        ${RepoFields.forksCount} $integerType,
        ${RepoFields.openIssues} $integerType,
        ${RepoFields.language} $textType,
        ${RepoFields.createdAt} $textType,
        ${RepoFields.updatedAt} $textType,
        ${RepoFields.pushedAt} $textType 
      )
    ''');
  }

  Future<bool> isTableExists() async {
    final db = await instance.database;
    final result = await db.rawQuery(
        'SELECT name FROM sqlite_master WHERE type="table" AND name="$tableRepos"');
    return result.isNotEmpty;
  }

  static Future<List<Map<String, dynamic>>> getTableColumns(
      String tableName) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> result =
        await db.rawQuery('PRAGMA table_info($tableName)');
    return result;
  }

  Future<void> insert(Map<String, dynamic> repo) async {
    final db = await instance.database;

    await db.insert(tableRepos, repo);
  }

  Future<List<Map<String, dynamic>>> getAllRepos(
      String sort, String order) async {
    String sortingVal;
    switch (sort) {
      case 'stars':
        sortingVal = RepoFields.stars;
        break;
      case 'forks':
        sortingVal = RepoFields.forksCount;
        break;
      case 'updated':
        sortingVal = RepoFields.updatedAt;
        break;
      default:
        sortingVal = RepoFields.stars;
    }

    String orderVal;
    switch (order) {
      case 'asc':
        orderVal = 'ASC';
        break;
      case 'desc':
        orderVal = 'DESC';
        break;
      default:
        orderVal = 'DESC';
    }
    final db = await instance.database;
    final orderBy = '$sortingVal $orderVal';
    return await db.query(tableRepos, orderBy: orderBy);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<void> deleteAllRecords() async {
    final db = await instance.database;
    await db.delete(tableRepos);
  }
}

class RepoFields {
  static const String id = 'id';
  static const String name = 'name';
  static const String ownerName = 'owner_name';
  static const String ownerImg = 'owner_img';
  static const String private = 'private';
  static const String description = 'description';
  static const String stars = 'stargazers_count';
  static const String watchers = 'watchers_count';
  static const String forksCount = 'forks_count';
  static const String openIssues = 'open_issues_count';
  static const String language = 'language';
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';
  static const String pushedAt = 'pushed_at';

  static List<String> values = [
    id,
    name,
    ownerName,
    ownerImg,
    private,
    description,
    stars,
    watchers,
    forksCount,
    openIssues,
    language,
    createdAt,
    updatedAt,
    pushedAt
  ];
}
