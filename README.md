# Capistrano Passenger 5 and Nginx

This gem intends to ease the deployment of Rails apps with capistrano to passenger5 and nginx setup.

Warning: It is only tested with Capistrano 3 and some parts of the gem might be specific to our own usage (live `rbenv`). You are welcome to change it or send pull requests.


### What it does?

* Deploy Rails apps to passenger 5 and Nginx combination on Server.
* Ability to generate and upload a default Nginx configuration file for the application


# How to use

## Gemfile

Add this to `Gemfile`:

    group :development do
      gem "capistrano", "~> 3.3"
      gem 'capistrano-rbenv', '~> 2.0'
      gem 'capistrano-passenger5-nginx' , :git => 'https://github.com/standout/capistrano-passenger5-nginx.git'
    end

And then:

    $ bundle

## Capfile

Add this to your `Capfile`


    require 'capistrano/passenger5_nginx'


## Setup and usage

    rails g capistrano:passenger5_nginx:config

Above command will generate the default nginx config file in your project which will be at living at `/config/deploy/templates/nginx_conf.erb`

Warning: Below line is commented out in `nginx_conf.rb` file, if your ruby version is different than the version passenger5 uses, then uncomment this line and change the path with the one one your application should use.

`# passenger_ruby /your/ruby/version/path/2.2.0/bin/ruby;`

## Default log file directories

Nginx will be logging everything to `/opt/nginx/log/` directory

## Configuration

There are some flags that should be added to your production/staging.rb

These are:
* rails_env
* nginx_server_name
* nginx_use_ssl (true|false)
* passenger_min_instances  (if you want to have more than one instances running your app, default 1)

Here is an example for production.rb

```ruby
set :nginx_server_name, 'app.example.com'
set :nginx_use_ssl, true
set :rails_env, 'production'
set :passenger_min_instances, 2
```


## After deploy

Run the command below for uploading the nginx configuration and reloading the nginx for the first time deploy. This config file is not uploaded after each deploy so should be done manually.

`bundle exec cap production nginx:setup bundle exec cap production nginx:reload`

### Thanks

[@kalys](https://github.com/kalys) - for his
[capistrano-nginx-unicorn](https://github.com/kalys/capistrano-nginx-unicorn)
plugin.

[@bruno-](https://github.com/bruno-) - for his
[capistrano-unicorn-nginx](https://github.com/capistrano-plugins/capistrano-unicorn-nginx)
plugin.
