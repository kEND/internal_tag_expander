require "test_helper"
require "pry"

class IncludeTagTest < Minitest::Test
  def setup
    @expander = IncludeTag::Expander.new("test/fixtures/sample.md")
  end

  def test_expander_lines_should_return_array
    assert_instance_of Array, @expander.lines 
  end

  def test_expander_lines_should_return_real_lines_from_file
    assert_equal "[[include:manual/title]]\n", @expander.lines[0]
  end

  def test_include_tag_should_match_gollum_include_tags
    assert @expander.include_tag?("[[include:blah-blah]]\n")
    assert @expander.include_tag?("[[include[##]:blah-blah]]\n")
  end

  def test_include_tag_should_not_match_other_lines
    refute @expander.include_tag?("### my doggie\n")
  end

  def test_expander_should_detect_include_tag
    assert @expander.include_tag?(@expander.lines[0])
  end

  def test_expander_should_detect_non_include_tag
    refute @expander.include_tag?(@expander.lines[3])
  end

  def test_expander_should_recognize_base_path_of_input_file
    assert_equal Pathname.new("test/fixtures/sample.md"), @expander.path_to_manifest
  end

  def test_expander_should_return_content_and_top_level_from_line
    assert_equal ["[[include[###]:baller/round]]NO FILE", "###"], @expander.content_and_top_level_from("[[include[###]:baller/round]]\n")
  end

  def test_expander_should_build_viable_path_when_processing_an_include_tag
    assert_equal Pathname.new("test/fixtures/baller/round.md"), @expander.convert_tag_to_path("[[include:baller/round]]\n")
  end

  def test_expander_should_read_from_file_at_include_tag
    test_file_contents = File.read("test/fixtures/manual/introduction.md")
    assert_equal test_file_contents, @expander.convert_tag_to_content("[[include:manual/introduction]]\n")
  end

  def test_should_reset_headings_returns_original_content_if_no_top_level
    assert_equal "## you are awesome", @expander.reset_headings("## you are awesome","")
  end

  def test_should_reset_headings_if_top_level
    assert_equal "#### you are awesome", @expander.reset_headings("## you are awesome","##")
  end

  def test_expander_content_should_match_target
    assert_equal File.read("test/fixtures/manual.md"), @expander.content
  end

  def test_expander_should_take_in_a_level_and_adjust_content_for_appendix
    skip
    assert false
  end
end
