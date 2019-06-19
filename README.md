# USER AUTHENTICATION

## Table Data

### USER

| Key | DataType | Validation |
| ------ | ------ | ------ |
| id | integer | uniq |
| username | string | not null, uniq |
| email | string | not null, uniq |
| password | string | not null |
| password_reset_token | string | not null |
| password_reset_sent_at | datetime | not null |
| created_at | datetime | not null |
| updated_at | datetime | not null |

## Get started

### Create Database & migrate

```sh
rails db:create db:migrate
```

### Start rails server

```sh
rails s
```
Go to the path [http://localhost:3000](http://localhost:3000)

### Test with rspec

```sh
bundle exec rspec spec
```
