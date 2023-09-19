class Main
  running = true
  wins = 0
  losses = 0

  while running
    user_move = gets.chomp.downcase
    until user_move == 'r' || user_move == 'p' || user_move == 's' do
      puts "#{user_move} is not a valid input"
      user_move = gets.chomp.downcase
    end

    computer_move = %w[r p s].sample

    if computer_move == user_move
      puts "You have tied. :|"
    elsif computer_move == 'r' && user_move == 's' ||
      computer_move == 'p' && user_move == 'r' ||
      computer_move == 's' && user_move == 'p'
      puts "You have lost. :("
      losses += 1
    elsif user_move == 'r' && computer_move == 's' ||
      user_move == 'p' && computer_move == 'r' ||
      user_move == 's' && computer_move == 'p'
      puts "You have won. :)"
      wins += 1
    end
    puts "Wins: #{wins}"
    puts "Losses: #{losses}"

    puts "Would you like to play again? (y/n)"
    input = gets.chomp.downcase
    until input == "y" || input == "n" do
      puts "#{input} is not a valid option"
      input = gets.chomp.downcase
    end

    if input == "n"
      break
    end
  end
end
