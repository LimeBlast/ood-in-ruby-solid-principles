require 'spec_helper'
require_relative '../../lib/hero'
require_relative '../../lib/monster'
require_relative '../../lib/attack_action'
require_relative '../../lib/flee_action'
require_relative '../../lib/dicepool'

describe 'Battle' do
  let(:hero) { Hero.new strength: 5,
                        health:   10,
                        actions:  {
                            attack: AttackAction.new,
                            flee:   FleeAction.new
                        } }
  let(:monster) { Monster.new toughness: 5,
                              notice:    10,
                              damage:    4,
                              exp:       10,
                              gold:      20 }
  let(:dicepool) { Dicepool.new }

  describe 'Hero attacks monster' do
    context 'successful attack' do
      before :each do
        allow(dicepool).to receive(:roll_die).and_return(5)
        allow(Dicepool).to receive(:new).and_return(dicepool)
        hero.activate_action :attack, monster
      end
      it 'kills monster' do
        expect(monster).to be_dead
      end
      it "gets monster's gold"
      it 'gets experience'
    end
    context 'failed attack' do
      it 'takes damage'
    end
  end

  describe 'Hero flees from monster' do
    context 'successful attempt' do
      it 'fled'
    end
    context 'failed attempt' do
      it 'took damage'
    end
  end
end
