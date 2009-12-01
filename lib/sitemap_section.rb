class SitemapSection

  def initialize(name, url)
    @name = name
    @url = url
    @entries = []
  end

  def add_entry(name, url)
    @entries.push(:name => name, :url  => url, :type => :entry)
  end

  def add_subentry(name, url)
    @entries.push(:name => name, :url  => url, :type => :subentry)
  end

  def size
    1 + @entries.size
  end

  def render
    %{
      <div class = "sitemap_category">
        <a href = "#{@url}" class = "sitemap_landing">#{@name.upcase}</a>
        #{@entries.inject('') {|html, e| html + render_entry(e) }}
        #{@in_sub_already ? '</div>' : ''}
      </div>
    }
  end
  
  protected
  def render_entry(entry)
    if entry[:type] == :entry
      ret = @in_sub_already ? '</div>' : ''
      @in_sub_already = false
    else
      ret = !@in_sub_already ? '<div class = "sub_cat">' : ''
      @in_sub_already = true
    end
    ret + "<a href = \"#{entry[:url]}\">#{entry[:name]}</a>"
  end

end