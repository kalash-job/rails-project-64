tests:
	bin/rails test

setup:
	cp -n .env.example .env || true
	bin/setup

start:
	bin/rails server

lint:
	bundle exec rubocop
	bundle exec slim-lint app/views/

linter-code-fix:
	bundle exec rubocop -A

deploy:
	railway up

ci-setup:
	cp -n .env.example .env || true
	yarn install
	bundle install --without production development
	RAILS_ENV=test bin/rails db:prepare