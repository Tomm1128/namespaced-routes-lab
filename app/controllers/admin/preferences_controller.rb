class Admin::PreferencesController < ApplicationController
  def index
    @preference = Preference.first
  end
end
