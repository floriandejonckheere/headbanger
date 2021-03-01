# frozen_string_literal: true

def dinja_mock!(key, *args, &block)
  allow_any_instance_of(Dinja::Container)
    .to receive(:resolve)
    .and_call_original

  allow_any_instance_of(Dinja::Container)
    .to receive(:resolve)
    .with(key, *args)
    .and_return block.call
end
