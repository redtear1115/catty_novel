class Secret < Settingslogic
  source "#{Rails.root}/config/secrets.yml"
  namespace Rails.env
end
