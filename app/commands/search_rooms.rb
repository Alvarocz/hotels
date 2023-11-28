class SearchRoom
  prepend SimpleCommand

  def initialize(params)
    @params = params
  end

  def call
    Room.where(@params)
  end
end