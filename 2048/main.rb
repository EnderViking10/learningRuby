require 'io/console'

class Game
  def initialize
    super
    @board = Array.new(4) { Array.new(4) { 0 } }
    @running = true
    new_num
  end

  def run
    while @running
      print_board
      input
    end
  end

  def print_board
    system("cls")
    @board.each do |row|
      row.each do |col|
        print "\033[38;5;16m" if col != 0
        print "\033[48;5;213m" if col == 2
        print "\033[48;5;176m" if col == 4
        print "\033[48;5;139m" if col == 8
        print "\033[48;5;102m" if col == 16
        print "\033[48;5;65m" if col == 32
        print "\033[48;5;28m" if col == 64
        print "\033[48;5;22m" if col == 128
        print "\033[48;5;196m" if col == 256
        print "\033[48;5;160m" if col == 512
        print "\033[48;5;124m" if col == 1024
        print "\033[48;5;88m" if col == 2048
        print "\033[48;5;52m" if col >= 4096
        print sprintf '%5d', col
        print "\033[0m"
      end
      puts puts
    end
  end

  def new_num
    new_number = [rand(4), rand(4)]
    while @board[new_number[0]][new_number[1]] != 0
      new_number = [rand(4), rand(4)]
    end
    @board[new_number[0]][new_number[1]] = rand(1..2) * 2
  end

  def move(direction)
    combined = Array.new(4) { false }
    moved = false

    if direction == 0 # Up
      # Move
      (0..2).each do |index|
        (3).downto(1) do |row|
          (0..3).each do |col|
            next if @board[row][col] == 0
            next if @board[row - 1][col] != 0

            @board[row - 1][col] = @board[row][col]
            @board[row][col] = 0
            moved = true
          end
        end
      end
      # Combine
      (3).downto(1) do |row|
        (0..3).each do |col|
          if combined[row]
            combined[row] = false
            next
          end
          next if @board[row][col] == 0
          next if @board[row][col] != @board[row - 1][col]

          @board[row - 1][col] *= 2
          @board[row][col] = 0
          combined[row] = true
          moved = true
        end
      end
      # Move
      (0..2).each do |index|
        (3).downto(1) do |row|
          (0..3).each do |col|
            next if @board[row][col] == 0
            next if @board[row - 1][col] != 0

            @board[row - 1][col] = @board[row][col]
            @board[row][col] = 0
            moved = true
          end
        end
      end
    elsif direction == 1 # Down
      # Move
      (0..2).each do |index|
        (0..2).each do |row|
          (0..3).each do |col|
            next if @board[row][col] == 0
            next if @board[row + 1][col] != 0

            @board[row + 1][col] = @board[row][col]
            @board[row][col] = 0
            moved = true
          end
        end
      end
      # Combine
      (0..2).each do |row|
        (0..3).each do |col|
          if combined[row]
            combined[row] = false
            next
          end
          next if @board[row][col] == 0
          next if @board[row][col] != @board[row + 1][col]

          @board[row + 1][col] *= 2
          @board[row][col] = 0
          combined[row] = true
          moved = true
        end
      end
      # Move
      (0..2).each do |index|
        (0..2).each do |row|
          (0..3).each do |col|
            next if @board[row][col] == 0
            next if @board[row - 1][col] != 0

            @board[row - 1][col] = @board[row][col]
            @board[row][col] = 0
            moved = true
          end
        end
      end
    elsif direction == 2 # Left
      # Move
      (0..2).each do |index|
        (0..3).each do |row|
          (3).downto(1) do |col|
            next if @board[row][col] == 0
            next if @board[row][col - 1] != 0

            @board[row][col - 1] = @board[row][col]
            @board[row][col] = 0
            moved = true
          end
        end
      end
      # Combine
      (0..3).each do |row|
        (3).downto(1) do |col|
          if combined[row]
            combined[row] = false
            next
          end
          next if @board[row][col] == 0
          next if @board[row][col] != @board[row][col - 1]

          @board[row][col - 1] *= 2
          @board[row][col] = 0
          combined[row] = true
          moved = true
        end
      end
      # Move
      (0..2).each do |index|
        (0..3).each do |row|
          (3).downto(1) do |col|
            next if @board[row][col] == 0
            next if @board[row][col - 1] != 0

            @board[row][col - 1] = @board[row][col]
            @board[row][col] = 0
            moved = true
          end
        end
      end
    elsif direction == 3 # Right
      # Move
      (0..2).each do |index|
        (0..3).each do |row|
          (0..2).each do |col|
            next if @board[row][col] == 0
            next if @board[row][col - 1] != 0

            @board[row][col - 1] = @board[row][col]
            @board[row][col] = 0
            moved = true
          end
        end
      end
      # Combine
      (0..3).each do |row|
        (0..2).each do |col|
          if combined[row]
            combined[row] = false
            next
          end
          next if @board[row][col] == 0
          next if @board[row][col] != @board[row][col + 1]

          @board[row][col + 1] *= 2
          @board[row][col] = 0
          combined[row] = true
          moved = true
        end
      end
      # Move
      (0..2).each do |index|
        (0..3).each do |row|
          (0..2).each do |col|
            next if @board[row][col] == 0
            next if @board[row][col + 1] != 0

            @board[row][col + 1] = @board[row][col]
            @board[row][col] = 0
            moved = true
          end
        end
      end
    end
    new_num if moved
  end

  def input
    user_input = $stdin.getch.bytes
    if user_input[0] == 224 # Arrows
      if user_input[1] == 72 # Up arrow
        move(0)
      elsif user_input[1] == 80 # Down arrow
        move(1)
      elsif user_input[1] == 75 # Left arrow
        move(2)
      elsif user_input[1] == 77 # Right arrow
        move(3)
      end
    elsif user_input[0] == 3 || user_input[0] == 113 # Enter || q
      @running = false
    end
  end
end

class Main
  game = Game.new
  game.run
end
