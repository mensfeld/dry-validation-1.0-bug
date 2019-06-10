require 'dry-validation'

class Config < Dry::Validation::Contract
  params do
    required(:kafka).schema do
      required(:seed_brokers).filled(:array).each(:str?)
    end
  end
end

RSpec.describe Config do
  let(:schema) { described_class.new }
  let(:config) do
    {
      kafka: {
        seed_brokers: %w[kafka://127.0.0.1:9092],
      }
    }
  end

  context 'when seed_brokers are empty' do
    before { config[:kafka][:seed_brokers] = [] }

    it { expect(schema.call(config)).not_to be_success }
  end
end
