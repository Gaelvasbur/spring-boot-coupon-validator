#!/bin/sh
# ----------------------------------------------------------------------------
# Apache Maven Wrapper startup script, version 3.3.2
# ----------------------------------------------------------------------------

set -e

if [ -z "$MAVEN_SKIP_RC" ]; then
  if [ -f /usr/local/etc/mavenrc ]; then . /usr/local/etc/mavenrc; fi
  if [ -f /etc/mavenrc ]; then . /etc/mavenrc; fi
  if [ -f "$HOME/.mavenrc" ]; then . "$HOME/.mavenrc"; fi
fi

trim() {
  printf "%s" "${1}" | tr -d '[:space:]'
}

native_path() {
  printf "%s" "$1"
}

case "$(uname)" in
CYGWIN*|MINGW*)
  [ -z "$JAVA_HOME" ] || JAVA_HOME="$(cygpath --unix "$JAVA_HOME")"
  native_path() { cygpath --path --windows "$1"; }
  ;;
esac

set_java_home() {
  if [ -n "$JAVA_HOME" ]; then
    if [ -x "$JAVA_HOME/jre/sh/java" ]; then
      JAVACMD="$JAVA_HOME/jre/sh/java"
    else
      JAVACMD="$JAVA_HOME/bin/java"
    fi
    if [ ! -x "$JAVACMD" ]; then
      echo "Error: JAVA_HOME is set to an invalid directory: $JAVA_HOME" >&2
      echo "Please set JAVA_HOME to a JDK 17 installation." >&2
      return 1
    fi
  else
    JAVACMD="$(command -v java || true)"
    if [ -z "$JAVACMD" ] || [ ! -x "$JAVACMD" ]; then
      echo "Error: JAVA_HOME is not defined and java was not found in PATH." >&2
      echo "Please install JDK 17 and set JAVA_HOME." >&2
      return 1
    fi
  fi
}

find_maven_basedir() {
  basedir="$1"
  wdir="$1"
  while [ "$wdir" != "/" ]; do
    if [ -d "$wdir/.mvn" ]; then
      basedir="$wdir"
      break
    fi
    wdir="$(cd "$wdir/.." || exit 1; pwd)"
  done
  printf "%s" "$(cd "$basedir" || exit 1; pwd)"
}

download_file() {
  url="$1"
  target="$2"

  if command -v curl >/dev/null 2>&1; then
    curl -fsSL --retry 3 -o "$target" "$url"
  elif command -v wget >/dev/null 2>&1; then
    wget -q -O "$target" "$url"
  else
    echo "Error: curl or wget is required to download the Maven Wrapper." >&2
    return 1
  fi
}

set_java_home || exit 1

script_dir="$(cd "$(dirname "$0")" && pwd)"
MAVEN_PROJECTBASEDIR="${MAVEN_BASEDIR:-$(find_maven_basedir "$script_dir")}"
MAVEN_WRAPPER_JAR="$MAVEN_PROJECTBASEDIR/.mvn/wrapper/maven-wrapper.jar"
WRAPPER_LAUNCHER=org.apache.maven.wrapper.MavenWrapperMain

wrapperUrl="https://repo.maven.apache.org/maven2/org/apache/maven/wrapper/maven-wrapper/3.3.2/maven-wrapper-3.3.2.jar"
wrapperJarPath="$MAVEN_WRAPPER_JAR"

if [ -f "$MAVEN_PROJECTBASEDIR/.mvn/wrapper/maven-wrapper.properties" ]; then
  while IFS="=" read -r key value; do
    case "$key" in
      wrapperUrl) wrapperUrl=$(trim "$value") ;;
    esac
  done < "$MAVEN_PROJECTBASEDIR/.mvn/wrapper/maven-wrapper.properties"
fi

if [ ! -f "$wrapperJarPath" ]; then
  echo "Downloading Maven Wrapper..."
  mkdir -p "$(dirname "$wrapperJarPath")"
  if ! download_file "$wrapperUrl" "$wrapperJarPath"; then
    echo "Error: could not download Maven Wrapper from $wrapperUrl" >&2
    exit 1
  fi
fi

MAVEN_CMD_LINE_ARGS="$MAVEN_CONFIG $*"

exec "$JAVACMD" \
  $MAVEN_OPTS \
  $MAVEN_DEBUG_OPTS \
  -classpath "$(native_path "$wrapperJarPath")" \
  "-Dmaven.multiModuleProjectDirectory=$(native_path "$MAVEN_PROJECTBASEDIR")" \
  $WRAPPER_LAUNCHER \
  $MAVEN_CMD_LINE_ARGS
