require 'io/console'

class Game
  def initialize
    super
    @running = true
    @board = Array.new(3) { Array.new(3) { ' ' } }
    @cursor = Array.new(2, 0)
    @turn = 'X'
  end

  def run
    while @running do
      print_board
      input
      if has_won
        print_board
        if @turn == 'X'
          @turn = 'O'
        elsif @turn == 'O'
          @turn = 'X'
        end
        puts "#{@turn} has won!"
        @running = false
      end
    end
  end

  def has_won
    @board.each { |row|
      if row[0] == row[1] && row[1] == row[2] && row[0] != ' '
        return true
      end
    }
    (0..2).each { |col|
      if @board[0][col] == @board[1][col] && @board[1][col] == @board[2][col] && @board[0][col] != ' '
        return true
      end
    }
    if (@board[0][0] == @board[1][1] && @board[1][1] == @board[2][2] ||
      @board[0][2] == @board[1][1] && @board[1][1] == @board[2][0]) && @board[1][1] != ' '
      return true
    end
    false
  end

  def print_board
    system("cls")
    @board.each_with_index { |row, row_index|
      row.each_with_index { |col, col_index|
        if row_index == @cursor[0] && col_index == @cursor[1]
          print "["
        else
          print " "
        end
        print col
        if row_index == @cursor[0] && col_index == @cursor[1]
          print "]"
        else
          print " "
        end
        if col_index < 2
          print "|"
        end
      }
      puts
    }
  end

  def select
    if @board[@cursor[0]][@cursor[1]] == ' '
      @board[@cursor[0]][@cursor[1]] = @turn
      if @turn == 'X'
        @turn = 'O'
      elsif @turn == 'O'
        @turn = 'X'
      end
    end
  end

  def input
    user_input = $stdin.getch.bytes
    if user_input[0] == 224 # Arrow
      if user_input[1] == 72 # Up arrow
        @cursor[0] -= 1 if @cursor[0] > 0
      elsif user_input[1] == 80 # Down arrow
        @cursor[0] += 1 if @cursor[0] < 2
      elsif user_input[1] == 75 # Left arrow
        @cursor[1] -= 1 if @cursor[1] > 0
      elsif user_input[1] == 77 # Right arrow
        @cursor[1] += 1 if @cursor[1] < 2
      end
    elsif user_input[0] == 13 # Enter
      select
    elsif user_input[0] == 3 || user_input[0] == 113 # Ctrl-c || q
      @running = false
    end
  end
end

class Main
  game = Game.new
  game.run
end
