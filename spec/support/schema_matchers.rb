# set up schema matchers
RSpec.configure do |config|
  config.include JSON::SchemaMatchers
  config.json_schemas[:address] = 'spec/support/schemas/address.json'
  config.json_schemas[:contact_number] = 'spec/support/schemas/contactNumber.json'
  config.json_schemas[:ethnicity] = 'spec/support/schemas/ethnicity.json'
  config.json_schemas[:prosecution_case_identifier] = 'spec/support/schemas/prosecutionCaseIdentifier.json'
  config.json_schemas[:person] = 'spec/support/schemas/person.json'
end
