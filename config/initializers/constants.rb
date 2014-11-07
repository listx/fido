ROLE_ADMIN = 1
ROLE_TENANT_ADMIN = 2
ROLE_AUTHOR = 3

# Datetime, from
# gavinmorrice.com/blog/posts/3-keeping-your-dates-and-times-dry-with-to_formatted_s
[Time, Date].map do |klass|
  klass::DATE_FORMATS[:my_format] = lambda do |t|
    t.strftime("#{t.day.ordinalize} of %B, %Y %l:%M%P")
  end
end
