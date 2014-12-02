class Coursera < ActiveRecord::Base
	belongs_to :course

	def self.get_user_enrollments(omni)
    uri2= URI.parse("https://api.coursera.org/api/users/v1/me/enrollments")
    request = Net::HTTP::Get.new uri2
    http = Net::HTTP.new(uri2.host, uri2.port)
    http.use_ssl = true
    request["Authorization"]="Bearer " + omni["credentials"]["token"]
    response = http.request request
    response_body = JSON.parse(response.body)		
	end

	def self.get_catalog_course(course_id)
    uri2= URI.parse("https://api.coursera.org/api/catalog.v1/courses/" + course_id.to_s + "?fields=estimatedClassWorkload,shortDescription")
    request = Net::HTTP::Get.new uri2
    http = Net::HTTP.new(uri2.host, uri2.port)
    http.use_ssl = true
    catalog_response = http.request request  
    catalog_response_parsed = JSON.parse(catalog_response.body)

	end

end
