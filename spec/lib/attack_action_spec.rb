require 'spec_helper'
require_relative '../../lib/attack_action'

describe AttackAction do
  let(:hero) { double('hero',
                      strength:  3,
                      gain_exp:  nil,
                      gain_gold: nil,
                      damage:    nil) }
  let(:dicepool) { double('dicepool') }
  let(:monster) { double('monster',
                         toughness: 2,
                         kill:      nil,
                         damage:    4,
                         exp:       10,
                         gold:      20) }
  let(:action) { AttackAction.new hero }

  it_behaves_like 'actionable'
  it_behaves_like 'action'

  it 'has strength attribute' do
    expect(action.attribute).to eq :strength
  end

  it 'has toughness for difficulty' do
    expect(action.difficulty).to eq :toughness
  end

  describe 'effect' do
    before :each do
      allow(Dicepool).to receive(:new).and_return(dicepool)
    end

    context 'success' do
      before :each do
        allow(dicepool).to receive(:skill_check).and_return(true)
      end

      it 'kills monster' do
        expect(monster).to receive(:kill)

        action.activate(monster)
      end
      it 'rewards owner with exp' do
        expect(hero).to receive(:gain_exp)

        action.activate(monster)
      end
      it 'rewards owner with gold' do
        expect(hero).to receive(:gain_gold)

        action.activate(monster)
      end
    end
    context 'failure' do
      it 'damages owner' do
        allow(dicepool).to receive(:skill_check).and_return(false)

        expect(hero).to receive(:damage).with(monster.damage)

        action.activate(monster)
      end
    end
  end
end
