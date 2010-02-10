SETTINGS = YAML.load_file("#{RAILS_ROOT}/config/settings.yml")[RAILS_ENV]
AWS_SETTINGS = YAML.load_file("#{RAILS_ROOT}/config/aws.yml")[RAILS_ENV]