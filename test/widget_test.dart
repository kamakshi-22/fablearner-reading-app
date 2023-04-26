import 'package:flutter_test/flutter_test.dart';

class Calculator {
  int addOne(int value) => value + 1;
  int addTwo(int value) => value + 2;
}

void main() {
  late Calculator calculator;
  setUp(() {
    calculator = Calculator();
  });

  group("testing calc", () {
    test('testing calc 1', () {
      int result = calculator.addOne(1);
      expect(result, 2);
      expect(result, isNot(3));
    });
    test('testing calc 2', () {
      final calculator = Calculator();
      int result = calculator.addTwo(1);
      expect(result, 3);
      expect(result, isNot(4));
    });
  });
}
