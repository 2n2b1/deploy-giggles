# Goal

Use Dockerfile images for pre-defined tools during publishing process.
___

### Linter
Process a directory using linter:   

    docker run kylejeske/actions/use-linter linter [dir]

### Spellcheck
Process a spellchecker for script files:   

    docker run kylejeske/actions/use-spellcheck [dir]

### Unit Tests
Have automated tests run against the code base:   

    docker run kylejeske/actions/use-tester test-name [dir]

... and so on.