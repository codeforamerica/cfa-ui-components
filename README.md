# Adding CfA UI Components to a Rails app
1. Ensure that your app uses a node-based (i.e. `package.json` exists) asset pipeline with Tailwind and esbuild. _(TODO: Check whether other JS bundlers work)_ 
   1. You can create a new app that's set up correctly by passing `-j esbuild -c tailwind` to `rails new`
   2. Or, you can use `cssbundling-rails` and `jsbundling-rails` to install `tailwind` and `esbuild` respectively.  
2. Add the CfA UI Components gem by adding `gem "cfa_ui_components", github: "codeforamerica/cfa-ui-components"` to your `Gemfile`, and run `bundle install`
3. Run `bin/rails g cfa_ui_components:install`

# How to test changes to CfA UI Components locally
1. Make local changes
2. Run `gem build cfa_ui_components.gemspec && gem install cfa_ui_components` to build the components
3. Modify the Gemfile for the Rails app to use the local cfa-ui-components repo.
- `gem "cfa_ui_components", path: "../cfa-ui-components"` # this should be the local path to the cfa-ui-components repo

## Running the Lookbook locally
Run `bin/dev` and navigate to localhost:3000
