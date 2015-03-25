# Lonely Planet Coding Exercise

## Setup

To install dependencies, run:

    $ bundle install

## Test

To run the test suite:

    $ bundle exec rspec

## To examine test coverage:

Open `coverage/index.html`

## Generate output

To generate the output for the initial sample destinations and taxonomy:

    $ bundle exec ruby runner.rb -ttaxonomy.xml -ddestinations.xml -ooutput

Examine the contents of the `output` folder.

## Next steps

* Add support for more of the content.

* Generate the output in a folder structure that mirrors the taxonomy with
  folder names and file names based on the destination names?
