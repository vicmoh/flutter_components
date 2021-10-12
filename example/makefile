FLUTTER=fvm flutter

all: run-ios

fvm-init: 
	fvm use 2.5.2

run-ios: fvm-init 
	rm -rf ./ios/Pods || echo '\nWARNING: Failed to remove Pods.\n';
	rm ./ios/Podfile.lock || echo '\nWARNING: Failed to remove Podfile.lock.\n';
	$(FLUTTER) clean;
	$(FLUTTER) packages get;
	$(FLUTTER) precache --ios
	cd ./ios/; pod install --repo-update;
	$(FLUTTER) run --dart-define="DEBUG=true";

