import 'dart:io';

import 'package:yaml_edit/yaml_edit.dart';

void main(List<String> args) {
  if (args.isEmpty || args[0] != "init") {
    print("Usage: dart run riverpod_appkit init");
    return;
  }

  initialize();
}

void initialize() {
  final file = File("pubspec.yaml");

  if (!file.existsSync()) {
    print("pubspec.yaml not found");
    return;
  }

  final content = file.readAsStringSync();
  final editor = YamlEditor(content);
  editor.update(["dependencies", "flutter_riverpod"], "^2.6.1");
  editor.update(["dependencies", "riverpod_annotation"], "^2.6.1");
  editor.update(["dependencies", "freezed_annotation"], "^2.4.4");
  editor.update(["dev_dependencies", "riverpod_generator"], "^2.6.3");
  editor.update(["dev_dependencies", "freezed"], "^2.5.7");
  editor.update(["dev_dependencies", "build_runner"], "^2.4.13");
  editor.update(["dev_dependencies", "json_serializable"], "^6.9.0");

  file.writeAsStringSync(editor.toString());

  Process.runSync("flutter", ["pub", "get"], runInShell: true);
}
