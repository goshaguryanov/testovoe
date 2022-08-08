require "dry/rails"

Dry::Rails.container do
  # cherry-pick features
  config.features = %i[
    safe_params
    controller_helpers
  ]

  config.component_dirs.namespaces.add "contracts"
  config.component_dirs.add "app/contracts" do |dir|
    dir.namespaces.add_root key: "contracts", const: nil
  end
end
