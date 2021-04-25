require 'rails_helper'

RSpec.describe UnsplashService do
  describe 'happy path' do
    describe 'fetch data' do
      it 'fetches a background image based on city location input' do
        VCR.use_cassette('unsplash_pic_data') do
          location = 'Denver'
          image_result = UnsplashService.search_images(location)

          expect(image_result).to be_a(Hash)
          expect(image_result).to have_key(:total)
          expect(image_result).to have_key(:total_pages)
          expect(image_result).to have_key(:results)
          expect(image_result[:results]).to be_an(Array)
          expect(image_result[:results].count).to eq(10)
          expect(image_result[:results].first).to be_a(Hash)
          expect(image_result[:results].first).to have_key(:id)
          expect(image_result[:results].first[:id]).to be_a(String)
          expect(image_result[:results].first).to have_key(:created_at)
          expect(image_result[:results].first[:created_at]).to be_a(String)
          expect(image_result[:results].first).to have_key(:updated_at)
          expect(image_result[:results].first[:updated_at]).to be_a(String)
          expect(image_result[:results].first).to have_key(:width)
          expect(image_result[:results].first[:width]).to be_an(Integer)
          expect(image_result[:results].first).to have_key(:height)
          expect(image_result[:results].first[:height]).to be_an(Integer)
          expect(image_result[:results].first).to have_key(:color)
          expect(image_result[:results].first[:color]).to be_a(String)
          expect(image_result[:results].first).to have_key(:blur_hash)
          expect(image_result[:results].first[:blur_hash]).to be_a(String)
          expect(image_result[:results].first).to have_key(:description)
          expect(image_result[:results].first[:description]).to be_a(String)
          expect(image_result[:results].first).to have_key(:alt_description)
          expect(image_result[:results].first[:alt_description]).to be_a(String)
          expect(image_result[:results].first[:alt_description]).to be_a(String)
          expect(image_result[:results].first).to have_key(:urls)
          expect(image_result[:results].first[:urls]).to be_a(Hash)
          expect(image_result[:results].first[:urls]).to have_key(:full)
          expect(image_result[:results].first[:urls][:full]).to be_a(String)
          expect(image_result[:results].first).to have_key(:user)
          expect(image_result[:results].first[:user]).to be_a(Hash)
          expect(image_result[:results].first[:user]).to have_key(:username)
          expect(image_result[:results].first[:user][:username]).to be_a(String)
          expect(image_result[:results].first[:user]).to have_key(:links)
          expect(image_result[:results].first[:user][:links]).to be_a(Hash)
          expect(image_result[:results].first[:user][:links]).to have_key(:html)
          expect(image_result[:results].first[:user][:links][:html]).to be_a(String)
        end
      end
    end
  end
end
