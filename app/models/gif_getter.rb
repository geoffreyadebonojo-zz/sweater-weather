class GifGetter
  attr_reader :gif

  def initialize(description)
    @gif = GiphyService.new(description).gif
  end

end
