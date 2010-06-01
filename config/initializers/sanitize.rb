Sanitize::Config::RELAXED[:transformers] = []
Sanitize::Config::RELAXED[:transformers] << lambda do |env|
      node      = env[:node]
      node_name = node.name
      parent    = node.parent
      return nil unless (node_name == 'param' || node_name == 'embed') &&
              parent.name.to_s.downcase == 'object'
      if node_name == 'param'
        return nil unless movie_node = parent.search('param[@name="movie"]')[0]
        url = movie_node['value']
      else
        url = node['src']
      end
      youtube_url = /^http:\/\/(?:www\.)?youtube\.com\/v\//
      vimeo_url = /^http:\/\/vimeo.com\//
      return nil unless url =~ youtube_url || url =~ vimeo_url

      Sanitize.clean_node!(parent, {
              :elements   => ['embed', 'object', 'param'],
              :attributes => {
                      'embed'  => ['allowfullscreen', 'allowscriptaccess', 'height', 'src', 'type', 'width'],
                      'object' => ['height', 'width'],
                      'param'  => ['name', 'value']
              }
      })
      {:whitelist_nodes => [node, parent]}
end

Sanitize::Config::RELAXED[:transformers] << lambda do |env|
  node = env[:node]
  node_name = node.name
  return nil unless (node_name == 'h2')
  node['id'] = node.text.snake_case
  {:node => node, :attr_whitelist => ["id"]}
end

class String
  def sanitize()
    Sanitize.clean(self, Sanitize::Config::RELAXED)
  end

  def snake_case()
    self.gsub(/\W+/, "_").downcase
  end
end