# Riverpod AppKit

A collection of utilities and helpers for Flutter applications using Riverpod.

## Features

### Initialization### 초기화### Initialization### 초기화
```pubspec.yaml```
```yaml
dependencies:
  ...
  riverpod_appkit:
    git:
      url: git@github.com:BreadKey/riverpod_appkit.git
      ref: main
```

The package provides a command-line tool to initialize your project with Riverpod AppKit.

```bash
dart run riverpod_appkit init
```

### Pagination Support

The package provides a robust pagination system through the `PagedContent` class, `PagedContentControllerMixin`, and `PagedContentList` widget.

See the [example](example) for more details.
