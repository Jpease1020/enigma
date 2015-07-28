require_relative 'offset'  # => true
class Encryptor

attr_accessor :rotations                            # => nil
  def initialize(message, date = nil, key = nil)
    @message = message.downcase                   # => "hello"
    key_offset = OffsetCalculator.new(date, key)  # => #<OffsetCalculator:0x007fb2c28220e0 @date="072615", @key=#<KeyGenerator:0x007fb2c2822090 @key="94321">>
    @rotations = key_offset.full_rotations        # => [102, 45, 34, 26]
  end                                             # => :initialize

  def character_map
    (0..9).to_a.map {|num| num.to_s } + ("a".."z").to_a + [" ", ".", ","]  # => ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " ", ".", ","], ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " ", ".", ","], ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " ", ".", ","], ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " ", ".", ","], ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p"...
  end                                                                      # => :character_map

  def cipher(rotation)
    rotated_characters = character_map.rotate(rotation)  # => ["o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " ", ".", ",", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n"], ["6", "7", "8", "9", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " ", ".", ",", "0", "1", "2", "3", "4", "5"], ["y", "z", " ", ".", ",", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x"], ["q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " ", ".", ",", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p"], ["o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " ", ".", ",", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "...
    Hash[character_map.zip(rotated_characters)]          # => {"0"=>"o", "1"=>"p", "2"=>"q", "3"=>"r", "4"=>"s", "5"=>"t", "6"=>"u", "7"=>"v", "8"=>"w", "9"=>"x", "a"=>"y", "b"=>"z", "c"=>" ", "d"=>".", "e"=>",", "f"=>"0", "g"=>"1", "h"=>"2", "i"=>"3", "j"=>"4", "k"=>"5", "l"=>"6", "m"=>"7", "n"=>"8", "o"=>"9", "p"=>"a", "q"=>"b", "r"=>"c", "s"=>"d", "t"=>"e", "u"=>"f", "v"=>"g", "w"=>"h", "x"=>"i", "y"=>"j", "z"=>"k", " "=>"l", "."=>"m", ","=>"n"}, {"0"=>"6", "1"=>"7", "2"=>"8", "3"=>"9", "4"=>"a", "5"=>"b", "6"=>"c", "7"=>"d", "8"=>"e", "9"=>"f", "a"=>"g", "b"=>"h", "c"=>"i", "d"=>"j", "e"=>"k", "f"=>"l", "g"=>"m", "h"=>"n", "i"=>"o", "j"=>"p", "k"=>"q", "l"=>"r", "m"=>"s", "n"=>"t", "o"=>"u", "p"=>"v", "q"=>"w", "r"=>"x", "s"=>"y", "t"=>"z", "u"=>" ", "v"=>".", "w"=>",", "x"=>"0", "y"=>"1", "z"=>"2", " "=>"3", "."=>"4", ","=>"5"}, {"0"=>"y", "1"=>"z", "2"=>" ", "3"=>".", "4"=>",", "5"=>"0", "6"=>"1", "7"=>"2", "8"=>"3", "9"=>"4", "a"=>"5", "b"=>"6", "c"=>"7", "d"=>"8", "e"=>"9", ...
  end                                                    # => :cipher

  def encrypt
      rotation_index = 0                                                              # => 0
      encrypted_message = @message.split("").map do |letter|                          # => ["h", "e", "l", "l", "o"]
        rotation_index = 0 if (!rotation_index.zero?) && ((rotation_index) % 4 == 0)  # => nil, nil, nil, nil, 0
        rotation_index += 1                                                           # => 1, 2, 3, 4, 1
        encrypt_character(letter, @rotations[rotation_index -1])                      # => "2", "k", "g", "8", "9"
        end                                                                           # => ["2", "k", "g", "8", "9"]
      encrypted_message.join                                                          # => "2kg89"
  end                                                                                 # => :encrypt


  def encrypt_character(letter, rotation)
      cipher_for_rotation = cipher(rotation)  # => {"0"=>"o", "1"=>"p", "2"=>"q", "3"=>"r", "4"=>"s", "5"=>"t", "6"=>"u", "7"=>"v", "8"=>"w", "9"=>"x", "a"=>"y", "b"=>"z", "c"=>" ", "d"=>".", "e"=>",", "f"=>"0", "g"=>"1", "h"=>"2", "i"=>"3", "j"=>"4", "k"=>"5", "l"=>"6", "m"=>"7", "n"=>"8", "o"=>"9", "p"=>"a", "q"=>"b", "r"=>"c", "s"=>"d", "t"=>"e", "u"=>"f", "v"=>"g", "w"=>"h", "x"=>"i", "y"=>"j", "z"=>"k", " "=>"l", "."=>"m", ","=>"n"}, {"0"=>"6", "1"=>"7", "2"=>"8", "3"=>"9", "4"=>"a", "5"=>"b", "6"=>"c", "7"=>"d", "8"=>"e", "9"=>"f", "a"=>"g", "b"=>"h", "c"=>"i", "d"=>"j", "e"=>"k", "f"=>"l", "g"=>"m", "h"=>"n", "i"=>"o", "j"=>"p", "k"=>"q", "l"=>"r", "m"=>"s", "n"=>"t", "o"=>"u", "p"=>"v", "q"=>"w", "r"=>"x", "s"=>"y", "t"=>"z", "u"=>" ", "v"=>".", "w"=>",", "x"=>"0", "y"=>"1", "z"=>"2", " "=>"3", "."=>"4", ","=>"5"}, {"0"=>"y", "1"=>"z", "2"=>" ", "3"=>".", "4"=>",", "5"=>"0", "6"=>"1", "7"=>"2", "8"=>"3", "9"=>"4", "a"=>"5", "b"=>"6", "c"=>"7", "d"=>"8", "e"=>"9", "f"=>"a", "...
      letter                                  # => "h", "e", "l", "l", "o"
      cipher_for_rotation                     # => {"0"=>"o", "1"=>"p", "2"=>"q", "3"=>"r", "4"=>"s", "5"=>"t", "6"=>"u", "7"=>"v", "8"=>"w", "9"=>"x", "a"=>"y", "b"=>"z", "c"=>" ", "d"=>".", "e"=>",", "f"=>"0", "g"=>"1", "h"=>"2", "i"=>"3", "j"=>"4", "k"=>"5", "l"=>"6", "m"=>"7", "n"=>"8", "o"=>"9", "p"=>"a", "q"=>"b", "r"=>"c", "s"=>"d", "t"=>"e", "u"=>"f", "v"=>"g", "w"=>"h", "x"=>"i", "y"=>"j", "z"=>"k", " "=>"l", "."=>"m", ","=>"n"}, {"0"=>"6", "1"=>"7", "2"=>"8", "3"=>"9", "4"=>"a", "5"=>"b", "6"=>"c", "7"=>"d", "8"=>"e", "9"=>"f", "a"=>"g", "b"=>"h", "c"=>"i", "d"=>"j", "e"=>"k", "f"=>"l", "g"=>"m", "h"=>"n", "i"=>"o", "j"=>"p", "k"=>"q", "l"=>"r", "m"=>"s", "n"=>"t", "o"=>"u", "p"=>"v", "q"=>"w", "r"=>"x", "s"=>"y", "t"=>"z", "u"=>" ", "v"=>".", "w"=>",", "x"=>"0", "y"=>"1", "z"=>"2", " "=>"3", "."=>"4", ","=>"5"}, {"0"=>"y", "1"=>"z", "2"=>" ", "3"=>".", "4"=>",", "5"=>"0", "6"=>"1", "7"=>"2", "8"=>"3", "9"=>"4", "a"=>"5", "b"=>"6", "c"=>"7", "d"=>"8", "e"=>"9", "f"=>"a", "...
      cipher_for_rotation[letter]             # => "2", "k", "g", "8", "9"
  end                                         # => :encrypt_character

end  # => :encrypt_character

encryptor = Encryptor.new("Hello", "072615","94321")  # => #<Encryptor:0x007fb2c28222e8 @message="hello", @rotations=[102, 45, 34, 26]>
encryptor.encrypt                                     # => "2kg89"
