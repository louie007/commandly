# Commandly

Commandly is a command line tool for creating iOS and/or Android project.
It lets you create projects from a local or remote template, it's simple to use and easy to customize.

## Installation

Install it yourself as:

    $ gem install commandly

Or add this line to your application's Gemfile:

```ruby
gem 'commandly'
```

And then execute:

    $ bundle


## Usage

```
Usage:
$ commandly new PROJECT_NAME
```
```
Options:
  -a, [--android], [--no-android]
  -i, [--ios], [--no-ios]
  -t, [--templateURL=TEMPLATEURL]
      [--verbose], [--no-verbose]
```

## Examples

```
# Create a new Android & iOS project called 'NextProject' from an embeded template
$ commandly new NextProject

# Create a new iOS project called 'NextProject' from an embeded template
$ commandly new NextProject -i

# Create a new Android project called 'NextProject' from a remote git repository template
$ commandly new NextProject -a -t https://github.com/louie007/commandly-templates.git

# Create a new Android project called 'NextProject' from a local git repository template
$ commandly new NextProject -a -t file:///Users/vuebly/repos/this-a-template/.git
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/louie007/commandly.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
