install: uninstall
	bundle install --binstubs --path vendor/gems --without production

uninstall:
	rm -fr Gemfile.lock vendor/ bin/ .bundle/

bump:
	agvtool bump -all

build:
	bundle exec ipa build

distribute:
	bundle exec ipa distribute
