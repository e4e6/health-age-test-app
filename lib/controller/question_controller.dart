import 'package:flutter/material.dart';
import 'package:jindan/controller/result_controller.dart';
import 'package:jindan/models/question_model/question_bundle_item.dart';
import 'package:jindan/models/question_model/question_item.dart';
import 'package:jindan/models/question_model/question_model.dart';
import 'package:jindan/screens/question_screens/question_screen.dart';
import 'package:jindan/screens/result_screen/result_screen.dart';
import 'package:provider/provider.dart';

class QuestionController with ChangeNotifier{
  int questionBundleListIndex = 0;

  List<QuestionBundleItem> questionBundleList = QuestionModel().healthAgeQuestionBundleList;
  void ChangeQuestionBundleListandIndexToInitialState(){
    questionBundleList = QuestionModel().healthAgeQuestionBundleList;
    questionBundleListIndex = 0;
    notifyListeners();
  }

  void changeAllQuestionCheckboxValueToFalse({required int questionBundleListIndex, required int questionIndex}) {
    final questionBundle = questionBundleList[questionBundleListIndex];
    final question = questionBundle.questionList[questionIndex];

    final newQuestion = question.copyWith(isChecked: !question.isChecked);

    final updatedQuestionList = List<QuestionItem>.from(questionBundle.questionList).map((item) {
      return item.copyWith(isChecked: false);
    }).toList();

    final newQuestionBundle = questionBundle.copyWith(questionList: updatedQuestionList);
    questionBundleList[questionBundleListIndex] = newQuestionBundle;

    notifyListeners();
  }

  void changeQuestionCheckboxValue({required int questionBundleListIndex, required int questionIndex}) {
    final questionBundle = questionBundleList[questionBundleListIndex];
    final question = questionBundle.questionList[questionIndex];

    final newQuestion = question.copyWith(isChecked: !question.isChecked);

    final newQuestionBundle = questionBundle.copyWith(
      questionList: List<QuestionItem>.from(questionBundle.questionList)
        ..[questionIndex] = newQuestion,
    );
    questionBundleList[questionBundleListIndex] = newQuestionBundle;
    notifyListeners();
  }
  void CheckboxHandler(int questionBundleListIndex, int questionIndex) {
    if (questionBundleList[questionBundleListIndex].isMultipleSelectionsAllowed == false) {
      changeAllQuestionCheckboxValueToFalse(questionBundleListIndex: questionBundleListIndex, questionIndex: questionIndex);
    }
    changeQuestionCheckboxValue(questionBundleListIndex: questionBundleListIndex, questionIndex: questionIndex);
  }

  void changeToNextQuestionBundle() {
    questionBundleListIndex < questionBundleList.length-1
        ? questionBundleListIndex ++
        : questionBundleListIndex = questionBundleList.length-1;
    notifyListeners();
  }
  void changeToPreviousQuestionBundle() {
    questionBundleListIndex >0
        ? questionBundleListIndex --
        : questionBundleListIndex = 0;
    notifyListeners();
  }

  void openQuestionScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => QuestionScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    ));
  }

  void openResultScreen(BuildContext context) {
    final questionControllerRead = context.read<QuestionController>();
    final resultControllerRead = context.read<ResultController>();
    resultControllerRead.setScore(questionBundleList: questionControllerRead.questionBundleList);
    resultControllerRead.setIndex(score: resultControllerRead.score);

    Navigator.of(context).pushReplacement(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => ResultScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    ));
  }
}