# Welcome to TableGPT-Agent contributing guide <!-- omit in toc -->

Thank you for investing your time in contributing to our project! :sparkles:.

In this guide you will get an overview of the contribution workflow from opening an issue, creating a PR, reviewing, and merging the PR.

## New contributor guide

To get an overview of the project, read the [README](./README.md) file. Here are some resources to help you get started with open source contributions:

- [Set up Git](https://docs.github.com/en/get-started/getting-started-with-git/set-up-git)
- [GitHub flow](https://docs.github.com/en/get-started/using-github/github-flow)
- [Collaborating with pull requests](https://docs.github.com/en/github/collaborating-with-pull-requests)

## Get Started

### Create a new issue

If you spot a problem with TableGPT, [search if an issue already exists](https://docs.github.com/en/github/searching-for-information-on-github/searching-on-github/searching-issues-and-pull-requests#search-by-the-title-body-or-comments). If a related issue doesn't exist, you can [open a new issue](https://github.com/tablegpt/tablegpt-agent/issues/new).

### Solve an issue

Once you are assigned an issue, you can start working on it. You can scan through our [existing issues](https://github.com/tablegpt/tablegpt-agent/issues) to find one that is assigned to you. You can narrow down the search using `labels` as filters.

1. Fork the repository.

2. Setup development environment.

3. Create a working branch and start with your changes!

### Commit your update

Commit the changes once you are happy with them. To speed up the review process, make sure your commit messages are clear and concise. We follow the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) standard for commit messages.

### Pull Request

When you're finished with the changes, create a pull request, also known as a PR.

- Don't forget to link PR to issue if you are solving one.
- Once you submit your PR, a Docs team member will review your proposal. We may ask questions or request additional information.
- We may ask for changes to be made before a PR can be merged, either using suggested changes or pull request comments. You can make any other changes in your fork, then commit them to your branch.
- As you update your PR and apply changes, mark each conversation as `resolved`.
- If you run into any merge issues, checkout this [git tutorial](https://github.com/skills/resolve-merge-conflicts) to help you resolve merge conflicts and other issues.

### Code Quality

Before your PR gets merged, we will check the code quality. We use [GitHub Actions](https://docs.github.com/en/actions/) to automate the process. You can inspect the detailed workflow at [ci workflow](./.github/workflows/ci.yml).

If you want to check the code quality locally, you can use the following command:

```sh
make lint && make test
```

In addition to the automated checks, we also have a code review process. The reviewers will provide feedback on your PR and ask for changes if necessary. The feedback is mainly based on google's [python style guide](https://google.github.io/styleguide/pyguide.html).
