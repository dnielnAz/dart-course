// To solve multiple hierarchy problem there are mixins witch are meant to be merged
// with other classes to share functionality (behavior)

import 'package:my_first_package/classes.dart';

abstract class IFlowTest {
  void setUp();

  void tearDown();
}

mixin ContextAwareTest {
  void setUp() {
    print('Preparing context');
  }
}

mixin UiTest {
  void setUp() {
    print('Preparing network');
  }

  void disposeUi();
}

// FatApiTest is not mix in with ContextAwareTest or UiTest
// IFlowTest is mix in with ContextAwareTest (that's why method is override there)
// IFlowTest is mix in with ContextAwareTest and UiTest
class CustomTest extends IFlowTest with ContextAwareTest, UiTest {
  // No need to override setUp since is done in mixins

  @override
  void tearDown() {
    print('Destroying test');
  }

  @override
  void disposeUi() {
    print('Closing api');
  }
}

void run() {
  final test = CustomTest();

  // As UiTest is at the end the setUp used will be of UiTest
  test.setUp();
  test.disposeUi();
  test.tearDown();
}

// Mixins targeted

// This can only be mix in with IFlowTest class
mixin FlowableApiTest on IFlowTest {
  @override
  void setUp() {
    print('Preparing network');
  }

  @override
  void tearDown() {
    print('Releasing network');
  }
}

// Mixins targeted advanced

// This mixin can access target methods
mixin WhatsApp on CommunicationDevice {
  void doSomething() {
    // If more than one implementations of call() this will use the call()
    // at the top of hierarchy of mixins (see CustomTest)
    call();

    // Use super to step one level up the hierarchy
    super.call();
  }
}
