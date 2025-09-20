def caesar_cipher(string, shift_factor)
  letters = ("a".."z").to_a

  cc = string.each_char.map do |char|
    idx = letters.find_index(char.downcase)

    if idx.nil?
      # if not a-z char then return it. spaces, etc
      char
    else 
      cc_char_idx = idx + shift_factor
      # To loop around back to the front
      # ie for shift of 5, cc_char_idx of "z" = 30
      # then 30 - 25 = 5, "e"
      if cc_char_idx > 25
        cc_char_idx -= letters.length
      end

      # convert back to upcase if needed
      char == char.upcase ? letters[cc_char_idx].upcase : letters[cc_char_idx]
    end
  end

  return cc.join("")
end
pp caesar_cipher("What~a string!", 5)