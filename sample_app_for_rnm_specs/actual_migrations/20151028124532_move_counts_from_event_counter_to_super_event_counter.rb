class MoveCountsFromEventCounterToSuperEventCounter < ActiveRecord::Migration
  def change
    rename_table :event_counter_counts, :super_event_counter_counts
  end
end
