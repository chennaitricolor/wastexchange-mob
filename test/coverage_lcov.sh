#!/bin/bash

FILE_LOADER_TEST_FILE="test/file_loader_test.dart"
FOLDERS=( "lib/blocs" "lib/models" "lib/resources" "lib/util" )
ALL_SOURCE_FILES=()
PACKAGE_NAME="package:wastexchange_mobile"

get_files_in_dir_recursively() {
_files=()
    for entry in "$1"/* 
    do 
    if [ -d "$entry" ]
		then 
			echo "Iterating dir $entry"			
			get_files_in_dir_recursively $entry
		else 
			ALL_SOURCE_FILES+=( "$entry" )	
	fi
    done
}

check_and_install_lcov() {
  	echo "Checking lcov installation"
	if brew ls --versions lcov > /dev/null; then
		echo "lcov installed"
	else
		echo "Installing lcov"
  		brew install lcov
	fi
}

iterate_given_folders_and_collect_source_files() {
	_files=()
	for dir in "${FOLDERS[@]}" 
	do
		 echo "Iterating dir $dir"			
		 get_files_in_dir_recursively $dir
	done
	echo "Found ${#ALL_SOURCE_FILES[@]} source files"
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

check_and_install_lcov

iterate_given_folders_and_collect_source_files

#remove existing file
remove_file_loader_test_dart_file

#generate file
generate_file_loader_test_dart_file

#run flutter tests
run_flutter_tests

#generate and open coverage report
generate_html_from_coverage

#delete file now that the job is done
remove_file_loader_test_dart_file

