Rails.application.routes.draw do

  mount SuperEventCounter::Engine => "/super_event_counter"
end
