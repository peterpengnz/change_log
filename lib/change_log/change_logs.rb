# frozen_string_literal: true

require 'activerecord-import'

class ChangeLogs < ActiveRecord::Base
  self.table_name = :change_logs

  # Save Change Log details with changes
  def self.update_change_log_record_with(changes=[])
    records = []
    changes.each do |option|
      record = ChangeLogs.new(option)
      record.field_type = get_field_type(option[:table_name], option[:attribute_name]) unless option[:action].to_s.upcase == 'DELETE'
      record.user = option[:user].id if option[:user].respond_to?(:id)
      record.created_at = Time.now
      records << record
    end
    ChangeLogs.import records, validate: false
    true
  end

  # return the latest version number for this change
  def self.get_version_number(id, table_name)
    latest_version = ChangeLogs.where(record_id: id, table_name: table_name).maximum(:version)
    latest_version.nil? ? 1 : latest_version.next
  end

  def self.get_field_type(table_name, field_name)
    return 'Error' if table_name.blank? || field_name.blank?

    ActiveRecord::Base.connection.columns(table_name).each do |field|
      return field.sql_type if field.name.eql?(field_name)
    end
  end
end
