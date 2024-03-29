EXPORT_FILE=flutter_components

# Export and test the program.
all: analyze export sure clean

# Git add, commit, and push.
git: all
	dart format ./lib/
	git add -A
	git commit -m '$(m)'
	git push

# Analyze dart code such 
# as warnings and error.
analyze:
	flutter analyze

# Create an export file.
export:
	cd lib; cd flutter_package_exporter; make FILE='$(EXPORT_FILE)'

# Run test harsness.
sure: 
	cd test; dart --enable-asserts test.dart;

# Clean the python caches.
clean:
	cd lib/flutter_package_exporter; make clean;

# Install dependencies.
install: 
	cd lib; git clone https://github.com/vicmoh/flutter_package_exporter || cd flutter_package_exporter; git pull;

new:
	git branch $(version); git checkout $(version); git push --set-upstream origin $(version); git checkout master;
