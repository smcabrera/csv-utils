arequire 'csv'
require 'pry'

def range(num)
  result = []
  count = 0
  num.times do
    result << count
    count += 1
  end
  return result
end


# First let's read in the two files we're going to append
requests1 = CSV.read('request_test.csv', headers:true)
requests2 = CSV.read('request_test2.csv', headers:true)

# We ONLY want the email and token columns from request. Let's grab those as variables and then only output them
#names_col =  requests['names']
email_col =  requests['email']
token_col =  requests['token']
columns = [email_col, token_col]

CSV.open('requests_clean.csv', 'w') do |csv_object|
  csv_object << ['email', 'token']
  range(requests.length).each do |num|
    row_array = []
    row_array << columns[0][num]
    row_array << columns[1][num]
    #row_array << columns[2][num]
    csv_object << row_array
  end
end

requests_clean = CSV.read('requests_clean.csv')
print requests_clean[1]

# 2.5 Do the same with gadata
gadata = CSV.read('gadata.csv', headers:true)
print gadata[1][0]

# 3) Create a merge array
# merge = []

# Helper: Take a token as an argument and find
# Find the appropriate email for each one, looking it up by its token
# sample_table = [['test@email.com', 1234], ['stuff@example.com', 5678]]
# puts find_email_by_token(sample_table, 5678)

def find_email_by_token(table, token)
  table.each do |row|
    if row[1] == token
      return row[0]
    end
  end
end

gadata.each do |row|
   find_email_by_token(requests_clean, row[0])
end

# TODO: Troubleshoot the above, doesn't seem to be working correctly
# TODO: Iterate through all of the rows in gadata,
# TODO: look up the matching email in the requests table
# TODO: Add the matching email to a merge array


# TODO:Output the merge array


