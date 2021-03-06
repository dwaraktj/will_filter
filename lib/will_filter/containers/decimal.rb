#--
# Copyright (c) 2010-2013 Michael Berkovich
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#++

module WillFilter
  module Containers
    class Decimal < WillFilter::FilterContainer
      def self.operators
        [:is, :is_not, :is_less_than, :is_greater_than]
      end
    
      def template_name
        'text'
      end
    
      def numeric_value
        value.to_f
      end
    
      def validate
        return "Value must be provided" if value.blank?
        return "Value must be a valid floating point number" unless is_floating_point?(value)
      end
    
      def sql_condition
        return [" #{condition.full_key} = ? ",   numeric_value]    if operator == :is
        return [" #{condition.full_key} <> ? ",  numeric_value]    if operator == :is_not
        return [" #{condition.full_key} < ? ",   numeric_value]    if operator == :is_less_than
        return [" #{condition.full_key} > ? ",   numeric_value]    if operator == :is_greater_than
      end
    end
  end
end