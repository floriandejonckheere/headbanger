# frozen_string_literal: true

RSpec.describe String do
  describe "#sanitize" do
    it "sanitizes the string" do
      expect("<strong>test</strong>".sanitize).to eq "test"
    end
  end
end
