require 'net/http'

module JekyllFetch
  class JsonFetchTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      @text = text
    end

    def render(context)
	if /(.+) (.+)/.match(@text)
    		base_url = context[$2]
    		resp = Net::HTTP.get_response(URI.parse(base_url.strip))
    		if resp.is_a?(Net::HTTPSuccess)
    		  context[$1] = resp.body
    		else
    		  # Provide an empty response array to avoid JSON parse or index errors downstream
    		  context[$1] = '{"response":[]}'
    		end
    		return ''
  	end
    end
  end
end

Liquid::Template.register_tag('fetch', JekyllFetch::JsonFetchTag)
