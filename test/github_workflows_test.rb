require "test_helper"
require "yaml"

# Tags can be moved to point at different code, so a compromised third-party
# action could change what runs in CI and deploys (TEF-911). Pin those actions
# to a full commit SHA with a "# vX.Y.Z" comment so Dependabot keeps them current.
# GitHub-, AWS-, and Code for America-owned actions may stay on tags or branches,
# matching Aikido's rule.
class GithubWorkflowsTest < ActiveSupport::TestCase
  TRUSTED_OWNERS = %w[actions aws-actions codeforamerica].freeze

  test "pins every third-party action to a full commit SHA" do
    workflow_paths = Dir.glob(Rails.root.join(".github/workflows/*.{yml,yaml}"))
    assert_not_empty workflow_paths

    unpinned = workflow_paths.flat_map do |path|
      jobs = YAML.load_file(path).fetch("jobs", {}).values
      refs = jobs.flat_map { |job| [job["uses"], *Array(job["steps"]).map { |step| step["uses"] }] }.compact

      refs.filter_map do |ref|
        next if ref.start_with?("./")

        name, version = ref.split("@", 2)
        next if TRUSTED_OWNERS.include?(name.split("/").first)
        next if version&.match?(/\A\h{40}\z/)

        "#{File.basename(path)}: #{ref}"
      end
    end

    assert_empty unpinned, "Pin these to a full commit SHA with a version comment:\n#{unpinned.join("\n")}"
  end
end
