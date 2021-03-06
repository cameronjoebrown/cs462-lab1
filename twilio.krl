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
        provides get_messages, send_sms
        shares get_messages
    }
    global {
        base_url = <<https://api.twilio.com/2010-04-01/Accounts/#{account_sid}/Messages>>

        get_messages = function(to="+14352162134", sender="+19402907444", page_size=20) {
            authMap = {"username":account_sid, "password":auth_token}
            queryString = { "From":sender, "To":to, "PageSize":page_size }
            response = http:get(<<#{base_url}.json>>, auth=authMap, qs=queryString)
            response{"content"}.decode()
        }

        send_sms = defaction(to, sender, message) {
            authMap = {"username":account_sid, "password":auth_token}
            form = { "Body":message, "From":sender, "To":to }
            http:post(base_url, auth=authMap, form=form) setting(response)
            return response
        }
    }
}