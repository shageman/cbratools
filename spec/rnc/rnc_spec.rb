require 'spec_helper'

describe "rnc" do
  before do
    `rm -rf sample_app_for_rnc_specs/actual`
    `cp -R sample_app_for_rnc_specs/original sample_app_for_rnc_specs/actual`
  end

  it "renames a component and all references to it in a CBRA" do
    puts `./bin/rnc EventCounter SuperEventCounter sample_app_for_rnc_specs/actual/the_next_big_thing`
    comparison = `diff -Naur --brief sample_app_for_rnc_specs/actual sample_app_for_rnc_specs/expected`
    expect(comparison).to eq("")
  end
end