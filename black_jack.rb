#player over 21 forces winning
#query for game repeat
#multiplayer
class Black_Jack
	puts "Welcome to Blackjack!"
def initialize name
	@name = name
	card_suits = ['Clubs','Spades','Diamonds','Hearts']
	card_values = ['2','3','4','5','6','7','8','9','10','Jack','Queen','King','Ace']
	@deck = card_suits.product(card_values)
	@player = []
	@computer = []
	@deck.shuffle!
	@total = 0
	2.times do 
		@player << @deck.pop
		@computer << @deck.pop
	end
	puts "#{@name}, you were dealt: "
	show @player
end

def next_move (response)
		if response == 1
			hit @player
			dealer_turn @computer
		elsif response == 2
			show @player
		elsif response == 3
			opponent_hand @computer
		elsif response == 4
			calculate_winner(@player, @computer)
		else
			puts "Oops!"
			puts "Press 1 ..... Hit" 
			puts "Press 2...... Your current hand!"
			puts "Press 3...... See the competition!"
			puts "Press 4...... Show your cards!"
		end
end

def hit (hand)
	hand << @deck.pop
	dealt_card = hand[-1]
	puts "#{@name}, you were dealt a #{dealt_card[1]} of #{dealt_card[0]}"
end

def show(hand)
	hand.each do |suit, value|
		puts "#{value} of #{suit}"
	end
end

def opponent_hand (hand)
	first_card = hand[0]
	puts "You see: a #{first_card[1]} of #{first_card[0]}"
	other_cards = hand.length - 1
	puts "and #{other_cards} facedown"
end

def calculate (hand)
	total = 0
	arr = hand.map{|x| x[1]}
	arr.each do |value|
		if value == "Ace"
			total +=11
		elsif value.to_i == 0
			total +=10
		else
			total += value.to_i
		end
	end

		arr.select {|x| x == "Ace"}.count.times do
			total -=10 if total > 21
		end
		@total = total
end

def dealer_turn (hand)
	calculate hand
	if @total < 17
		@computer << @deck.pop
	end
end

def calculate_winner(player, computer)
	win = "YOU WIN!!!"
	lose = "Unfortunately, the computer beat you!"
	tie = "Dang, a tie!"
	player_total = calculate player
	computer_total = calculate computer
	puts
	puts
	puts "Dealers hand was" 
	show computer
	puts "For a total of #{computer_total}"
	puts
	puts
	puts "Your hand was" 
	show player
	puts "For a total of #{player_total}"
	if player_total == 21 && computer_total == 21
		puts tie + "... and both of you got Black Jack!"
	elsif player_total == 21 && computer_total != 21
		puts win 
	elsif player_total != 21 && computer_total == 21
	  puts lose
	elsif player_total > 21 && computer_total <= 21
		puts lose
	elsif player_total <= 21 && computer_total > 21
		puts win
	elsif player_total == computer_total
		puts tie
	elsif player_total > computer_total
		puts win
	elsif player_total < computer_total
		puts lose
	else
		puts "a strange situation..."
	end
end
end


puts "Welcome to Black Jack!"
puts "Please enter your name!"
name = gets.chomp
while true
	game = Black_Jack.new "#{name}"
	while true
		puts "What is your next move #{name}?"
		puts "Press 1 ..... Hit" 
		puts "Press 2...... Your current hand!"
		puts "Press 3...... See the competition!"
		puts "Press 4...... Show your cards!"
		response = gets.chomp.to_i
		game.next_move(response)
		if response.to_i == 4
			break
		end
	end
	puts "Would you like to play again?(Y/N)"
		response = gets.chomp
	if response.downcase == 'n'
		puts "Thanks for playing!"
		break
end
end
