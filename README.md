# The Scripted API Client

### Setup

Install via RubyGems:

    gem install scripted_client

Or a Gemfile:

    gem 'scripted_client'

In an initializer, set up your account identifier and access token. For example:

    # config/initializers/scripted.rb
    ScriptedClient.id = 'orangutan'
    ScriptedClient.access_token = 'make-great-pets'

In production, make sure you set the environment to **:production**

    ScriptedClient.env = :production

Otherwise, it will be **:sandbox** by default. Contact us for a Sandbox Account!

### Creating a Job

First, find a JobTemplate that you'd like to use:

    templates = ScriptedClient::JobTemplate.all
    blog_post = templates.find { |template| template.name == 'Standard Blog Post' }

Next, assign some values for the Prompts on that JobTemplate. Prompts are question/answer pairs that help guide your writer. They can be one of five kinds: `string[255]` `string[1024]` `radio` `checkbox` `array`. The data type of the `value` that you post will depend on the kind of the Prompt:

| Kind         | Value Type                    | Has `value_options`? |
|--------------|-------------------------------|----------------------|
| string[255]  | String (max. 255 characters)  | No                   |
| string[1024] | String (max. 1024 characters) | No                   |
| radio        | String                        | Yes                  |
| checkbox     | Array                         | Yes                  |
| array        | Array                         | No                   |

If the prompt has `value_options` the `value` you pick has to be one of them.

Here's how you might update a couple of prompt values:

    sample_blog = blog_post.prompts.find { |prompt| prompt.label == 'Sample Blog' }
    sample_blog.value = 'https://scripted.com/blogs/'
    goal = blog_post.prompts.find { |prompt| prompt.label == 'Goal' }
    goal.value = ['Informed analysis']
    key_points = blog_post.prompts.find { |prompt| prompt.label == 'Key Points' }
    key_points.value = ['Orangutans make great pets', 'Normal pets are lame']

Next, you can find an Industry:

    industries = ScriptedClient::Industry.all
    lifestyle = industries.find { |industry| industry.name == 'Lifestyle & Travel' }

Now you can create the Job!

    job = ScriptedClient::Job.new(
      topic: 'Top 10 Reasons to Buy an Orangutan',
      job_template: blog_post,
      industries: [lifestyle]
    )
    job.save
    # => true

**Protip** If `job.save` returns `false` use `job.errors.full_messages` to see what went wrong.

### Retrieving Jobs

Get all jobs using `ScriptedClient::Job.all`, or be a bit more specific using any of these scopes:

    screening writing draft_ready revising final_ready in_progress needs_review accepted rejected finished

For example:

    jobs = ScriptedClient::Job.needs_review

There are also scopes on Pitchset: `open`, `closed` and `requires_action`.

If the collection has a next page:

    jobs = ScriptedClient::Job.all
    jobs.has_next?
    # => true

you can retrieve that next page using `next`:

    jobs = ScriptedClient::Job.all
    page_two = jobs.next

If you'd like to review the written content itself, use the `html_contents` method:

    job = ScriptedClient::Job.first
    job.html_contents

### Development

From within this directory, `bundle install` and run `rspec` to execute the tests. If you want to use the gem against a local version of the API, set `ScriptedClient.env = :development`.
