class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  layout "nav_amt"
  def coursera

    @omni = request.env["omniauth.auth"]

    #User enrollments
    @response_body = Coursera.get_user_enrollments(@omni)

    @coursera_courses = @response_body['courses']
    @coursera_enrollments = @response_body['enrollments']

    #Enrollments details
    @coursera_courses.each do |key, value|
      @catalog_response_parsed = Coursera.get_catalog_course(key['id']) 
  
      key["time_estimated"] = @catalog_response_parsed["elements"][0]["estimatedClassWorkload"]

      key["shortDescription"] = @catalog_response_parsed["elements"][0]["shortDescription"]
      key["start_date"], key["end_date"] = Course.get_start_and_end_date(@coursera_enrollments, key['id'])
      if key["time_estimated"] == ""
        key["time_estimated"] = "0"
        key["start_date"] = Time.current.utc.to_i
        key["end_date"] = (Time.current+10000000).utc.to_i
      end
    end    

    Course.set_coursera_courses(@coursera_courses) 
    render "authentications/coursera"

  end


end