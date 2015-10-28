module Cbratools
  class String
    def self.underscore(string)
      string.gsub(/::/, '/').
          gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').
          gsub(/([a-z\d])([A-Z])/, '\1_\2').
          tr("-", "_").
          downcase
    end

    def self.camelcase(string)
      return string if string !~ /_/ && string =~ /[A-Z]+.*/
      string.split('_').map { |e| e.capitalize }.join
    end
  end
end