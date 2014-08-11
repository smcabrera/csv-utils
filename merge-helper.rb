require 'csv'
require 'pry'

module MergeHelpers

  def range(num)
    result = []
    count = 0
    num.times do
      result << count
      count += 1
    end
    return result
  end

  def append_csv_files(filenames_list)
    merged_array = []
    filenames_list.each do |file|
      table = CSV.read(file, headers:true)
      table.each do |row|
        merged_array << row
      end
    end
    CSV::Table.new merged_array
  end

  def select_only_columns(table, column_names_list)
    # Selects from the table those columns in the columns list and returns a new array with only those columns
    headers = []
    result_array = []
    column_list = []
    column_names_list.each do |column_name|
      column_list << table[column_name]
      headers << column_name
    end
  end


  def merge_tables(master_table, merge_table)
    output_table = CSV::Table.new []
    # grab all the rows that  are to be merged [[]]
    # do merge for all matching rows
    gadata.each do |row|
      table.each do |row2|
         merge_rows(row, row2)  if row["token"] == row2["token"]
         new_row = row.dup
         new_row["email"] = row2["email"]
         output_table << new_row
      end
    end
    return output_table
  end
end

# Output the result into a new CSV file
