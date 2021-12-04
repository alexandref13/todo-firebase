import 'package:mobx/mobx.dart';
import 'repositories/todo_repository_interface.dart';
part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final ITodoRepository repository;

  HomeStoreBase(ITodoRepository this.repository);
}
