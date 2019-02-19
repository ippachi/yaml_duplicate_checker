# YamlDuplicateChecker

This gem check duplicates recursively abount yaml.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'yaml_duplicate_checker'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yaml_duplicate_checker

## Usage

```
ydc path/to/yaml/directory
```

`ydc` searches directories recursively.

If there is no duplicate, outputs nothing

If have duplicates, outputs like below

```
test1.key1:
  test2.yaml:10
  test1.yaml:2
```

`test1.key1` is a duplicate key.
`test2.yaml:10` and `test1.yaml:2` are path and line number where duplicate is occured.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/yaml_duplicate_checker.
