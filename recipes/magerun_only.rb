#We need git for deployments
package "git-core" do
  action :install
end

include_recipe "n98-magerun::modules"
