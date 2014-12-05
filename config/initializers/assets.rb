
#Planification
Rails.application.config.assets.precompile += ['foundation-icons.css','planification.js', 'planification.css']

#Foundation Icons
Rails.application.config.assets.precompile += Dir["app/assets/stylesheets/foundation-icons/*"]

#Vendor
Rails.application.config.assets.precompile += Dir["vendor/assets/javascripts/*"]
Rails.application.config.assets.precompile += Dir["vendor/assets/stylesheets/*"]
