class Teacher < ActiveRecord::Base
  validates_presence_of :name, :surname
  validates_format_of :phone,
                      :if => Proc.new {|t| not t.phone.nil? },
                      :message => "имеет неверный формат, правильные варианты: +7(11)111, 911 и т.п.",
                      :with =>  /^(?:(\+\d)?\d*\(\d+\)|\+?)(\d+-)*\d+$/
                      #         /^
                      #           (?:          - is there city code in () or no?
                      #             (\+\d)?     - if so, there may be +, and if so, at least one digit is before code
                      #             \d*         - then maybe some more digits
                      #             \(\d+\)     - code
                      #           |            - else
                      #             \+?         - maybe just a +
                      #           )
                      #                        - the number:
                      #           (\d+-)*        - any number of "0000-"-like blocks (probably zero)
                      #           \d+            - and some digits at the end, anyway
                      #         $/
  
  has_many  :lesson_subject_types
end
