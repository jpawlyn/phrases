module Phrases
  require 'faker'
  DELIMITER = '|'
  PHRASES_FILE = 'lib/random-phrases.txt'

  # extract phrase at random from file
  # note, the longer the phrase the more chance it has of being selected
  def self.random_phrase
    phrases_file = File.open PHRASES_FILE
    total_chars = phrases_file.size

    random_location = Random.rand total_chars

    phrases_file.seek random_location, IO::SEEK_SET
    while (first_char = phrases_file.readbyte.chr) != DELIMITER and random_location > 0
      random_location -= 1
      phrases_file.seek random_location, IO::SEEK_SET
    end

    phrase = (first_char == DELIMITER) ? '' : first_char
    while !phrases_file.eof? and (char = phrases_file.readbyte.chr) != DELIMITER
      phrase += char
    end
    phrase.strip
  ensure
    phrases_file.close
  end

  # add phrase to phrases file
  def self.add_phrase(new_phrase)
    phrases_file = File.open PHRASES_FILE, 'a'
    phrases_file.write " #{DELIMITER} #{new_phrase}"
  ensure
    phrases_file.close
  end

  def self.generate_phrases_file
    phrases_file = File.open PHRASES_FILE, 'w'
    phrases_file.write Faker::Lorem.sentence(1, false)

    while phrases_file.size < 2_000_000_000
      text = ''
      1000.times { text += ' | ' + Faker::Lorem.sentence(1, false) }
      phrases_file.write text
    end
  ensure
    phrases_file.close
  end
end
