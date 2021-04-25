require 'rails_helper'

RSpec.describe Image do
  describe 'happy path' do
    it 'should build an Image PORO based on input' do
      VCR.use_cassette('get_unsplash_image') do
        location = 'denver,co'
        image_data = (UnsplashService.search_images(location)[:results]).first
        image = Image.new(image_data, location)

        expect(image).to be_an(Image)
        expect(image.location).to be_a(String)
        expect(image.credit).to be_a(Hash)
        expect(image.credit).to have_key(:source)
        expect(image.credit[:source]).to be_a(String)
        expect(image.credit).to have_key(:author)
        expect(image.credit[:author]).to be_a(String)
        expect(image.credit).to have_key(:author_profile)
        expect(image.credit[:author_profile]).to be_a(String)
        expect(image.description).to be_a(String)
        expect(image.image_url).to be_a(String)
      end
    end
  end
end
