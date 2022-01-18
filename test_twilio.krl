ruleset test_twilio {
    meta {
        use module twilio
            with
                account_sid = meta:rulesetConfig{"account_sid"}
                auth_token = meta:rulesetConfig{"auth_token"}
                service_sid = meta:rulesetConfig{"service_sid"}
        shares lastResponse
    }
    global {
        lastResponse = function() {
            {}.put(ent:lastTimestamp, ent:lastResponse)
        }
    }

    rule send_sms {
        select when twilio send_sms
        pre {
            to = event:attrs{"to"}
            sender = event:attrs{"sender"}
            message = event:attrs{"message"}
        }
        twilio:send_sms(to, sender, message) setting(response)

        fired {
            ent:lastResponse := response
            ent:lastTimestamp := time:now()
        }
    }

    rule get_messages {
        select when twilio get_messages

        pre {
            to = event:attrs{"to"}
            sender = event:attrs{"sender"}
            page_size = event:attrs{"page_size"}
        }

       twilio:get_messages(to, sender, page_size) setting(response)

        fired {
            ent:lastResponse := response
            ent:lastTimestamp := time:now()
        }
    }
}