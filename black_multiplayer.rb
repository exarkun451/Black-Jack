class Multiplayer
	def initialize players
		card_suits = ['Clubs','Spades','Diamonds','Hearts']
		card_values = ['2','3','4','5','6','7','8','9','10','Jack','Queen','King','Ace']
		@@deck = card_suits.product(card_values)
		@@deck.shuffle!
		@@computer_total = 0
		@number = players
		@player1_game = 0
		@player2_game = 0
		@player3_game = 0
		@player3_game = 0
		end

	def get_players
		@computer_game = Black_Jack.new "Dealer"
		if @number == 1
			puts "Please enter the name of the player"
			new_name = gets.chomp
			@player1_game = Black_Jack.new new_name
			@player1_game.initial_show
		end
		if @number > 1
			puts "Please enter the first player"
			new_name = gets.chomp
			@player1_game = Black_Jack.new new_name
			@player1_game.initial_show
		end
		if @number >= 2
			puts "Please enter the second player"
			new_name = gets.chomp
			@player2_game = Black_Jack.new new_name
			@player2_game.initial_show
		end
		if @number >= 3
			puts "Please enter the third player"
			new_name = gets.chomp
			@player3_game = Black_Jack.new new_name
			@player3_game.initial_show
		end
		if @number >= 4
			puts "Please enter the fourth player"
			new_name = gets.chomp
			@player4_game = Black_Jack.new new_name
			@player4_game.initial_show
		end
	end

	def which_round?
		if @number == 1
			@computer_game.dealer_turn
			@player1_game.next_move
		elsif @number == 2
			@computer_game.dealer_turn
			@player1_game.next_move
			@player2_game.next_move
		elsif @number == 3
			@computer_game.dealer_turn
			@player1_game.next_move
			@player2_game.next_move
			@player3_game.next_move
		elsif @number == 4
			@computer_game.dealer_turn
			@player1_game.next_move
			@player2_game.next_move
			@player3_game.next_move
			@player4_game.next_move
		else
			puts "oops! Something went very wrong. Try again."
			exit
	end
	end

	def all_complete?
		if @number == 1
			if @player1_game.game_finished == true
				@computer_game.display_computer_total
				@player1_game.calculate_winner
				end?
			end
		elsif @number == 2
			if @player1_game.game_finished == true && @player2_game.game_finished == true
				@computer_game.display_computer_total
				@player1_game.calculate_winner
				@player2_game.calculate_winner
				end?
			end
		elsif @number == 3
			if @player1_game.game_finished == true && @player2_game.game_finished == true ;
				@player3_game.game_finished == true
				@computer_game.display_computer_total
				@player1_game.calculate_winner
				@player2_game.calculate_winner
				@player3_game.calculate_winner
				end?
			end
		elsif @number == 4
			if @player1_game.game_finished == true && @player2_game.game_finished == true ;
				@player3_game.game_finished == true && @player4_game.game_finished == true
				@computer_game.display_computer_total
				@player1_game.calculate_winner
				@player2_game.calculate_winner
				@player3_game.calculate_winner
				@player4_game.calculate_winner
				end?
			end
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
		puts "How many people are playing? Enter 1-4"
		player_num = gets.chomp
		initialize(player_num.to_i)
		get_players
			break
		else
			puts "Oops! I don't understand you."
		end
	end
end
end






class Black_Jack < Multiplayer
def initialize name
	@name = name
	@player = []
	@skip = false
	@game_finished = false
	@total = 0
	2.times do 
		@player << @@deck.pop
	end
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
	total = calculate(@player)
	if total < 21
		@player << @@deck.pop
		dealt_card = @player[-1]
		puts "#{@name}, you were dealt a #{dealt_card[1]} of #{dealt_card[0]}"
	else
		puts "I'm sorry! But I can't let you keep hitting. You already have #{total}"
	end
end

def initial_show
		puts "#{@name}, you were dealt: "
		@player.each do |suit, value|
		puts "#{value} of #{suit}"
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
	calculate @player
	if @total < 17
		puts "... Dealer hits!"
		@player << @@deck.pop
	end
end

def next_move
		if @skip == false
		while true
			puts options
			response = gets.chomp.to_i
			case response
			when 1
				hit
				dealer_turn
				break
			when 2
				show_player
			when 3
				opponent_hand
			when 4
				@skip = true
				game_finished
				break
			when 5
				pass
				dealer_turn
				break
			else
				error
			end
		end
	end
end

##When player selects show cards, his turn is skipped and his game is finished.
def game_finished
	if @skip == true
  	@game_finished = true
  end
end

def display_computer_total
	computer_total = calculate @player
	@@computer_total = computer_total
	puts
	puts "------SCOREBOARD------"
	puts 
	puts "#{@name}s hand was:" 
		@player.each do |suit, value|
		print "|#{value} of #{suit}|  "
	end
	puts "For a total of: #{computer_total}"
	puts
	puts
end

def calculate_winner
	win = "YOU WIN!!!"
	lose = "Unfortunately, the computer beat you!"
	tie = "Dang, a tie!"
	player_total = calculate @player
	computer_total = @@computer_total
	puts
	puts "#{@name}, your hand was:" 
	@player.each do |suit, value|
		print "|#{value} of #{suit}|  "
	end
	puts "For a total of: #{player_total}"
	if player_total == 21 && computer_total == 21
		puts tie + "... and both of you got Black Jack!"
	elsif player_total == 21 && computer_total != 21
		puts win + "BLACK JACK!!!"
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
puts "How many people are playing? Enter 1-4"
player_num = gets.chomp
board = Multiplayer.new player_num.to_i
board.get_players
while true
	board.which_round?
	board.all_complete?
end
