tests:
	bin/rails test

setup:
	cp -n .env.example .env || true
	bin/setup

fixtures-load:
	bin/rails db:fixtures:load

clean:
	bin/rails db:drop

db-reset:
	bin/rails db:drop
	bin/rails db:create
	bin/rails db:migrate
	bin/rails db:fixtures:load

start:
	heroku local -p 3000

lint:
	bundle exec rubocop
	bundle exec slim-lint app/views/

linter-code-fix:
	bundle exec rubocop -A

deploy:
	git push heroku main

heroku-console:
	heroku run rails console

heroku-logs:
	heroku logs --tail

ci-setup:
	cp -n .env.example .env || true
	yarn install
	bundle install --without production development
	RAILS_ENV=test bin/rails db:prepare