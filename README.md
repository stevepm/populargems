Popular Gems - RAILS
======================================
This app is built to allow people an easier way to discover new ruby gems.

[![Code Climate](https://codeclimate.com/github/stevepm/populargems.png)](https://codeclimate.com/github/stevepm/populargems)
[![Build Status](https://travis-ci.org/stevepm/populargems.svg?branch=master)](https://travis-ci.org/stevepm/populargems)


URLs
====
* Running Site - [http://popular-gems.herokuapp.com/](http://popular-gems.herokuapp.com/)


Setup Instructions
==================
1. Clone this repository
1. `bundle`
1. Create databases: `rake db:create`
1. Run migrations: `rake db:migrate`
1. Run Specs `rspec`
1. Run Local Server `rails s`

On Heroku
---------
1. `heroku run 'rake db:migrate' -a HEROKUAPP`
