ruleset twilio {
    meta {
        name "Twilio"
        description <<
        Twilio Module
        >>
        author "Cameron Brown"
        configure using
            account_sid = ""
            auth_token = ""
        
    }
    global {
        base_url = "https://api.twilio.com/2010-04-01/Accounts/#{account_sid}/Messages"

        get_messages = function() {
            queryString = {"accountSid":account_sid, "authToken":auth_token}
            response = http:get(<<#{base_url}.json>>, qs=queryString)
            response{"content"}.decode()
        }
    }
}