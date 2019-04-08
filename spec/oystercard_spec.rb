require 'oystercard'

RSpec.describe Oystercard do

  it "initializes card with default balance" do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do
    it "increments the balance" do
      amount = 10
       expect { subject.top_up(amount) }.to change { subject.balance }.from(0).to(10)
    end

    it "prevents top_up to go over the limit" do
      amount = 100
      LIMIT = 90
      expect { subject.top_up(amount)}.to raise_error("Cannot add #{amount} to card. #{LIMIT} maximum limit exceeded")
    end
  end

  describe "#deduct" do
    it "deducts fare from balance" do
      subject.top_up(20)
      fare = 10
      expect {subject.deduct(fare)}.to change { subject.balance }.from(20).to(10)
    end
  end

  describe "#state" do
    it "evaluates the state of the card" do
      expect(subject.state).to eq false
    end
  end

  describe "#touch_in" do
    it "begins the journey" do
      expect { subject.touch_in }.to change { subject.state}.from(false).to(true)
    end
  end

  describe "#touch_out" do
    it "ends the journey" do
      subject.touch_in
      expect { subject.touch_out }.to change { subject.state}.from(true).to(false)
    end
  end

  describe "#in_journey" do
    it "tests if in_journey" do
      expect(subject.in_journey?).to be false
      subject.touch_in
      expect(subject.in_journey?).to be true
    end
  end
end
