class Confirmation < ActionMailer::Base
  default_url_options[:host] = SETTINGS[:fqdn]
  
  # Ian's opinion:
  #  GramMailer
  
  def confirmation(gram)
    # TODO:  SET HTML
    recipients gram.from_email
    from "grumpy@grumpygrams.com"
    subject "Grumpy Gram Confirmation"
    body :gram => gram
  end

end
