class Oystercard
MAXIMUM_BALANCE = 90
MINIMUM_BALANCE = 1
FARE = 2
  attr_reader :balance, :entry_station, :list_of_journeys, :exit_station

 def initialize
   @balance = 0
   @entry_station = nil
   @exit_station = nil
   @list_of_journeys = {}
 end

def top_up(value)
  raise "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if @balance + value > MAXIMUM_BALANCE
  @balance += value
end

def in_journey?
  !!@entry_station
end

def touch_in(station)
  raise "you have less then #{MINIMUM_BALANCE}, please top up" if @balance < MINIMUM_BALANCE
  @entry_station = station
end

def touch_out(station)
  deduct(FARE)
  @exit_station = station
  @list_of_journeys[@entry_station] = @exit_station
end

private
def deduct(value)
  @balance -= value
end

end
