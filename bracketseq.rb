# frozen_string_literal: true

class Bracketseq
  class << self
    def longest_sequence(str)
      raise ArgumentError unless valid_symbols? str

      size = str.chars.count
      max = 0
      max_l, max_r = []
      (0..size).each do |l|
        ((l + 2)..size).each do |r|
          next if (r - l <= max) || !valid_brackets?(str[l, r])

          max = r - l
          max_l = l
          max_r = r
        end
      end
      str[max_l, max_r]
    end

    def valid_symbols?(str)
      str =~ /^[\[\]\(\)\{\}]*$/
    end

    def pair_bracket(c)
      case c
      when '['
        ']'
      when ']'
        '['
      when '{'
        '}'
      when '}'
        '{'
      when '('
        ')'
      when ')'
        '('
      end
    end

    def valid_brackets?(srt)
      stack = []
      srt.chars.each do |c|
        if ['[', '(', '{'].include? c
          stack.push c
        elsif stack.any? && (stack.last == pair_bracket(c))
          stack.pop
        else
          return false
        end
      end
      stack.empty?
    end
  end
end
