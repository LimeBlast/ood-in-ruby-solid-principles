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
  let(:action) { FleeAction.new hero }

  it_behaves_like 'actionable'
  it_behaves_like 'action'

  it 'has stealth attribute' do
    expect(action.attribute).to eq :stealth
  end

  it 'has notice for difficulty' do
    expect(action.difficulty).to eq :notice
  end

  describe 'effect' do
    before :each do
      allow(Dicepool).to receive(:new).and_return(dicepool)
    end

    context 'success' do
      it 'sends flee message to the owner' do
        allow(dicepool).to receive(:skill_check).and_return(true)

        expect(hero).to receive(:flee)

        action.activate(monster)
      end
    end
    context 'failure' do
      it 'deals damage to the owner' do
        allow(dicepool).to receive(:skill_check).and_return(false)

        expect(hero).to receive(:damage).with(monster.damage)

        action.activate(monster)
      end
    end
  end

end
