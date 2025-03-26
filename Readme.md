# Modular Example

A modular iOS app starting point.

![diagram](git-images/diagram.png)

A deeper explanation can be found in the [blog post](https://manu.show/2025-02-27-simple-modularization-setup/).

## How to start using this?

As packages are really easy to move around, importing this structure into your app is as easy as:

1. Clone the repository
2. Copy the Pakcages folder into your project
3. Add the `Presentation` local dependency in your Xcode Project or SPM Package.

In your repository, you could also add [Contributing Guidelines](/2023-01-02-new-app-contributing-guidelines/) and [The Definition of Done](/2023-05-13-the-definition-of-done/).

There is also a [contributing guidelines](.github/CONTRIBUTING.md) document in this repository that can be used as a starting point.

## Testing

This project uses Fastlane to automate testing across all packages. To run tests for all packages on iOS simulators:

```bash
bundle exec fastlane test_all_packages [verbose:minimal|simple|full]
```

![tests](git-images/tests.png)

To run tests for a specific package:

```bash
bundle exec fastlane test_scheme scheme:PackageName [verbose:minimal|simple|full]
```

For example, to test the Logger package:

```bash
bundle exec fastlane test_scheme scheme:Logger [verbose:minimal|simple|full]
```

To run tests only for packages with changes compared to a base branch:

```bash
bundle exec fastlane test_changed_packages [base_branch:main] [verbose:minimal|simple|full]
```

This is particularly useful during development or in CI/CD pipelines to validate only the code that has changed.

Test results are stored in the `test_output` directory at the project root level.

### Verbosity Levels

- `minimal` (default): Only shows when tests start for each package and the final results. Shows a comprehensive test summary at the end.
- `simple`: Shows simplified test output with xcpretty
- `full`: Shows full test output with detailed xcpretty formatting

The test output includes:
- Number of tests passed/failed for each package
- A summary of all packages tested, skipped, and their results
- Overall statistics including total tests run, passed, and failed

Tests will exit with a non-zero status code if any tests fail, making it suitable for CI/CD pipelines.

See the [Fastlane README](fastlane/README.md) for more details.
