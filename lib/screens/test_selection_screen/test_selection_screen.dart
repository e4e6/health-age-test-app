import 'package:flutter/material.dart';
import 'package:jindan/controller/test_selection_controller.dart';
import 'package:jindan/screens/question_screens/question_screen.dart';
import 'package:jindan/screens/test_selection_screen/widgets/single_test_widget.dart';
import 'package:provider/provider.dart';

class TestSelectionScreen extends StatefulWidget {
  const TestSelectionScreen({Key? key}) : super(key: key);

  @override
  State<TestSelectionScreen> createState() => _TestSelectionScreenState();
}

class _TestSelectionScreenState extends State<TestSelectionScreen> {
  @override
  Widget build(BuildContext _) {
    final testSelectionControllerWatch = _.watch<TestSelectionController>();
    final testSelectionControllerRead = _.read<TestSelectionController>();

    double mainWidth = 300.0;
    double imageContainerHeight = 400.0;
    double sizedBoxHeight = 100.0;

    return Scaffold(
        appBar: AppBar(title: Text(
          '건강나이 테스트',
          style: TextStyle(
            fontWeight: FontWeight.bold, // 볼드 처리
          ),
        ),
          centerTitle: true, // 중앙 정렬
          elevation: 0.0,
          toolbarHeight: 50.0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(4.0), // 선의 높이 조절
            child: Divider(
              color: Colors.grey, // 선의 색상 조절
              height: 1.0, // 선의 두께 조절
            ),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              StartImageContainer(width: mainWidth, height: imageContainerHeight, text: 'Image: HowOldAreYou?',),
              SizedBox(height: 30,),
              StartButton(text: '시작',height: 80,width: mainWidth,)
            ],
          ),
        )

    );

    return SingleTestWidget();
    //   Scaffold(
    //   body: ListView.builder(
    //     shrinkWrap: true,
    //     itemCount: testSelectionControllerRead.testSelectionItemList.length,
    //     itemBuilder: (BuildContext _, int questionIndex) {
    //       return
    //     },
    //   ),
    // );
  }
}



class StartImageContainer extends StatelessWidget {
  StartImageContainer({Key? key, required this.width,required this.height, required this.text}) : super(key: key);
  double width;
  double height;
  String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/image/start_screen_image.png',
              width: 280,
            ),
          ],
        ),
      ),
    );
  }
}

class StartButton extends StatelessWidget {
  StartButton({Key? key, required this.width,required this.height, required this.text}) : super(key: key);
  double width;
  double height;
  String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => QuestionScreen(),)
        );
      },
      style: ElevatedButton.styleFrom(
        fixedSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // 둥글게 만들기 위한 BorderRadius 설정
        ),
        elevation: 5, // 그림자 높이
        shadowColor: Colors.grey.withOpacity(0.5), // 그림자 색상 설정
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          text,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}