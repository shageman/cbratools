class MoveThingsFromEventCounterToSuperEventCounter < ActiveRecord::Migration
  def change
    rename_table :event_counter_things, :super_event_counter_things
  end
end
