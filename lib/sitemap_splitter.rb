# I can split groups of Sitemap

class SitemapSplitter
  attr_accessor :sitemaps

  def initialize(*sitemap_sections)
    @sitemap_sections = sitemap_sections
  end

  def split_in_two
    second_column = @sitemap_sections.dup
    first_column = []
    first_column_size = 0
    
    second_column_size = second_column.inject(0) {|size, section| size += section.size }
    while first_column_size < second_column_size
      last_diff = (first_column_size - second_column_size).abs
      section = second_column.shift
      first_column_size += section.size
      second_column_size -= section.size
      first_column << section
    end

    # If we make our first column too heavy, we drop the the last one back to the second
    if last_diff < (first_column_size - second_column_size)
      second_column.unshift(first_column.pop)
    end

    return first_column, second_column
  end

end