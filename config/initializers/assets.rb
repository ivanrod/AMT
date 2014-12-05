
#Planification
Rails.application.config.assets.precompile += ['foundation-icons.css','planification.js', 'planification.css']

#Foundation Icons
Rails.application.config.assets.precompile += Dir["app/assets/stylesheets/foundation-icons/*"].map {|i| i.slice! "app/"}

#Vendor
Rails.application.config.assets.precompile += Dir["vendor/assets/javascripts/*"].map {|i| i.slice! "vendor/"}
Rails.application.config.assets.precompile += Dir["vendor/assets/stylesheets/*"].map {|i| i.slice! "vendor/"}
