
import '../models/query.dart';

abstract class Repository{
  
  Future<dynamic> getRepositories(Query query);
}