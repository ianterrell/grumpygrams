class GramMailer < ActionMailer::Base
  default_url_options[:host] = SETTINGS[:fqdn]
  
  def confirmation(gram)
    # TODO:  SET HTML
    recipients gram.from_email
    from "grumpy@grumpygrams.com"
    subject "Grumpy Gram Confirmation"
    body :gram => gram
  end
  
  def notification(gram)
    # TODO:  SET HTML
    recipients gram.to_email
    from "grumpy@grumpygrams.com"
    subject "Someone has sent you a GrumpyGram!"
    body :gram => gram
  end

end
