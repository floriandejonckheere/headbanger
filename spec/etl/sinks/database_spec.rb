# frozen_string_literal: true

RSpec.describe Sinks::Database do
  subject(:sink) { described_class.new }

  it "persists an artist" do
    attributes = build(:artist).attributes.except("id", "metal_archives_key", "synced_at")

    data = {
      type: "artist",
      metal_archives_key: "metal_archives_key",
      attributes: attributes,
    }

    sink.run(data)

    artist = Artist.find_by!(metal_archives_key: "metal_archives_key")

    expect(artist.name).to eq attributes.fetch("name")
  end

  it "persists a group" do
    attributes = build(:group).attributes.except("id", "metal_archives_key", "synced_at")

    data = {
      type: "group",
      metal_archives_key: "metal_archives_key",
      attributes: attributes,
    }

    sink.run(data)

    group = Group.find_by!(metal_archives_key: "metal_archives_key")

    expect(group.name).to eq attributes.fetch("name")
  end

  it "persists a release" do
    attributes = build(:release).attributes.except("id", "metal_archives_key", "synced_at")

    data = {
      type: "release",
      metal_archives_key: "metal_archives_key",
      attributes: attributes,
    }

    sink.run(data)

    release = Release.find_by!(metal_archives_key: "metal_archives_key")

    expect(release.name).to eq attributes.fetch("name")
  end
end
