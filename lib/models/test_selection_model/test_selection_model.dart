import 'package:jindan/models/question_model/question_model.dart';
import 'package:jindan/models/test_selection_model/test_selection_item.dart';

class TestSelectionModel{
  List<TestSelectionItem> testSelectionItemList = [
    TestSelectionItem(questionBundleList: QuestionModel().healthAgeQuestionBundleList),
    TestSelectionItem(questionBundleList: QuestionModel().depressionQuestionBundleList),
  ];
}