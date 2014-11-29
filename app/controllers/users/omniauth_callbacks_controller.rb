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
    @coursera_enrollments = @response_body['enrollments']

    #Enrollments details
    @coursera_courses.each do |key, value|
      uri2= URI.parse("https://api.coursera.org/api/catalog.v1/courses/" + key['id'].to_s + "?fields=estimatedClassWorkload,shortDescription")
      request = Net::HTTP::Get.new uri2
      http = Net::HTTP.new(uri2.host, uri2.port)
      http.use_ssl = true
      @catalog_response = http.request request  
      @catalog_response_parsed = JSON.parse(@catalog_response.body)
      
      #x.split[0].split("-")[-1]
      key["time_estimated"] = @catalog_response_parsed["elements"][0]["estimatedClassWorkload"]

      key["shortDescription"] = @catalog_response_parsed["elements"][0]["shortDescription"]
      key["start_date"], key["end_date"] = Course.get_start_and_end_date(@coursera_enrollments, key['id'])
      if key["time_estimated"] == ""
        key["time_estimated"] = "0"
        key["start_date"] = Time.current.utc.to_i
        key["end_date"] = (Time.current+10000000).utc.to_i
      end
    end
=begin
    uri2= URI.parse("https://api.coursera.org/api/catalog.v1/sessions?fields=courseId,startDay,startMonth,startYear")
    request = Net::HTTP::Get.new uri2
    http = Net::HTTP.new(uri2.host, uri2.port)
    http.use_ssl = true
    @sessions_response = http.request request  
    @sessions_response_parsed = JSON.parse(@sessions_response.body)
    n=0
    @coursera_enrollments.each do |key, value|
      #Modificar para que modifique @coursera_courses
      course_start_date = Course.get_data_from_session_array(@sessions_response_parsed['elements'] ,key["sessionId"])
      #key["sessionId"] = @sessions_response_parsed["elements"][0]["sessionId"]
      #@coursera_courses[n]["start_date"] =course_start_date
      n+=1
    end
=end
    

    Course.set_coursera_courses(@coursera_courses) 
    render "authentications/coursera"

    #render "authentications/index"

  end


end