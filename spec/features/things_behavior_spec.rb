require 'rails_helper'

describe 'interaction for ThingsController' do
  include HotGlue::ControllerHelper
  include ActionView::RecordIdentifier

  #HOTGLUE-SAVESTART
  #HOTGLUE-END
  


  let!(:thing1) {create(:thing , name: FFaker::Movie.title )}
  
  describe "index" do
    it "should show me the list" do
      visit things_path
      expect(page).to have_content(thing1.name)
      expect(page).to have_content(thing1.which)
    end
  end

  describe "new & create" do
    it "should create a new Thing" do
      visit things_path
      click_link "New Thing"
      expect(page).to have_selector(:xpath, './/h3[contains(., "New Thing")]')
      new_name = FFaker::Movie.title 
      find("[name='thing[name]']").fill_in(with: new_name)
      list_of_thing_which = Thing.defined_enums['which'].keys 
      new_which = list_of_thing_which[rand(list_of_thing_which.length)].to_s 
      find("select[name='thing[which]']  option[value='#{new_which}']").select_option
      click_button "Save"
      expect(page).to have_content("Successfully created")

      expect(page).to have_content(new_name)
      expect(page).to have_content(new_which)
    end
  end


  describe "edit & update" do
    it "should return an editable form" do
      visit things_path
      find("a.edit-thing-button[href='/things/#{thing1.id}/edit']").click

      expect(page).to have_content("Editing #{thing1.name.squish || "(no name)"}")
      new_name = FFaker::Movie.title 
      find("[name='thing[name]']").fill_in(with: new_name)
      list_of_thing_which = Thing.defined_enums['which'].keys 
      new_which = list_of_thing_which[rand(list_of_thing_which.length)].to_s 
      find("select[name='thing[which]']  option[value='#{new_which}']").select_option
      click_button "Save"
      within("turbo-frame#__#{dom_id(thing1)} ") do
        expect(page).to have_content(new_name)
        expect(page).to have_content(new_which)
      end
    end
  end 

  describe "destroy" do
    it "should destroy" do
      visit things_path
      accept_alert do
        find("form[action='/things/#{thing1.id}'] > input.delete-thing-button").click
      end
      expect(page).to_not have_content(thing1.name)
      expect(Thing.where(id: thing1.id).count).to eq(0)
    end
  end
end

