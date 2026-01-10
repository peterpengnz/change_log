require 'rails/generators/active_record'
require 'rails/generators/named_base'

module ChangeLog
  module Generators
    class ChangeLogGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('templates', __dir__)

      def create_migration
        migration_file_name = "create_change_logs.rb"
        timestamp = Time.now.utc.strftime("%Y%m%d%H%M%S")
        destination = File.join('db', 'migrate', "#{timestamp}_#{migration_file_name}")
        template migration_file_name, destination
      end
    end
  end
end