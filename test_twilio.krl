ruleset test_twilio {
    meta {
        use module twilio
            with
                account_sid = meta:rulesetConfig{"account_sid"}
                auth_token = meta:rulesetConfig{"auth_token"}
        
    }
    global {

    }

    rule send_sms {
        select when twilio send_sms
        pre {
            to = event:attr{"to"}
            sender = event:attr{"sender"}
            message = event:attr{"message"}
        }
        twilio:send_sms(to, sender, message)
    }
}