# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
FbDssd::Application.initialize!


ENV['RECAPTCHA_PUBLIC_KEY']  = '6Ld9wc8SAAAAANVL-9XEqk2S310Wzh15c8q0kJ7J'
ENV['RECAPTCHA_PRIVATE_KEY'] = '6Ld9wc8SAAAAAJdvOeMhd2Ud1gu4PabT8GmsGsEy'

