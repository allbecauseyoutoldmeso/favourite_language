# Favourite Language

## Spec

Build a simple web or command line application, which should allow users to enter an arbitrary GitHub username, and be presented with a best guess of the GitHub user's favourite programming language.

This can be computed by using the GitHub API to fetch all of the user's public GitHub repos, each of which includes the name of the dominant language for the repository.


## Live Version

Try it out [here](https://gentle-plains-95334.herokuapp.com/)!

## Running locally

* Clone and `cd` into this repository.
* Run `bundle install`.
* Run `rspec` to verify the tests are passing.
* Run `rubocop` to verify that the code is looking sharp.
* Run `bin/rails server` and go to `http://localhost:3000`.
