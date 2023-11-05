// 미완성 상태라 임시로 표시할 데이터 넣어둠

import 'package:flutter/material.dart';
import 'package:jindan/controller/health_result_controller.dart';
import 'package:jindan/controller/question_controller.dart';
import 'package:provider/provider.dart';


class BodyAgeResultScreen extends StatefulWidget {
  const BodyAgeResultScreen({Key? key}) : super(key: key);

  @override
  State<BodyAgeResultScreen> createState() => _BodyAgeResultScreenState();
}

class _BodyAgeResultScreenState extends State<BodyAgeResultScreen> {
  var backgroundColor = Colors.grey[200];
  double mainWidth = 300.0;
  double imageContainerHeight = 200.0;
  double sizedBoxHeightHigh = 100.0;
  double sizedBoxHeightLow = 20;

  @override
  Widget build(BuildContext context) {
    var helthResultController = HelthResultController();
    QuestionController questionControllerWatch =
    Provider.of<QuestionController>(context, listen: true);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: sizedBoxHeightHigh,),
            RoundedShadowContainer(width: 300, height: imageContainerHeight, text: 'image about body age'),
            SizedBox(height: sizedBoxHeightLow,),
            BigText(age: helthResultController.getScore(
                questionBundleList:questionControllerWatch.questionBundleList),
                explanation: '설명을 추가하자'),
        ],),
      )
    );
  }
}

class RoundedShadowContainer extends StatelessWidget {
  RoundedShadowContainer({Key? key, required this.width,required this.height, required this.text}) : super(key: key);
  double width;
  double height;
  String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), // 둥글게 만들기 위한 BorderRadius 설정
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // 그림자 색상 설정
            spreadRadius: 5, // 그림자 확산 범위
            blurRadius: 7, // 그림자 흐릿함 정도
            offset: Offset(0, 3), // 그림자 위치 (x, y)
          ),
        ],
        color: Colors.white, // 컨테이너의 배경색 설정
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class BigText extends StatelessWidget {
  BigText({Key? key, required this.age, required this.explanation}) : super(key: key);
  double age;
  String explanation;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: RichText(
            overflow: TextOverflow.ellipsis,
            maxLines: 5,
            text: TextSpan(
              text: age >= 0 ? '+${age}년' : '${age}년' ,
              style: TextStyle(
                fontSize: 80, // 텍스트 크기
                fontWeight: FontWeight.bold, // 텍스트 굵기
                color: Colors.black, // 텍스트 색상
                letterSpacing: 1.2, // 글자 간격 조정
                fontStyle: FontStyle.italic, // 이탤릭 스타일
                fontFamily: 'Arial', // 폰트 설정
              ),
            ),
          ),
        ),
        SizedBox(height: 20,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 60), // 좌우 패딩을 16으로 설정
          child: RichText(
            overflow: TextOverflow.ellipsis,
            maxLines: 5,
            text: TextSpan(
              text: explanation,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: 1.2,
                fontStyle: FontStyle.italic,
                fontFamily: 'Arial',
              ),
            ),
          ),
        )
      ],
    );
  }
}
