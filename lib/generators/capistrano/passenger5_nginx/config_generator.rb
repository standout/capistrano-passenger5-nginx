module Capistrano
  module Passenger5Nginx
    module Generators
      class ConfigGenerator < Rails::Generators::Base
        desc "Create local nginx and passenger configuration files for customization"
        source_root File.expand_path('../templates', __FILE__)
        argument :templates_path, type: :string,
          default: "config/deploy/templates",
          banner: "path to templates"

        def copy_template
          copy_file "nginx_conf.erb", "#{templates_path}/nginx_conf.erb"
        end
      end
    end
  end
end
