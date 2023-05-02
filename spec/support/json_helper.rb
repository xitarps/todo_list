class String
  def like_json
    JSON.parse(self, symbolize_names: true)
  end
end