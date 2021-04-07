> This action allows you to isolate changes for a PR to a specific folder. 

For example if you want to only allow migrations to be added in seperate PRs
to ensure compatibility

## Usage

```yaml
# .github/workflows/my-workflow.yaml 
on: [pull_request]

jobs:
  custom_test:
    runs-on: ubuntu-latest
    name: migrations check
    steps:
      - uses: actions/checkout@v2
      - uses: hobochild/isolate-changes-action@main
```
