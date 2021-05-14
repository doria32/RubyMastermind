module Interface
    def welcome()
        puts ""
        puts "MASTERMIND"
        puts ""
        puts "Your goal is to find out the combination of the 4 cells"
        puts ""
    end
    def create_guess(color)
        case color
        when "blue"
            cell = Cell.new
            cell.color = "blue"
            cell.initial = "B"
        when "yellow"
            cell = Cell.new
            cell.color = "yellow"
            cell.initial = "Y"
        when "purple"
            cell = Cell.new
            cell.color = "purple"
            cell.initial = "P"
        when "red"
            cell = Cell.new
            cell.color = "red"
            cell.initial = "R"
        when "green"
            cell = Cell.new
            cell.color = "green"
            cell.initial = "G"
        when "white"
            cell = Cell.new
            cell.color = "white"
            cell.initial = "W"
        else
        puts "you didn't enter a correct value, try again"    
        end
        cell
    end
end

class Code
    #Code create an array of Cells in a random order with random colors (not repeatable)
    attr_accessor :arrayCode
    def initialize()
        @arrayCode = []
        for i in 0..3 do
            @arrayCode[i] = Cell.new()
        end
    end
    def print_code()
        for i in 0..3 do
            puts "|#{@arrayCode[i].initial}|"
        end
    end    
end

class Cell
    #the Cell can have a color (and a position?)
    attr_accessor :color, :initial
    def initialize()
        @color = rand(1...6)
        @initial = ""
        case @color
        when 1
            @color = "blue"
            @initial = "B" 
        when 2
            @color = "red"
            @initial = "R"
        when 3
            @color = "green"
            @initial = "G"
        when 4
            @color = "yellow"
            @initial = "Y"
        when 5
            @color = "purple"
            @initial = "P"
        when 6
            @color = "white"
            @initial = "W"
        end
    end
end

class Match
    include Interface
    def computer_play
        welcome()
        codex = Code.new
        puts ""
        winner = false
        turns = 0
        for i in 0..3 do
            color = ""
            puts ""
            puts "The computer will try and guess your code!"
            puts "What's the color in the cell number #{i + 1}?"
            puts "Choose between blue, red, green, yellow, purple, white."
            puts ""
            while ((color != "blue") && (color != "green") && (color != "yellow") && (color != "white") && (color != "purple") && (color != "red")) 
                color = gets.chomp
                guessCell = create_guess(color)
                codex.arrayCode[i] = guessCell
            end
        end
        codex.print_code
        while ((winner == false) && (turns != 9))
            guess = Code.new
            correctColor = 0
            correctGuess = 0
            for i in 0..3 do
                if [codex.arrayCode[0].color, codex.arrayCode[1].color, codex.arrayCode[2].color, codex.arrayCode[3].color].any?(guess.arrayCode[i].color)
                    correctColor += 1
                end
                for j in 0..3 do
                    if guess.arrayCode[i].color == codex.arrayCode[j].color
                        if i == j
                            correctGuess += 1
                        end
                    end
                end
            end
            puts ""
            puts "#{correctGuess} are in the correct color and position"
            puts "#{(correctColor - correctGuess)} color are correct but not in the correct position"
            puts ""
            if correctGuess == 4
                winner = true
                puts "The guess was correct! I WON!"
            end
            if turns == 8
                puts "I didn't find the combination in time, you WON!"
            end
            turns += 1
        end
    end 
    
    def play
        welcome()
        codex = Code.new
        codex.print_code
        puts ""
        guess = Code.new
        winner = false
        turns = 0
        while ((winner == false) && (turns != 9))
            for i in 0..3 do
                color = ""
                puts ""
                puts "What's the color in the cell number #{i + 1}?"
                puts "Choose between blue, red, green, yellow, purple, white."
                puts ""
                while ((color != "blue") && (color != "green") && (color != "yellow") && (color != "white") && (color != "purple") && (color != "red")) 
                    color = gets.chomp
                    guessCell = create_guess(color)
                    guess.arrayCode[i] = guessCell
                end
            end
            guess.print_code
            correctColor = 0
            correctGuess = 0
            for i in 0..3 do
                if [codex.arrayCode[0].color, codex.arrayCode[1].color, codex.arrayCode[2].color, codex.arrayCode[3].color].any?(guess.arrayCode[i].color)
                    correctColor += 1
                end
                for j in 0..3 do
                    if guess.arrayCode[i].color == codex.arrayCode[j].color
                        if i == j
                            correctGuess += 1
                        end
                    end
                end
            end
            puts ""
            puts "#{correctGuess} are in the correct color and position"
            puts "#{(correctColor - correctGuess)} color are correct but not in the correct position"
            puts ""
            if correctGuess == 4
                winner = true
                puts "The guess was correct! you WON!"
            end
            if turns == 8
                puts "You didn't find the combination in time, you LOST!"
            end
            turns += 1
        end
    end
end

game = Match.new
game.computer_play
