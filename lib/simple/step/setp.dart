import 'package:flutter/material.dart';

class StepDemo extends StatefulWidget {
  @override
  _StepDemoState createState() => _StepDemoState();
}

class _StepDemoState extends State<StepDemo> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('setp 小部件'),
      ),
      body: Center(
        child: Stepper(
            currentStep: _currentStep,
            //下一步
            onStepContinue: () {
              setState(() => _currentStep >= 2 ? 0 : _currentStep += 1);
            },
            //取消
            onStepCancel: () {
              setState(() => _currentStep <=0 ? 0 : _currentStep -= 1);
            },
            //step点击事件
            onStepTapped: (value) {
              setState(() => _currentStep = value);
            },
            steps: [
              Step(title: Text('已下单'), content: Text('您已下单')),
              Step(title: Text('已出库'), content: Text('包裹已出库')),
              Step(title: Text('已发货'), content: Text('包裹等待揽收')),
            ]),
      ),
    );
  }
}
