require 'rails_helper'

RSpec.describe BackgroundsFacade do
  describe 'happy path' do
    it 'can get the background image for a location' do
      location = 'denver,co'
      background = BackgroundsFacade.get_image(location)

      expect(background.image).to be_a(Hash)
      expect(background.location).to be_a(String)
      expect(background.image_url).to be_a(String)
      expect(background.credit).to be_a(Hash)
    end
  end
end
