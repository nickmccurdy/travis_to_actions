Feature: CLI
  Scenario: No config
    When I run `travis_to_actions` interactively
    And I close the stdin stream
    Then the output should contain exactly ""

  Scenario: Ruby config
    When I run `travis_to_actions` interactively
    Given a file named ".travis.yml" with "language: ruby"
    And I pipe in the file ".travis.yml"
    Then the output should contain exactly:
      """
      name: Ruby

      on:
        push:
          branches: [ master ]
        pull_request:
          branches: [ master ]

      jobs:
        test:

          runs-on: ubuntu-latest

          steps:
          - uses: actions/checkout@v2
          - name: Install dependencies
            run: bundle install
          - name: Run tests
            run: bundle exec rake
      """

  Scenario: Node.js config
    When I run `travis_to_actions` interactively
    Given a file named ".travis.yml" with "language: nodejs"
    And I pipe in the file ".travis.yml"
    Then the output should contain exactly:
      """
      name: Node.js

      on:
        push:
          branches: [ master ]
        pull_request:
          branches: [ master ]

      jobs:
        test:

          runs-on: ubuntu-latest

          steps:
          - uses: actions/checkout@v2
          - name: Install dependencies
            run: npm ci
          - name: Run tests
            run: npm test
      """
