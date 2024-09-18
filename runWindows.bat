@echo off
echo Compiling...
echo Removing old files...
mkdir class
del /Q .\class\*.class
del mylex.java

echo Compiling JFlex...
jflex mylex.flex

echo Compiling Java files...
javac -d .\class .\*.java

echo Compilation done.
echo Running...
echo ----------------------------------

java -cp .\class Main
