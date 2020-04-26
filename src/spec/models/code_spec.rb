require 'rails_helper'

RSpec.describe Code do
  describe '#valid?' do
    context 'with valid code' do
      subject { Code.new('def foo; end') }
      it { is_expected.to be_valid }
    end

    context 'with invalid code' do
      subject { Code.new('def foo@bar; end') }
      it { is_expected.not_to be_valid }
    end
  end

  describe '#functions' do
    context 'with empty code' do
      subject { Code.new(nil) }
      it 'will be empty' do
        expect(subject.functions).to be_empty
      end
    end
    context 'without any functions' do
      subject { Code.new('puts "hello world"') }
      it 'will be empty' do
        expect(subject.functions).to be_empty
      end
    end

    context 'with one function' do
      subject { Code.new('def foo; end') }
      it 'will be foo' do
        expect(subject.functions).to eq ['foo']
      end
    end

    context 'with more than one function' do
      subject { Code.new("def foo; end\ndef bar; end") }
      it 'will have all functions names' do
        expect(subject.functions).to eq %w[foo bar]
      end
    end
  end
end
