Feature: Developer generates a method
  As a Developer
  I want to automate creating methods
  In order to avoid repetitive tasks and interruptions in development flow

  Scenario: Generating a method
    Given the spec file "spec/CodeGeneration/MethodExample1/MarkdownSpec.php" contains:
      """
      <?php

      namespace spec\CodeGeneration\MethodExample1;

      use PhpSpec\ObjectBehavior;
      use Prophecy\Argument;

      class MarkdownSpec extends ObjectBehavior
      {
          function it_converts_plain_text_to_html_paragraphs()
          {
              $this->toHtml('Hi, there')->shouldReturn('<p>Hi, there</p>');
          }
      }

      """
    And the class file "src/CodeGeneration/MethodExample1/Markdown.php" contains:
      """
      <?php

      namespace CodeGeneration\MethodExample1;

      class Markdown
      {
      }

      """
    When I run phpspec and answer "y" when asked if I want to generate the code
    Then the class in "src/CodeGeneration/MethodExample1/Markdown.php" should contain:
      """
      <?php

      namespace CodeGeneration\MethodExample1;

      class Markdown
      {

          public function toHtml($argument1)
          {
              // TODO: write logic here
          }
      }

      """
  Scenario: Generating a method in a class with psr4 prefix
    Given the spec file "spec/Behat/Tests/MyNamespace/PrefixSpec.php" contains:
    """
    <?php

    namespace spec\Behat\Tests\MyNamespace;

    use PhpSpec\ObjectBehavior;
    use Prophecy\Argument;

    class PrefixSpec extends ObjectBehavior
    {
        function it_converts_plain_text_to_html_paragraphs()
        {
            $this->toHtml('Hi, there')->shouldReturn('<p>Hi, there</p>');
        }
    }

    """
    And the config file contains:
    """
    suites:
      behat_suite:
        namespace: Behat\Tests\MyNamespace
        psr4_prefix: Behat\Tests
    """

    And the class file "src/MyNamespace/Prefix.php" contains:
    """
    <?php

    namespace Behat\Tests\MyNamespace;

    class Prefix
    {
    }

    """
    When I run phpspec and answer "y" when asked if I want to generate the code
    Then the class in "src/MyNamespace/Prefix.php" should contain:
    """
    <?php

    namespace Behat\Tests\MyNamespace;

    class Prefix
    {

        public function toHtml($argument1)
        {
            // TODO: write logic here
        }
    }

    """

  Scenario: Generating a named constructor in an empty class
    Given the spec file "spec/CodeGeneration/NamedConstructor/UserSpec.php" contains:
    """
    <?php

    namespace spec\CodeGeneration\NamedConstructor;

    use PhpSpec\ObjectBehavior;
    use Prophecy\Argument;

    class UserSpec extends ObjectBehavior
    {
        function it_registers_a_user()
        {
            $this->beConstructedThrough('register', array('firstname', 'lastname'));
            $this->getFirstname()->shouldBe('firstname');
        }
    }

    """
    And the class file "src/CodeGeneration/NamedConstructor/User.php" contains:
    """
    <?php

    namespace CodeGeneration\NamedConstructor;

    class User
    {
    }

    """
    When I run phpspec and answer "y" when asked if I want to generate the code
    Then the class in "src/CodeGeneration/NamedConstructor/User.php" should contain:
    """
    <?php

    namespace CodeGeneration\NamedConstructor;

    class User
    {

        public static function register($argument1, $argument2)
        {
            $user = new User();

            // TODO: write logic here

            return $user;
        }
    }

    """

  Scenario: Generating a named constructor with an existing constructor
    Given the spec file "spec/CodeGeneration/ExistingConstructor/UserSpec.php" contains:
    """
    <?php

    namespace spec\CodeGeneration\ExistingConstructor;

    use PhpSpec\ObjectBehavior;
    use Prophecy\Argument;

    class UserSpec extends ObjectBehavior
    {
        function it_registers_a_user()
        {
            $this->beConstructedThrough('register', array('firstname', 'lastname'));
            $this->getFirstname()->shouldBe('firstname');
        }
    }

    """
    And the class file "src/CodeGeneration/ExistingConstructor/User.php" contains:
    """
    <?php

    namespace CodeGeneration\ExistingConstructor;

    class User
    {
        public function __construct()
        {
        }
    }

    """
    When I run phpspec and answer "y" when asked if I want to generate the code
    Then the class in "src/CodeGeneration/ExistingConstructor/User.php" should contain:
    """
    <?php

    namespace CodeGeneration\ExistingConstructor;

    class User
    {
        public function __construct()
        {
        }

        public static function register($argument1, $argument2)
        {
            $user = new User();

            // TODO: write logic here

            return $user;
        }
    }

    """

  Scenario: Generating a named constructor with an existing constructor with arguments
    Given the spec file "spec/CodeGeneration/ExistingConstructorArgs/UserSpec.php" contains:
    """
    <?php

    namespace spec\CodeGeneration\ExistingConstructorArgs;

    use PhpSpec\ObjectBehavior;
    use Prophecy\Argument;

    class UserSpec extends ObjectBehavior
    {
        function it_registers_a_user()
        {
            $this->beConstructedThrough('register', array('firstname', 'lastname'));
            $this->getFirstname()->shouldBe('firstname');
        }
    }

    """
    And the class file "src/CodeGeneration/ExistingConstructorArgs/User.php" contains:
    """
    <?php

    namespace CodeGeneration\ExistingConstructorArgs;

    class User
    {
        public function __construct($constructorArg1, $constructorArg2)
        {
        }
    }

    """
    When I run phpspec and answer "y" when asked if I want to generate the code
    Then the class in "src/CodeGeneration/ExistingConstructorArgs/User.php" should contain:
    """
    <?php

    namespace CodeGeneration\ExistingConstructorArgs;

    class User
    {
        public function __construct($constructorArg1, $constructorArg2)
        {
        }

        public static function register($argument1, $argument2)
        {
            $user = new User($constructorArg1, $constructorArg2);

            // TODO: write logic here

            return $user;
        }
    }

    """
