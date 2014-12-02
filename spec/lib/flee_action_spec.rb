require 'spec_helper'
require_relative '../../lib/flee_action'

describe FleeAction do
  let(:hero) { double('hero',
                      gain_exp:  nil,
                      gain_gold: nil,
                      damage:    nil,
                      stealth:   3) }
  let(:dicepool) { double('dicepool') }
  let(:monster) { double('monster',
                         kill:   nil,
                         damage: 4,
                         notice: 2) }
  let(:action) { FleeAction.new hero, dicepool }

  describe 'effect' do
  end

  describe 'activate' do
    it 'makes stealth check against target notice' do
      expect(dicepool).to receive(:skill_check).with(hero.stealth, monster.notice)
      action.activate(monster)
    end
  end

  it 'responds to activate message' do
    expect(action).to respond_to(:activate)
  end
  it 'has an owner' do
    expect(action.owner).to eq hero
  end
end
