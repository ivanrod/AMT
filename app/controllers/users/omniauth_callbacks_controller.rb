class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
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
    puts key["id"]
  end

  render "courses/coursera"

  #render "authentications/index"

  end
end