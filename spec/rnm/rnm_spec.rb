require 'spec_helper'

describe "rnc" do
  before do
    `rm -rf sample_app_for_rnm_specs/actual_migrations`
    `mkdir sample_app_for_rnm_specs/actual_migrations`
  end

  it "creates all migrations to rename all component tables" do
    `./bin/rnm EventCounter SuperEventCounter sample_app_for_rnm_specs/actual_migrations sample_app_for_rnm_specs/schema.rb`
    comparison = `cat sample_app_for_rnm_specs/actual_migrations/*`
    expect(comparison).to eq("class MoveCountsFromEventCounterToSuperEventCounter < ActiveRecord::Migration
  def change
    rename_table :event_counter_counts, :super_event_counter_counts
  end
end
class MoveThingsFromEventCounterToSuperEventCounter < ActiveRecord::Migration
  def change
    rename_table :event_counter_things, :super_event_counter_things
  end
end
")
  end
end