# The Scripted API Client Gem

In an initializer, set up your account identifier and access token. For example:

    # config/initializers/scripted.rb
    ScriptedClient.id = 'orangutan'
    ScriptedClient.access_token = 'make-great-pets'

Get all jobs using `ScriptedClient::Job.all`, or be a bit more specific using any of these scopes: `screening`, `writing`, `draft_ready`, `revising`, `final_ready`, `in_progress`, `needs_review`, `accepted`, `rejected`, `finished`. For example:

    jobs = ScriptedClient::Job.needs_review

There are also scopes on `ScriptedClient::Pitchset`: `open`, `closed`, `requires_action`.

If the collection has a next page:

    jobs = ScriptedClient::Job.all
    jobs.has_next?
    # => true

you can retrieve that next page using `next`:

    jobs = ScriptedClient::Job.all
    page_two = jobs.next

### Development

From within this directory, `bundle install` and run `rspec` to execute the tests.
