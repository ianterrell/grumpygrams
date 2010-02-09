module Regex
  # From RestfulAuthentication...
  EMAIL_NAME   = '[\w\.%\+\-]+'                          # what you actually see in practice
  DOMAIN_HEAD  = '(?:[A-Z0-9\-]+\.)+'
  DOMAIN_TLD   = '(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|jobs|museum)'
  EMAIL        = /\A#{EMAIL_NAME}@#{DOMAIN_HEAD}#{DOMAIN_TLD}\z/i
  
  URL = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
  HTTP_URL = /^(http):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
  
  PHONE        = /^\(\d{3}\)\ \d{3}-\d{4}*$/
  
  HEX_COLOR    = /^[0-9a-fA-F]{6,6}/
end