# JsonCanvas

[JSONCanvas](https://jsoncanvas.org/spec/1.0/) Implementation for Ruby.

## Installation

To install JsonCanvas gem, add this line to your application's Gemfile:

```bash
gem 'json_canvas'
```

And then execute:

```bash
$ bundle install
```

Or install it yourself as:

```bash
$ gem install json_canvas
```

## Usage


To use JSONCanvas, include the gem in your Ruby script:

```ruby
require 'json_canvas'
```

### Creating a Canvas

Create a new canvas using:

```ruby
jc = JsonCanvas.create
```

### Adding Text Nodes

Add text nodes to the canvas:

```ruby
text_node = jc.add_text(text: "Hi")
```

You can customize the text node with parameters like id, position, size, and content:

```ruby
custom_text = jc.add_text(id: "unique_id", x: 10, y: 20, width: 100, height: 200, text: "Hello World")
```

### Advanced Node Types

Add file and link nodes with specific attributes:

```ruby
file_node = jc.add_file(file: "path/to/file")
link_node = jc.add_link(url: "https://example.com")
group_node = jc.add_group(label: "Test Group")
```

### Edge

Connect nodes with edges:

```ruby
jc = JsonCanvas.create
start = jc.add_text(id: "START", text: "start")
goal = jc.add_text(id: "GOAL", x: 400, text: "goal")
jc.add_edge(id: "edge1", fromNode: start.id, toNode: goal.id)
jc.add_edge(id: "edge2", fromNode: start.id, fromSide: "top", fromEnd: "arrow", toNode: goal.id, toSide: "bottom", toEnd: "arrow", color: "2", label: "HELLO")
```

### Saving and Loading
Save the canvas to a file or load from it:

```ruby
jc.save('my_canvas.json')
loaded_canvas = JsonCanvas.parse(File.read('my_canvas.json'))
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test-unit` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/json_canvas.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
