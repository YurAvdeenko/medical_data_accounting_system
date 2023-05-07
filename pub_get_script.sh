#!/usr/bin/env bash

printf "user_medical_data_accounting_system pub get\n"
flutter clean && flutter clean cache && flutter pub get && flutter gen-l10n
printf '\n\n'

printf "core pub get\n"
cd core || exit
flutter clean && flutter clean cache && flutter pub get
cd ..
printf '\n\n'

printf "core_ui pub get\n"
cd core_ui || exit
flutter clean && flutter clean cache && flutter pub get
cd ..
printf '\n\n'

printf "data pub get\n"
cd data || exit
flutter clean && flutter clean cache && flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs
cd ..
printf '\n\n'

printf "di pub get\n"
cd di || exit
flutter clean && flutter clean cache && flutter pub get
cd ..
printf '\n\n'

printf "domain pub get\n"
cd domain || exit
flutter clean && flutter clean cache && flutter pub get
cd ..
printf '\n\n'

printf "auth pub get\n"
cd features/auth || exit
flutter clean && flutter clean cache && flutter pub get
cd ../..
printf '\n\n'

printf "home pub get\n"
cd features/home || exit
flutter clean && flutter clean cache && flutter pub get
cd ../..
printf '\n\n'

