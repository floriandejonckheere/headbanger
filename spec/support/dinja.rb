# frozen_string_literal: true

def dinja_mock!(key, *args, &block)
  # rubocop:disable RSpec/AnyInstance
  allow_any_instance_of(Dinja::Container)
    .to receive(:resolve)
    .and_call_original
  # rubocop:enable RSpec/AnyInstance

  allow_any_instance_of(Dinja::Container)
    .to receive(:resolve)
    .with(key, *args)
    .and_return block.call
end
