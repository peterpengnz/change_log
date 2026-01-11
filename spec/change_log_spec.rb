require 'pry'

RSpec.describe ChangeLog do

  it "updates change log record with correct changes" do
    change_details = {
      action: 'INSERT', 
      record_id: 3, 
      table_name: 'test', 
      user: 'test', 
      attribute_name: 'total', 
      new_value: '50', 
      version: 1} 
    expect(ChangeLogs.update_change_log_record_with([change_details])).to be true
    expect(ChangeLogs.first).to have_attributes(change_details)
  end

  it "gets the correct version number" do
    expect(ChangeLogs.get_version_number(1,'test')).to eq(1)
  end

  it "gets the field type" do
    expect(ChangeLogs.get_field_type('test','total')).to eq('INTEGER')
  end

  # some logic test
  it "change log logic" do
      version_number = ChangeLogs.get_version_number(1,'test').next
      change_details = {
        action: 'UPDATE', 
        record_id: 1, 
        table_name: 'test',
        user: 'peterz', 
        attribute_name: 'test', 
        new_value: '999', 
        old_value: '100',
        version: version_number
      }
      expect(ChangeLogs.update_change_log_record_with([change_details])).to be true
      change_log = ChangeLogs.find(version_number)
      expect(change_log).to have_attributes(change_details)
  end
end
