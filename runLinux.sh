#!/bin/bash

echo "Compiling..."
echo "Removing old files..."
rm -rf ./class/*.class
rm mylex.java

echo "Compiling jflex..."
jflex mylex.flex

echo "Compiling java files..."
javac -d ./class ./*.java
echo "Compilation done."
echo "Running..."
echo "----------------------------------"

java -cp ./class Main