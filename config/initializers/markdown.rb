class String
  def markdown
    RDiscount.new(self, :filter_html).to_html
  end
end