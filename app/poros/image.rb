class Image
  attr_reader :id,
              :location,
              :image_url,
              :description,
              :credit

  def initialize(data, location)
    @id = id
    @location = location
    @image_url = data[:urls][:full]
    @description = data[:description]
    @credit = credit_data(data)
  end

  def credit_data(data)
    {
      source: "unsplash.com",
      author: data[:user][:username],
      author_profile: data[:user][:links][:html]
    }
  end
end
