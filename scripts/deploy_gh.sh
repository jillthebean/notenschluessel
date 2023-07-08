flutter build web --release --base-href=/notenschluessel/ -t lib/main_production.dart
git co gh-pages
rm -rf assets icons canvaskit favicon.png flutter_service_worker.js flutter.js index.html main.dart.js manifest.json version.json
cp -r build/web/ .
TEST=$(cat .last_build_id)
git commit -am "$TEST"
git co -
git stash -u
git stash drop