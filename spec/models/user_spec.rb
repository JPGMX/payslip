require 'rails_helper'
require 'securerandom'

RSpec.describe User, type: :model do
  let (:user) { User.new }
  subject { user }

  context 'class methods' do
    context '#self.import' do
      it 'raises a Exception when no file is provided' do
        params={}
        expect {User.import(params )}.to raise_exception
      end
    end
    context '#self.validate values' do
      it 'returns 0 if parameter is a string' do
        val='twenty3'
        expect(User.calculate_gross_income(val)).to eq(0)
      end
      it 'returns result with a number as string' do
        random_value="$#{rand(999)},#{rand(999)}"
        expect(User.calculate_gross_income(random_value)).to be_kind_of(Float)
      end
      it 'returns 0 if parameter is other than String or number' do
        expect(User.calculate_gross_income(true)).to eq(0)
      end

    end
  end
end
