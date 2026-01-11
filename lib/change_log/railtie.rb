require 'rails/railtie'

module ChangeLog
  class Railtie < Rails::Railtie
    initializer 'change_log.active_record' do
      ActiveSupport.on_load(:active_record) do
        include ChangeLog::Model
      end
    end
  end
end