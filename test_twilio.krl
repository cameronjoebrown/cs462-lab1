ruleset test_twilio {
    meta {
        use module twilio
            with
                account_sid = meta:rulesetConfig{"account_sid"}
                auth_token = meta:rulesetConfig{"auth_token"}
        
    }
    global {
        
    }
}