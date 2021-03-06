# Hotel Reservation

## Instructions

* The executable file is the `./reservation`
* I added the samples given in the email on the file `./sample_inputs.txt`
* To run the application just run `./reservation < sample_inputs.txt`
* To run tests or check the syntax run `bundle install` and then:
    * `rspec spec` to run the tests or
    * `rubocop ./lib/ ./reservation` for checking the syntax

## About the solution

Since the idea was to develop something scalable and ready for production I
tried to break into very small components, easy to understand and test.

I developed first the parsers, since it is easier to test, then the helpers
and models and finally the runner. When I had a very basic working and testable
code I organized the source and started refactoring, keeping the cycle
( red -> green -> refactor ).

I tried to test as much components as possible instead of focusing in testing
sample inputs.

I followed "Duck typing", so there is not much type testing. Also followed
[The Ruby Style Guide](https://github.com/bbatsov/ruby-style-guide) and used [Rubocop](https://github.com/bbatsov/rubocop) to ensure it was compliant.

I'm sending it with the `.git` folder inside, so the repository is available for
checking the steps that were taken. All the work is currently on the master
branch.
