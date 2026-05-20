# Adding CfA UI Components to a Rails app
1. Ensure that your app uses a node-based (i.e. `package.json` exists) asset pipeline with Tailwind and esbuild. _(TODO: Check whether other JS bundlers work)_ 
   1. You can create a new app that's set up correctly by passing `-j esbuild -c tailwind` to `rails new`
   2. Or, you can use `cssbundling-rails` and `jsbundling-rails` to install `tailwind` and `esbuild` respectively.  
2. Add the CfA UI Components gem by adding `gem "cfa_ui_components", github: "codeforamerica/cfa-ui-components"` to your `Gemfile`, and run `bundle install`
3. Run `bin/rails g cfa_ui_components:install`

## Using CfaFormBuilder

The gem ships a `CfaFormBuilder` that renders CfA input components via a single `input` helper. Its API is inspired by [simple_form](https://github.com/heartcombo/simple_form) — but it's a thin shim over the CfA components, not a wrapper around simple_form itself, so don't expect simple_form's wrappers, custom inputs, or config to be available.

Opt in per form:

```erb
<%= form_with model: @user, builder: CfaFormBuilder do |f| %>
  <%= f.input :name %>
  <%= f.input :email, as: :text %>
  <%= f.input :state, as: :select, options: us_states %>
  <%= f.input :birthdate, as: :date %>
<% end %>
```

Or set it as the app default in `ApplicationController`:

```ruby
default_form_builder CfaFormBuilder
```

Supported `as:` values: `:text`, `:currency`, `:select`, `:combobox`, `:tin`, `:checkbox`, `:radios`, `:date`. The `optional` flag is inferred from presence/acceptance validators on the model.

# Adding a new component to CFA UI Components
1. Run `bin/rails g view_component:component <COMPONENT_NAME>` to create all the relevant files.
2. Make local changes

# How to test changes to CfA UI Components locally
1. Make local changes
2. Run `gem build cfa_ui_components.gemspec && gem install cfa_ui_components` to build the gem & install it locally
3. In your Rails app,
   1. Modify the Gemfile to use the locally-installed cfa_ui_components gem.
      - `gem "cfa_ui_components"`
   2. Run `bundle update cfa_ui_components`
   3. Ensure that you switch the Gemfile back to github & update again before merging your PR.

## Running the Lookbook locally
Run `bin/dev` and navigate to localhost:3000

# Contributing

## Setup

### Ruby & Node Installation (via mise)

We use [mise](https://mise.jdx.dev/) to manage Ruby and Node versions (replaces rbenv/nvm):

```sh
brew install mise
# set mise to use legacy dotfiles like .ruby-version and .node-version
mise settings add idiomatic_version_file_enable_tools ruby
mise settings add idiomatic_version_file_enable_tools node
```

Follow the [mise activation instructions](https://mise.jdx.dev/getting-started.html#activate-mise) for your shell. e.g. for zsh:

```sh
echo 'eval "$(mise activate zsh)"' >> ~/.zshrc
source ~/.zshrc
```

Then, from the project directory:

```sh
mise install    # installs Ruby and Node
```

### Git hooks
Install [lefthook](https://github.com/evilmartians/lefthook) and enable the git hooks:

```sh
brew install lefthook
lefthook install
```

Lefthook runs `rubocop` and `erb_lint` on pre-commit. To run manually:

```sh
bin/rubocop --autocorrect
bundle exec erb_lint --autocorrect 'app/**/*.erb'
```

