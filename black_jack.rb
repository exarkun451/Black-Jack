class Black_Jack
def initialize name
	card_suits = ['Clubs','Spades','Diamonds','Hearts']
	card_values = ['2','3','4','5','6','7','8','9','10','Jack','Queen','King','Ace']
	@@deck = card_suits.product(card_values)
	@@deck.shuffle!
	@@computer = []
	2.times {@@computer << @@deck.pop}
	@name = name
	@player = []
	@computer = []
	@total = 0
	2.times do 
		@player << @@deck.pop
	end
	puts "#{@name}, you were dealt: "
	show_player
end

def options
		puts "What is your next move #{@name}?"
		puts "Press 1 ..... Hit" 
		puts "Press 2...... Your current hand!"
		puts "Press 3...... See the competition!"
		puts "Press 4...... Show your cards!"
		puts "Press 5...... Pass your turn"
end

def error
		puts "Oops!"
		puts "Press 1 ..... Hit" 
		puts "Press 2...... Your current hand!"
		puts "Press 3...... See the competition!"
		puts "Press 4...... Show your cards!"
		puts "Press 5...... Pass your turn!"
end

def hit
	total = calculate (@player)
	if total < 21
		@player << @@deck.pop
		dealt_card = @player[-1]
		puts "#{@name}, you were dealt a #{dealt_card[1]} of #{dealt_card[0]}"
	else
		puts "I'm sorry! But I can't let you keep hitting. You already have #{total}"
	end
end

def show_player
	puts "Your current cards are:"
	@player.each do |suit, value|
		puts "#{value} of #{suit}"
	end
end

def opponent_hand
	first_card = @@computer[0]
	puts "You see: a #{first_card[1]} of #{first_card[0]}"
	other_cards = @@computer.length - 1
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

def pass
	puts "You pass your turn..."
end

def dealer_turn
	calculate @@computer
	if @total < 17
		puts "... Dealer hits!"
		@@computer << @@deck.pop
	end
end

def calculate_winner
	win = "YOU WIN!!!"
	lose = "Unfortunately, the computer beat you!"
	tie = "Dang, a tie!"
	player_total = calculate @player
	computer_total = calculate @@computer
	puts
	puts "------SCOREBOARD------"
	puts 
	puts "Dealers hand was:" 
		@@computer.each do |suit, value|
		puts "#{value} of #{suit}"
	end
	puts "For a total of: #{computer_total}"
	puts
	puts
	puts "Your hand was:" 
	@player.each do |suit, value|
		puts "#{value} of #{suit}"
	end
	puts "For a total of: #{player_total}"
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

def end?
	while true
	puts "Would you like to play again?(Y/N)"
		response = gets.chomp
	if response.downcase == 'n'
		puts "Thanks for playing!"
		exit
	elsif response.downcase == 'y'
		puts "Will the same person be playing?(Y/N)"
		response = gets.chomp
		if response.downcase == 'y'
			initialize(@name)
			break
		elsif response.downcase == 'n'
			puts "Well then, welcome to Black Jack!"
			puts "Please enter the new person to be playing!"
			response = gets.chomp
			initialize(response)
			break
		else
			puts "Oops! I don't understand you."
		end
	else
		puts "Oops! I don't understand you."
	end
	end
end
end


puts "Welcome to Black Jack!"
puts "Please enter your name!"
player = gets.chomp
game = Black_Jack.new player
while true
	game.options
	response = gets.chomp.to_i
	case response
	when 1
		game.hit
		game.dealer_turn
	when 2
		game.show_player
	when 3
		game.opponent_hand
	when 4
		game.calculate_winner
		game.end?
	when 5
		game.pass
		game.dealer_turn
	else
		game.error
	end
end
