require "paint"
require "terminal-table"

class Progress
  def initialize(current_progress, max, celcius, farenheit)
    @current_progress = current_progress
    @max = max
    @celcius = celcius
    @farenheit = farenheit
  end

  attr_accessor :current_progress, :max, :celcius, :farenheit

  def increase
    @current_progress +=1
  end

  def day_change(current_day)
    @days = ["Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday"]
    @days.at(current_day)
  end

  def question
    system 'clear'
      i = 0
    while @current_progress < 7 do
      puts "Welcome to Patrick's weather thingy!"
      puts "\nDay #{@current_progress}/#{@max}"
      puts "What was the temperature on #{day_change(i)} (in celcius)?"
      celcius = gets.chomp
      #updates the celcius colours
      updated_celcius = evaluate(celcius)
      #converts celcius to f and colours too
      updated_farenheit = convert(celcius)
      #pushes the value from the above methods to an array for both c and f
      @celcius.push(updated_celcius)
      @farenheit.push(updated_farenheit)
      #runs the counter method to increase counter by 1
      increase
      #changes the new index of the day of the week array to the next day
      day_change(i)
      #increases the counter for the index of the day counter array
      i += 1
      system 'clear'
    end
    output
  end

  #if the celcius degrees are less than 30, then colour will be blue.
  #30 < celcius < 40 colour will be red
  # celcius >= 40 will be red and blinking
  def evaluate(celcius)
    if celcius.to_i < 30
      celcius = Paint[celcius, :blue]
    elsif celcius.to_i >= 40
      celcius = Paint[celcius, :red, :blink]
    else
      celcius = Paint[celcius, :red]
    end
  end

  #converts celcius to farenheit
  #if the celcius degrees are less than 86, then colour will be blue.
  #86 < celcius < 104 colour will be red
  # celcius >= 104 will be red and blinking
  def convert(celcius)
    farenheit = ((celcius.to_f * 9 / 5) + 32)
    if farenheit.to_f < 86
      farenheit = Paint[farenheit, :blue]
    elsif farenheit.to_i >= 104
      farenheit = Paint[farenheit, :red, :blink]
    else
      farenheit = Paint[farenheit, :red]
    end
  end

  def output
    #Adds titles to the start of each array - IGNORE THIS = realised terminal table can do it
    # @days.unshift("Day")
    # @celcius.unshift("Celcius")
    # @farenheit.unshift("Farenheit")
    #Creates and array of an arrays to print the arrays (days, C, F) into a column each.
    j = 0
    rows = []
    while j < 7 do
      rows << [@days.at(j), @celcius.at(j), @farenheit.at(j)]
      j +=1
    end
    table = Terminal::Table.new :title => Paint["Patrick's Temp Thingy!!", Paint.random, :blink], :headings => ['Day', 'Deg (Celcius)', 'Deg (Farenheit)'], :rows => rows
    puts table
  end

end
