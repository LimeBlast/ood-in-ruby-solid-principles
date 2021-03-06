require 'spec_helper'
require_relative '../../lib/actionable'

class TestAction
  include Actionable

  def action_attributes
    @attribute  = :strength
    @difficulty = :toughness
  end
end

describe Actionable do
  let(:hero) { double('hero',
                      strength:  3,
                      gain_exp:  nil,
                      gain_gold: nil,
                      damage:    nil) }
  let(:dicepool) { double('dicepool') }
  let(:monster) { double('monster',
                         toughness: 2,
                         kill:      nil,
                         damage:    4) }
  let(:action) { TestAction.new hero }

  it_behaves_like 'actionable'
  it_behaves_like 'action'

  it 'requires action attributes to be implemented' do
    expect { Action.new hero }.to raise_exception
  end

  describe 'activate' do
    before :each do
      allow(Dicepool).to receive(:new).and_return(dicepool)
    end

    it 'sends success message if skill check is successful' do
      allow(dicepool).to receive(:skill_check).and_return(true)
      expect(action).to receive(:success)
      action.activate(monster)
    end
    it 'sends failure message if skill check is not successful' do
      allow(dicepool).to receive(:skill_check).and_return(false)
      expect(action).to receive(:failure)
      action.activate(monster)
    end
  end
end
