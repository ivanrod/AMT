
#Planification
Rails.application.config.assets.precompile += ['foundation-icons.css','planification.js', 'planification.css']

#Foundation Icons
array_to_slice = Dir["app/assets/stylesheets/foundation-icons/*"]
array_to_slice.each do |x|
  x.slice! "app/assets/stylesheets/"
end

Rails.application.config.assets.precompile += array_to_slice

#Vendor
array_to_slice = Dir["vendor/assets/javascripts/*"]
array_to_slice.each do |x|
  x.slice! "vendor/assets/javascripts/"
end
Rails.application.config.assets.precompile += array_to_slice
array_to_slice = Dir["vendor/assets/stylesheets/*"]
array_to_slice.each do |x|
  x.slice! "vendor/assets/stylesheets/"
end
Rails.application.config.assets.precompile += array_to_slice

#Javascripts & stylesheets
array_to_slice = Dir["app/assets/javascripts/*"]
array_to_slice.each do |x|
  x.slice! "app/assets/javascripts/"
end
Rails.application.config.assets.precompile += array_to_slice
array_to_slice = Dir["app/assets/stylesheets/*"]
array_to_slice.each do |x|
  x.slice! "app/assets/stylesheets/"
end
Rails.application.config.assets.precompile += array_to_slice
