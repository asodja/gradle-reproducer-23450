#!/usr/bin/env sh

#rm -rf "./gradle-user-home/caches/8.9/transforms"
for i in {1..100}
do
  echo "\nIteration $i"
  find ./gradle-user-home/caches -type d -name "transforms" -exec rm -r {} \;
  KOTLIN_USER_HOME="$(pwd)/kotlin-user-home"
  GRADLE_USER_HOME="$(pwd)/gradle-user-home"
  ./gradlew --info -Pkotlin_version=2.0.20-RC -Dorg.gradle.unsafe.configuration-cache=false \
    -Dorg.gradle.unsafe.configuration-cache-problems=fail -Dorg.gradle.unsafe.isolated-projects=false --parallel \
    --max-workers=3 -Pkotlin.incremental=false --watch-fs --no-build-cache -Pkotlin.native.cacheKind=none \
    -Pkotlin.native.distribution.downloadFromMaven=true -Pkotlin_performance_profile_force_validation=true \
    -Pkotlin.test.languageVersion=1.9 -Pkotlin.daemon.useFallbackStrategy=false \
    -Pkotlin.internal.diagnostics.useParsableFormatting=true -Pkotlin.internal.diagnostics.showStacktrace=false --full-stacktrace \
    -Pkonan.data.dir=/home/yahor/work/kotlin-worktree/kt-65838-platformlibrariesgenerator-remove-project/.kotlin/konan-for-gradle-tests \
    -Pkotlin.user.home="$KOTLIN_USER_HOME" \
    --gradle-user-home="$GRADLE_USER_HOME" \
    --no-daemon \
    -Pkotlin.internal.compiler.arguments.log.level=info $@
  done
