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
            service_sid = ""
        provides get_messages, send_sms
        shares get_messages
    }
    global {
        base_url = <<https://api.twilio.com/2010-04-01/Accounts/#{account_sid}/Messages>>

        get_messages = function() {
            authMap = {"username":account_sid, "password":auth_token}
            response = http:get(<<#{base_url}.json>>, auth=authMap).klog()
            response{"content"}.decode()
        }

        send_sms = defaction(to, sender, message) {
            authMap = {"username":account_sid, "password":auth_token}
            form = { "Body":message, "From":sender, "To":to, "MessagingServiceSid":service_sid }
            http:post(base_url, auth=authMap, form=form) setting(response)
            return response
        }
    }
}