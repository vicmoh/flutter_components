m = [AUTO]
git:
	git add -A
	git commit -m "$(m)"
	git push

export:
	cd lib/flutter_package_exporter/; make FILE='flutter_components'
