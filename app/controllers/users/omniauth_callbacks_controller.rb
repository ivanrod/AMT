class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  layout "nav_amt"
  def coursera

    @omni = request.env["omniauth.auth"]

    #User enrollments
    uri2= URI.parse("https://api.coursera.org/api/users/v1/me/enrollments")
    request = Net::HTTP::Get.new uri2
    http = Net::HTTP.new(uri2.host, uri2.port)
    http.use_ssl = true
    request["Authorization"]="Bearer " + @omni["credentials"]["token"]
    @response = http.request request
    @response_body = JSON.parse(@response.body)

    @coursera_courses = @response_body['courses']

    #Enrollments details
    @coursera_courses.each do |key, value|
      uri2= URI.parse("https://api.coursera.org/api/catalog.v1/courses/" + key['id'].to_s + "?fields=estimatedClassWorkload,shortDescription")
      request = Net::HTTP::Get.new uri2
      http = Net::HTTP.new(uri2.host, uri2.port)
      http.use_ssl = true
      @catalog_response = http.request request  
      @catalog_time_estimated = JSON.parse(@catalog_response.body)
      
      #x.split[0].split("-")[-1]
      key["time_estimated"] = @catalog_time_estimated["elements"][0]["estimatedClassWorkload"]
      key["shortDescription"] = @catalog_time_estimated["elements"][0]["shortDescription"]
    end

    render "authentications/coursera"

    #render "authentications/index"

  end
end