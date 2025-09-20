def substrings(string, dictionary)
  substring_hash = {}
  
  dictionary.each do |d_word|
    count = string.downcase.scan(/#{d_word}/i).length
    if count > 0
      substring_hash[d_word] ||= count
    end
  end

  substring_hash
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
pp substrings("below", dictionary)
pp substrings("Howdy partner, sit down! How's it going?", dictionary)
