require 'csv'
require 'MergeHelpers'

# It looks like it works!! Now let's use real data!

# Table containing names and tokens with some columns we want to get rid of
headers = ['name'    , 'token' , 'trash'         ]
row1    = ['stephen' , '1234'  , 'trash'          ]
row2    = ['jill'    , '5678'  , 'deleteme' ]
row3    = ['jack'    , '10101' , 'moretrash'      ]

name_table = CSV::Table.new([CSV::Row.new(headers, row1)])
name_table << CSV::Row.new(headers, row2)
name_table << CSV::Row.new(headers, row3)

# Table containing emails and tokens; we'll want to merge on the token
headers = ['token' , 'email'             ]
row1    = ['1234'  , 'stephen@gmail.com' ]
row2    = ['5678'  , 'jill@gmail.com'    ]
row3    = ['9999'  , 'bob@gmail.com'     ]

email_table = CSV::Table.new([CSV::Row.new(headers, row1)])
email_table << CSV::Row.new(headers, row2)
email_table << CSV::Row.new(headers, row3)


# Clean out the columns we don't want
name_table = select_only_columns(name_table, ['token', 'name'])

# Merge with another table that token and email
table_merged = merge_tables(name_table, email_table, 'token')
# Looks like this...success!
# NOTE: Doesn't include non-matches, I'll have to make sure that we get the expected length

puts table_merged # =>
# name    , token , email
# stephen , 1234  , stephen@gmail.com
# jill    , 5678  , jill@gmail.com

# Now to test the append.rb script

load 'merge-helper.rb'
cd MergeHelpers

headers = ['name'    , 'token' , 'trash'         ]
row1    = ['stephen' , '1234'  , 'trash'          ]
row2    = ['jill'    , '5678'  , 'deleteme' ]
row3    = ['jack'    , '10101' , 'moretrash'      ]

first_half = CSV::Table.new([CSV::Row.new(headers, row1)])
first_half << CSV::Row.new(headers, row2)
first_half << CSV::Row.new(headers, row3)

second_half = CSV::Table.new([CSV::Row.new(headers, ['Mitchel', '1249'])])
second_half << CSV::Row.new(headers, ['Wilbur', '2910'])
second_half << CSV::Row.new(headers, ['Hank', '1956'])

# Then let's output these to use them as files
output_table('first-half.csv', first_half)
output_table('second-half.csv', second_half)

append_list = ['first_half.csv', 'second-half.csv']

complete_table = append_csv_files(append_list)
output_table('two-halves-make-a-whole.csv', complete_table)


