# Inch Technical Test

This is Ruby on Rails app that will update the database to match the data the clients provide in CSV format on a daily basis.

The objective is to code the CSV import and handle some specific update rules.

## Versions :

Ruby - 2.5.1

Rails - 5.2.4

DB - PostgreSQL

Framework - Ruby on Rails

## To start :
To use this app locally, download the repo or clone it.

### Installation:
```bash
bundle install
```
```bash
rails db:create
```
```bash
rails db:migrate
```
```bash
rails server
```
Then go to ```http://localhost:3000/```

## How to test the app ?

### Via Rspec
Run ```rspec``` 

### By using input files
Some csv files are provided in app/assets/csvfiles folder