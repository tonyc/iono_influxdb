class AceDataFileParser

  def initialize(io, parser_class)
    @io = io
    @parser_class = parser_class
  end

  def each
    return enum_for(:each) unless block_given?

    @io.read.each_line do |line|
      next if comment?(line)

      yield @parser_class.from_data_file_line(line)
    end
  end

  private
  def comment?(line)
    line =~ /\A[#:]/
  end

end


