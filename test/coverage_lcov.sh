#!/bin/bash

FILE_LOADER_TEST_FILE="test/file_loader_test.dart"
LIB_DIR=( "lib" )
EXCLUDE_PATHS=( "lib/widgets" "lib/screens" "lib/main.dart" )
ALL_SOURCE_FILES=()
PACKAGE_NAME="package:wastexchange_mobile"

get_source_files_in_dir_recursively() {
    for entry in "$1"/* 
    do 
	result=$(is_excluded_folder $entry) 
	if [ $result -eq 1 ]
	then
		echo "Skipping exclude_path: $entry"
		continue
	fi

    if [ -d $entry ]
    then
		echo "Iterating dir $entry"			
		get_source_files_in_dir_recursively $entry
	else 
		ALL_SOURCE_FILES+=( "$entry" )		
	fi
    done
}

check_and_install_lcov() {
  	echo "Checking lcov installation"
	if brew ls --versions lcov > /dev/null
	then
		echo "lcov already installed"
	else
		echo "Installing lcov"
  		brew install lcov
	fi
}

generate_file_loader_test_dart_file() {

	echo "// ignore_for_file: unused_import" >> $FILE_LOADER_TEST_FILE
	for file in "${ALL_SOURCE_FILES[@]}"
	do
		echo "import '$PACKAGE_NAME/$file';" | sed 's/\/lib//g'>> $FILE_LOADER_TEST_FILE
	done
	echo "" >> $FILE_LOADER_TEST_FILE
	echo "void main() {}" >> $FILE_LOADER_TEST_FILE
	echo "$FILE_LOADER_TEST_FILE generated"
}

run_flutter_tests() {
	echo "Running flutter test"
	flutter test --coverage
}

generate_html_from_coverage() {
	genhtml "coverage/lcov.info" -o "coverage/html"
	open "coverage/html/index.html"
}

remove_file_loader_test_dart_file() {
	if [ -f $FILE_LOADER_TEST_FILE ]
	then 
		echo "$FILE_LOADER_TEST_FILE removed"
    	rm $FILE_LOADER_TEST_FILE
	fi 
}

is_excluded_folder() {
	_excluded=0
	for i in "${EXCLUDE_PATHS[@]}"
	do
		if [[ $1 == *"$i"* ]]
		then
		_excluded=1
		break
		fi
	done
	echo "$_excluded"
}

print_source_files_count() {
	echo "Found ${#ALL_SOURCE_FILES[@]} source files"
}

check_and_install_lcov

get_source_files_in_dir_recursively $LIB_DIR

print_source_files_count

#remove existing temp file_loader_test file
remove_file_loader_test_dart_file

#generate temp file_loader_test file
generate_file_loader_test_dart_file

run_flutter_tests

#generate and open coverage report in browser
generate_html_from_coverage

#delete temp file_loader_test file
remove_file_loader_test_dart_file

