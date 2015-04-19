module TwilioHelper
  # Set up Twilio authorization
  @@twilio_sid = 'ACdaea6cc304f7e92e00bd0cbfc15939c0'
  @@twilio_auth_token = '9ef54858b1c4e28f8920b9e65ab31785'
  @@twilio_number = "+15102507548"

  # Set up a client to talk to the Twilio REST API
  client = Twilio::REST::Client.new(@@twilio_sid, @@twilio_auth_token)
  @@account = client.account

  def self.format_phone_number(phone_number)
    phone = phone_number.strip
    phone.gsub!(/[\(\)\ \-]/,"")
    illegal_plus_sign = /(.)\+/
    while phone.match(illegal_plus_sign)
      phone.sub!(illegal_plus_sign, $1)
    end
    phone.gsub!(/[^\+\d]/,"")
    return phone
  end

  def self.send_text(phone_number, message)
    errors = ""
    begin
      @@account.sms.messages.create({ :from => @@twilio_number,
                                      :to => phone_number,
                                      :body => message })
    rescue
      errors += TwilioHelper.get_invalid_phone_error_message
    end
    return errors
  end

  def self.get_invalid_phone_error_message
    return "Invalid phone number: \"#{phone_number}\". Please enter phone numbers with area codes (and country codes, if outside of America)."
  end
end
