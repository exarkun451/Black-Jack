require 'rubygems'
require 'sinatra'

set :sessions, true

helpers do
	def calculate_total(cards)
		arr = cards.map{|x| x[1]}

		total = 0
		arr.each do |c|
			if c == "Ace"
				total +=11
			else
				total += c.to_i == 0 ? 10 : c.to_i
			end
	end

	arr.select{|x| x == "Ace"}.count.times do
		break if total <= 21
			total -= 10
		end
		total
	end

	def dealer_hit(hand)
		if calculate_total(hand) < 17
			hand << session[:deck].pop
		end
	end
end



before do
	@end_game = false
end

get '/' do
	if session[:player_name]
		redirect '/game'
	else
		redirect '/new_player'
	end
end

get '/new_player' do
	erb :new_player
end

post '/new_player' do
	session[:player_name] = params[:player_name]
	redirect '/game'
end

get '/game' do
	suits = ['Clubs','Spades','Hearts','Diamonds']
	values = ['2','3','4','5','6','7','8','9','10','Jack','Queen','King','Ace']
	session[:deck] = suits.product(values).shuffle!
	session[:dealer_cards] = []
	session[:player_cards] = []
	session[:clubs_images] = []
	session[:computer_images] = []
	2.times do 
		session[:dealer_cards] << session[:deck].pop
		session[:player_cards] << session[:deck].pop
	end
	erb :game
end

post '/game/player/hit' do
	session[:player_cards] << session[:deck].pop
		dealer_hit(session[:dealer_cards])
	if calculate_total(session[:player_cards]) >= 21
		redirect '/end_game'
	else
		erb :game
	end
end


post '/game/player/stay' do
	@success = "You have chosen to stay!"
	redirect '/end_game'
end

post '/game/restart' do
	redirect '/game'
end

post '/game/different_player' do
	erb :new_player
end

post '/game/exit' do

end

get '/end_game' do
	player = calculate_total(session[:player_cards])
	computer = calculate_total(session[:dealer_cards])
	if player > 21
		@error = "You busted. Game over."
	elsif player == 21 && computer == 21
		@success = "Both of you got Black Jack!"
	elsif player == 21 && computer != 21
		@success = "BLACK JACK!!!"
	elsif player != 21 && computer == 21
	  @error = "Dealer got Blackjack..."
	elsif player > 21 && computer <= 21
		@error = "You lose..."
	elsif player <= 21 && computer > 21
		@success = "Dealer busts, you win!!"
	elsif player == computer
		@info = "It looks like it was a tie"
	elsif player > computer
		@success = "You win"
	elsif player < computer
		@error = "You lose..."
	else
		@info = "a strange situation..."
	end
	
	@end_game = true
	erb :game
end












