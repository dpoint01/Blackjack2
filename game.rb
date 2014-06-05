class Deck

  attr_reader :cards

  def initialize
    @cards = populate_deck.shuffle
  end

  def populate_deck
    deck = []
    card_numbers = ['2','3','4','5','6','7','8','9','10','J','Q','K','A']
    suites = ['♦','♣','♠','♥']

    suites.each do |suite|
      card_numbers.each do |card_number|
        deck << Card.new(suite, card_number)
      end
    end

    deck
  end

  def take_card
    @cards.length != 0 ? @cards.shift : nil
  end

end


class Card
  attr_reader :suite, :number, :face, :ace

  def initialize(suite, number)
    @suite = suite
    @number = number
    @face = face?(number)
    @ace = ace?(number)
  end

  def face?(number)
    ['J','Q','K'].include?(number) ? true : false
  end

  def ace?(number)
    number == 'A' ? true : false
  end
end

class Hand
  attr_accessor :hand
  attr_reader :score

  def initialize
    @hand = []
  end

  def score
    score = 0
    ace_count = 0
    hand.each do |card|
      if card.face
        score += 10
      elsif card.ace
        score += 1
        ace_count += 1
      else
        score += card.number.to_i
      end
    end

    ace_count.times do
      if score <= 21
        score += 10
      end
    end
    score
  end

end

def deal_card(hand_obj, game_deck_obj, recipient)
  card = game_deck_obj.take_card
  hand_obj.hand << card
  puts "#{recipient} was dealt #{card.suite} #{card.number}"
end


#--------------------------------MAIN--------------------#
puts "Welcome to Blackjack!"
puts

game_deck = Deck.new
player = Hand.new
dealer = Hand.new

deal_card(player, game_deck, "Player")
deal_card(player, game_deck, "Player")
puts "Player's Score : #{player.score} "
puts



player_done = false
while player_done == false
  print "Do you want to hit or stand? (H/S): "
  input = gets.chomp.upcase
  puts
  if input =="H"
    deal_card(player, game_deck, "Player")
    puts "Player's Score : #{player.score} "
    puts

    if player.score > 21
      player_done = true
    end
  elsif input == "S"
    player_done = true
  else
    print "Please type H or S: "
  end
end

if player.score > 21
  puts "You lose, sucka!"
else


deal_card(dealer, game_deck, "Dealer")
deal_card(dealer, game_deck, "Dealer")
puts "Dealer's Score : #{dealer.score} "
puts

  dealer_done = false
  while dealer_done ==false
    if dealer.score < 17
      deal_card(dealer, game_deck, "Dealer")
      puts "Dealer's Score : #{dealer.score} "
      puts
    else
      dealer_done = true
    end
  end
  if dealer.score > 21 || dealer.score < player.score
    puts "You win, guy!"
  else
    puts "You lose!!!"
  end
end
