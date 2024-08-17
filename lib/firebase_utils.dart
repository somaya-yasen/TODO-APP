import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/task_model.dart';
class FirebaseUtils {
  static CollectionReference <TaskModel> getTasksCollection(){
return    FirebaseFirestore.instance.collection(TaskModel.collectionName).

withConverter <TaskModel>(
        fromFirestore: (snapshot, options) => TaskModel.fromFireStore(snapshot.data()!),
    toFirestore: (task,options) => task.toFirestoreJson());
  }
  static Future <void> addTaskToFireStore(TaskModel task){
    var taskCollection = getTasksCollection();
    var taskDocumentRef = taskCollection.doc();
    task.id= taskDocumentRef.id;
    return taskDocumentRef.set(task);

  }

  static Future <void> DeleteTaskFromFireStore(TaskModel task) async{
    return getTasksCollection().doc(task.id).delete();

  }



}