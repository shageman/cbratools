# cbratools [![Build Status](https://travis-ci.org/shageman/cbratools.svg?branch=master)](https://travis-ci.org/shageman/cbratools) [![Gem Version](https://badge.fury.io/rb/cbratools.svg)](http://badge.fury.io/rb/cbratools) [![Code Climate](https://codeclimate.com/github/shageman/cbratools.png)](https://codeclimate.com/github/shageman/cbratools) [![Dependency Status](https://gemnasium.com/shageman/cbratools.svg)](https://gemnasium.com/shageman/cbratools)

A set of tools to help with refactorings in component-based Rails applications. Specifically,

* rnc: Renames a component and its references within a CBRA application
* rnm: Creates renaming migrations of all component tables for a rename

## Installation

Add this line to your application's Gemfile:

    gem 'cbratools'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cbratools

## Usage

### rnc

    rnc [-v] CurrentName NewName PATH

    Rename CBRA components.

    Pass no options to see this help text.

    Option -v is for verbose output.

### rnm

    rnm [-v] CurrentName NewName MIGRATIONS_PATH SCHEMA_FILE_PATH

    Create migrations to support CBRA component rename.

    Pass no options to see this help text.

    Option -v is for verbose output.

## Todos

_None yet_

## License

Copyright (c) 2015 Stephan Hagemann, stephan.hagemann@gmail.com, [@shageman](http://twitter.com/shageman)

Released under the MIT license. See LICENSE file for details.
