
#require File.dirname(__FILE__) + '/../test_helper'
require 'test_helper'
require 'app/helpers/response_helper'

class ResponseHelperTest < ActiveSupport::TestCase
  include ResponseHelper
  def setup
    @response1 = Response.find(1)
    @questionnaire1 = Questionnaire.find(1)
    @response2 = Response.find(7)
    @questionnaire2 = Questionnaire.find(7)
    @response3 = Response.find(19)
    @questionnaire3 = Questionnaire.find(19)
  end

  def test_compare_scores
    assert_nil ResponseHelper.compare_scores(@response1,@questionnaire1)
    assert_nil ResponseHelper.compare_scores(@response2,@questionnaire1)
    assert_nil ResponseHelper.compare_scores(@response3,@questionnaire1)
  end

  def test_get_total_scores
    map_class = @response1.map.class
    existing_responses = map_class.get_assessments_for(@response1.map.reviewee)
    total, count = ResponseHelper.get_total_scores(existing_responses,@response1)
    assert_equal total, 18
    assert_equal count, 1
    map_class = @response2.map.class
    existing_responses = map_class.get_assessments_for(@response2.map.reviewee)
    total, count = ResponseHelper.get_total_scores(existing_responses,@response2)
    assert_equal total, 19
    assert_equal count, 1
        map_class = @response3.map.class
    existing_responses = map_class.get_assessments_for(@response3.map.reviewee)
    total, count = ResponseHelper.get_total_scores(existing_responses,@response3)
    assert_equal total, 14
    assert_equal count, 1
  end

    def test_notify_instructor

    @assign1=@response1.map.assignment
    assert_equal ResponseHelper.notify_instructor(@assign1,@response1,@questionnaire1,18,1) ,nil
    @assign2=@response2.map.assignment
    assert_equal ResponseHelper.notify_instructor(@assign2,@response2,@questionnaire2,19,1) ,nil
    @assign3=@response3.map.assignment
    assert_equal ResponseHelper.notify_instructor(@assign3,@response3,@questionnaire3,14,1) ,nil

  end

  def test_remove_empty_advice

    @advices = QuestionAdvice.find_all_by_question_id(1)
    @advices = remove_empty_advice(@advices)
    assert_equal @advices.length, 5
    @advices1 = QuestionAdvice.find_all_by_question_id(3)
    @advices1 = remove_empty_advice(@advices1)
    assert_equal @advices1.length, 2
    @advices2 = QuestionAdvice.find_all_by_question_id(6)
    @advices2 = remove_empty_advice(@advices2)
    assert_equal @advices2.length, 0
  end

  def test_construct_table

    @questionType1 = QuestionType.new
    @questionType1.id = 1
    @questionType1.q_type = "Checkbox"
    @questionType1.parameters = "section::tableTitle::tableHeader1|tableHeader2::1|1|1|1"
    @questionType1.question_id = 1
    table_hash = Hash.new
    table_hash = construct_table(@questionType1.parameters.split("::"))
    assert_equal table_hash.to_s, "table_headerstableHeader1|tableHeader2end_tabletrueend_coltruestart_coltruetable_titletableTitlestart_tabletrue"

  end

  def test_get_accordion_title
    @questionType1 = QuestionType.create(:id =>3,:q_type =>"Checkbox",:parameters => "section::tableTitle::tableHeader1|tableHeader2::1|1|1|1", :question_id => 1)
    current_topic = @questionType1.parameters.split("::")

    assert_equal get_accordion_title(current_topic, @questionType1.parameters.split("::")) , nil

  end


 end