# ConnectBook

ConnectBook is a project based in facebook. It has a features of the original app such as: 
* Upload posts including photos
* Comment and like a post
* Upload profile and wallpaper photos
* Add, delete, search friends

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

This project is built with Ruby on Rails and Javascript. Before try to run it locally make sure you have [Ruby](https://www.ruby-lang.org/en/documentation/installation/), and [Ruby on Rails](https://www.tutorialspoint.com/ruby-on-rails/rails-installation.htm) installed. 

After installing check your ruby version with `ruby -v`

```
ruby -v
ruby 2.5.3p105 (2018-10-18 revision 65156) [x64-mingw32]
```
and your rails version with `rails -v`

```
rails -v
Rails 5.2.3
```

### Installing

Run `bundle install` to install all required dependencies

### Run the server 

To run the server and open your project run: `rails s` and open a tab in your browser at localhost:3000 which is the default port rails use. Don't forget to start the [postgreSQL](https://tableplus.com/blog/2018/10/how-to-start-stop-restart-postgresql-server.html) database server

## Running the tests

Run `bundle exec rspec spec` to run all the tests that were included in this project 

### And coding style tests

Explain what these tests test and why

```
Give an example
```

## Deploy on Heroku

You can deploy the project on Heroku using the following steps:

* Create a Heroku Account
* On the terminal, run heroku create to create a new app
* Run heroku push to start a deployment on Heroku.
* Run heroku migrate to run migrations on your production database.
* Visit your project URL as assigned by Heroku to see a live deployment of Fakebook.

## Built With

* HTML5,CSS3
* Javascript
* Ruby On Rails

## Authors

* [Orestis Kaplanis](https://github.com/userman95)
* [Efrain Pinto](https://github.com/efrapp)

## Database Diagram
This is the diagram to show the associations between models: ![Database diagram](https://github.com/efrapp/facebook/blob/develop/public/facebook_db_diagram.png)

## Screenshots

 ![screenshot](https://github.com/userman95/facebook/blob/master/screensgots.png)
