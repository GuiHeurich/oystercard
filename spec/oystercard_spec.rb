
require 'oystercard'

class Oystercard
  public :deduct
end

describe Oystercard do

  let(:station) { double :station }

  it 'checks card balance is zero' do
    expect(subject.balance).to eq (0)
  end

  it "checks that there are no recorded journeys by default" do
    expect(subject.list_of_journeys).to be_empty
  end

  it "checks that touch_in and touch_out create one journey" do
    subject.top_up(30)
    subject.touch_in(station)
    subject.touch_out(station)
    expect(subject.list_of_journeys).not_to be_empty
  end

describe "#top_up" do

  it " can top up the balance" do
    expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
  end

  it "raises an error if card balance is more then 90" do
    subject.top_up(Oystercard::MAXIMUM_BALANCE)
    expect { subject.top_up(1) }.to raise_error "Maximum balance of #{Oystercard::MAXIMUM_BALANCE} exceeded"
  end
end

describe "#deduct" do

  it 'deducts an amount from the balance' do
    subject.top_up(20)
    expect{ subject.deduct 1}.to change{ subject.balance }.by -1
  end

end

describe "#in_journey" do

  it 'it starts not in a journey' do
    expect(subject).not_to be_in_journey
  end
end

describe "#touch_in" do

  it "can touch in" do
    subject.top_up(Oystercard::MINIMUM_BALANCE)
    subject.touch_in(station)
    expect(subject).to be_in_journey
 end

 it "raises an error if card balance is less then 1" do
   subject.top_up(0)
   expect{ subject.touch_in(station) }.to raise_error "you have less then #{Oystercard::MINIMUM_BALANCE}, please top up"
 end

 it "remembers the station where touched in" do
   subject.top_up(25)
   subject.touch_in(station)
   expect(subject.entry_station).to eq (station)
 end
end

describe "#touch_out" do

  it "can touch out" do
    subject.top_up(Oystercard::MINIMUM_BALANCE)
    subject.touch_out(station)
    expect(subject).not_to be_in_journey
end

  it "deducts fare value from balance" do
    subject.top_up(10)
    expect { subject.touch_out(station) }.to change { subject.balance }.by -2
  end
end

end
