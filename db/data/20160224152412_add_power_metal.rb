class AddPowerMetal < ActiveRecord::Migration
  def self.up
    # Power Metal variations
    power_metal = Graph::Genre.create :name => 'Power Metal'
    euro_power =  Graph::Genre.create :name => 'European Power Metal'
    ita_power =   Graph::Genre.create :name => 'Italian Power Metal'
    swe_power =   Graph::Genre.create :name => 'Swedish Power Metal'
    ger_power =   Graph::Genre.create :name => 'German Power Metal'

    us_power =    Graph::Genre.create :name => 'US Power Metal'

    # Associations
    Graph::SubgenreOf.create :from_node => euro_power, :to_node => power_metal
    Graph::SubgenreOf.create :from_node => ita_power, :to_node => euro_power
    Graph::SubgenreOf.create :from_node => swe_power, :to_node => euro_power
    Graph::SubgenreOf.create :from_node => ger_power, :to_node => euro_power

    Graph::SubgenreOf.create :from_node => us_power, :to_node => power_metal
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
