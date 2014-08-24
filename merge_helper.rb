require 'csv'
require 'pry'

module MergeHelpers

  def self.append_csv_files(filenames_list)
    merged_array = []
    filenames_list.each do |file|
      table = CSV.read(file, headers:true)
      table.each do |row|
        merged_array << row
      end
    end
    CSV::Table.new merged_array
  end

  def self.select_only_columns(table, headers)
    # Selects from the table those columns in the columns list and returns a new array with only those columns
    column_list = []
    headers.each do |col_name|
      column_list << table[col_name]
    end
    # You can probably completely get rid of the above and use it in the logic below

    #We have them stored as columns; now to write them out as rows
    row_array = []
    table.length.times do |row_num|
      fields = []
      column_list.each do |col|
        fields << col[row_num]
      end
      row = CSV::Row.new(headers, fields)
      row_array << row #todo: Here too we should be able to refactor--add a row if rows exists otherwise set rows to be a an array that contains just row
    end
    CSV::Table.new(row_array)
  end

  def self.merge_rows(row1, row2, merge_key)
    # Create a list containing the headers for the final merged row
    headers = row2.headers.dup
    headers.length.times do |num|
      row1.push([headers[num], row2[num]])
    end
    row1.delete(merge_key)
    return row1
  end

  def self.merge_tables(master_table, merge_table, merge_key)
    output_table = CSV::Table.new []
    master_table.each do |row|
      merge_table.each do |row2|
        if row[merge_key] == row2[merge_key]
          output_table << merge_rows(row, row2, merge_key)
        end
      end
    end
    return output_table
  end

# Output the result into a new CSV file
# Not positive if this is necessary, but it makes it easier for me to remember at least
  def self.output_table(outputfilename, table)
    CSV.open(outputfilename, "wb") do |csv|
      table.each do |row|
        csv << row
      end
    end
  end
end




