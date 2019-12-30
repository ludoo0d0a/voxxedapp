#!/usr/bin/env bash
echo "Generate models for serialization..."
flutter pub run build_runner build
#flutter pub run build_runner build --delete-conflicting-outputs