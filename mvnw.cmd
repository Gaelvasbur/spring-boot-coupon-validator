@REM Apache Maven Wrapper 3.3.2
@echo off
@setlocal

set ERROR_CODE=0

if "%JAVA_HOME%" == "" (
  echo Error: JAVA_HOME no esta definido. Instala JDK 17 y configura JAVA_HOME.
  exit /B 1
)

if not exist "%JAVA_HOME%\bin\java.exe" (
  echo Error: JAVA_HOME invalido: %JAVA_HOME%
  exit /B 1
)

set MAVEN_PROJECTBASEDIR=%~dp0
set WRAPPER_JAR="%MAVEN_PROJECTBASEDIR%.mvn\wrapper\maven-wrapper.jar"
set WRAPPER_LAUNCHER=org.apache.maven.wrapper.MavenWrapperMain
set WRAPPER_URL="https://repo.maven.apache.org/maven2/org/apache/maven/wrapper/maven-wrapper/3.3.2/maven-wrapper-3.3.2.jar"

if not exist %WRAPPER_JAR% (
  powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (New-Object System.Net.WebClient).DownloadFile('%WRAPPER_URL%', '%WRAPPER_JAR%')"
)

"%JAVA_HOME%\bin\java.exe" -classpath %WRAPPER_JAR% "-Dmaven.multiModuleProjectDirectory=%MAVEN_PROJECTBASEDIR%" %WRAPPER_LAUNCHER% %*
if ERRORLEVEL 1 set ERROR_CODE=1
exit /B %ERROR_CODE%
