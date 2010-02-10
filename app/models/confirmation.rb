class Confirmation < ActionMailer::Base
  
  def confirmation(gram)
    recipients gram.from_email
    from "grumpy@grumpygrams.com"
    subject "Grumpy Gram Confirmation"
    body :gram => gram
  end

end
