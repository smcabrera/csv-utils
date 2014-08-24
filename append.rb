#!/usr/bin/env ruby

require_relative './merge-helper'

csv_table = MergeHelpers.append_csv_files(ARGV)

puts csv_table.to_s
