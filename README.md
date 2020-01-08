# About repo
This repo contains 2 version of rails: 5.0.7.2 and 5.1.7.
The idea is to prepare them with minimum exact configuration for both versions to compare performance of simple command.

Testable snippet to load 2 one to many relationships, with preload via `.includes()`. Returns median time spent on execution of one line `product.variants.each { |v| v.option_values.first.name }`.  
```ruby
begin
  repeat_amount = 200
  product = Product.includes(variants: :option_values).find_by!(catalog_number: 'G640')

  bar = ProgressBar.new(repeat_amount)
  timings = repeat_amount.times.map do
    time = Benchmark.realtime do
      product.variants.each { |v| v.option_values.first.name }
    end
    bar.increment!
    time
  end

  timings.sort[timings.size / 2]
end
```

# How to run

1. Clone and open folder `git clone git@github.com:sdtechdev/rails-5.1-performance-test.git && cd rails-5.1-performance-test`
1. Make sure ruby 2.6.1 installed. Not sure if it's version is important, but this version I used when tested performance.
1. Both apps expect postgres running on host `postgres` and username `postgres`, without password
1. Setup 5.0.7.2 `cd rails5_0_7_2 && bundle && bundle exec rails db:create db:structure:load db:seed`
1. Open console `bundle exec rails c` and run snippet from the beginning of this readme. Note down the time you've got.
1. Close console `exit` and go back to repo root folder `cd ../`
1. Setup 5.1.7 `cd rails5_1_7 && bundle && bundle exec rails db:create db:structure:load db:seed`
1. Open console `bundle exec rails c` and run snippet from the beginning of this readme. Note down the time you've got.
1. Now compare 2 numbers.

# My result

I tested it on my local machine, 5.1 version performance roughly ~40 times worse than 5.0 version performance. I have no idea if I did something wrong or there is some "specific" added in 5.1. Please let me know if you find anything. Cheers.

5.0: 0.0015
5.1: 0.0787

# How to add new version here

1. Open root repo folder
1. Install needed rails version, for example `gem install rails -v 5.2.4.1 --no-document`
1. Create new app `rails _5.2.4.1_ new rails5_2_4_1 --skip-bundle --database=postgresql --skip-git`
1. Prepare database.yml
    ```
    host: postgres
    username: postgres
    ```
1. `cp -R rails5_0_7_2/db/seeds rails5_2_4_1/db && cp rails5_0_7_2/db/seeds.rb rails5_2_4_1/db && cp rails5_0_7_2/db/structure.sql rails5_2_4_1/db && cp -R rails5_0_7_2/app/models/*.rb rails5_2_4_1/app/models`
1. add `config.active_record.schema_format = :sql` to `config/application.rb`
1. add to Gemfile
    ```
    gem 'pry-rails'
    gem 'progress_bar'
    ```
