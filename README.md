[![CircleCI](https://circleci.com/gh/peterpaints/rydr/tree/ft-tests-auth-controllers-models-159684840.svg?style=svg)](https://circleci.com/gh/peterpaints/rydr/tree/ft-tests-auth-controllers-models-159684840)
[![Coverage Status](https://coveralls.io/repos/github/peterpaints/rydr/badge.svg?branch=ft-tests-auth-controllers-models-159684840)](https://coveralls.io/github/peterpaints/rydr?branch=ft-tests-auth-controllers-models-159684840)
#### Rydr

### Intro

An app to help you offer a coworker a ride. You log in, create a ride with an
origin, destination, departure time and so on, and anyone interested can join
you. No more lonely commutes home 😉

Find it here: [Rydr](https://rydr.herokuapp.com)

### Dev Tools

This are the tools I used:
* Rails 5
* ActiveRecord
* PostgresQL

### Installation

> Clone this repo to your local machine: Open terminal in any folder and type:
```
git clone https://github.com/peterpaints/rydr.git
```

> Switch to the develop branch using:
```
git checkout develop
```

>Run bundler to install gems (dependencies)
```
bundle
```

>Change the database.yml to add your postgres username and password in case you need it:
```
username: rydr (or your postgres instance username)
password: ****
```

>Create and Migrate the dbs
```
rails db:setup
```

> Finally, start the app!
```
rails s
```

### Contribution

Feel you have something you'd like to see added? Raise a PR!

### Tests

> Run tests with one simple command:
```
rspec
```

> If that doesn't work, try:
```
bundle exec rspec
```

### License

[The MIT License](https://github.com/peterpaints/rydr/blob/develop/LICENSE.md)
