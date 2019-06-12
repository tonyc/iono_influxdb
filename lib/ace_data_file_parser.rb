class AceDataFileParser

  def initialize(io, parser_class, options = {})
    @io = io
    @parser_class = parser_class

    @include_all = !!options[:include_all]
  end

  def each
    return enum_for(:each) unless block_given?

    @io.read.each_line do |line|
      next if comment?(line)

      record = @parser_class.from_data_file_line(line)

      yield record if record.nominal? || include_all?
    end
  end

  private
  def comment?(line)
    line =~ /\A[#:]/
  end

  def include_all?
    @include_all
  end

end


