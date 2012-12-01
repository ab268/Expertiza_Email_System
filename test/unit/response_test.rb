class ResponseTest < ActiveSupport::TestCase
  #fixtures :responses
  #fixtures :assignments
  #fixtures :questionnaires
  #fixtures :scores
  #fixtures :response_maps
  #fixtures :questions
  def setup
    # @response1 = Response.find(responses(:response1).id);
    #@response2 = Response.find(responses(:response2).id);
    #@response3 = Response.find(responses(:response3).id);
    @response1 = Response.find(1)

  end

  def test_create
    assert_kind_of Response, @response1
    assert_equal Response.find(:first).map_id, @response1.map_id
    assert_equal Response.find(:first).additional_comment, @response1.additional_comment

  end

  def test_update
    @response1.map_id=1;
    @response1.additional_comment = "abcd"
    @response1.save
    @response1.reload

    assert_equal @response1.map_id, 1
    assert_equal @response1.additional_comment, "abcd"
  end

  def test_get_total_score
    total_score = 0
    @questionnaire1 = Questionnaire.find_by_id(1)
    @questions1 = Question.find(:first)

    @scores1 = Score.find_all_by_response_id(@response1.id)
    @scores1.each {|a|
      total_score   = a.score + total_score
    }
    assert_equal total_score , 19


  end
  def test_notify_on_difference

    assert Mailer.deliver_message(:recipients => "abc@ncsu.edu",
                                  :subject => "Expertiza Notification",
                                  :body => "abc")
  end

  def  test_display_as_html
    @responsemaps1 = ResponseMap.find_by_id(1)

    assert_equal  @responsemaps1.type ,TeamReviewResponseMap
    assert_equal  @responsemaps1.reviewer_id, 1
    assert_equal  @responsemaps1.reviewee_id, 1

    assert_equal @response1.created_at.strftime('%A %B %d %Y, %I:%M%p'), "Saturday October 20 2012, 01:51AM"
    assert_equal @response1.updated_at.strftime('%A %B %d %Y, %I:%M%p'), "Saturday October 20 2012, 01:51AM"
    assert_equal @response1.additional_comment, "review3"
    assert_equal @response1.display_as_html,   "<B>Metareview</B> </B>&nbsp;&nbsp;&nbsp;<a href=\"#\" name= \"review_1Link\" onClick=\"toggleElement('review_1','review');return false;\">hide review</a><BR/><B>Last reviewed:</B> Friday October 14 2011, 03:42AM<div id=\"review_1\" style=\"\"><BR/><BR/><big><b>Question 1:</b> <I>Does it appear that the reviewer has read the author's submission carefully?</I></big><BR/><BR/><TABLE CELLPADDING=\"5\"><TR><TD valign=\"top\"><B>Score:</B></TD><TD><FONT style=\"BACKGROUND-COLOR:gold\">5</FONT> out of <B>5</B></TD></TR><TR><TD valign=\"top\"><B>Response:</B></TD><TD>--- <BR/>- Corrupti et quibusdam sit id ut harum.<BR/>- Recusandae distinctio et nemo.<BR/>- Voluptate provident qui quo.<BR/></TD></TR></TABLE><BR/><big><b>Question 2:</b> <I>Does the review provide sufficient feedback to allow the author to improve his/her work?</I></big><BR/><BR/><TABLE CELLPADDING=\"5\"><TR><TD valign=\"top\"><B>Score:</B></TD><TD><FONT style=\"BACKGROUND-COLOR:gold\">3</FONT> out of <B>5</B></TD></TR><TR><TD valign=\"top\"><B>Response:</B></TD><TD>--- <BR/>- Et sit exercitationem perspiciatis.<BR/>- Nihil cupiditate non harum eaque sed id.<BR/>- Alias est ipsum ea laborum nesciunt sequi et.<BR/></TD></TR></TABLE><BR/><big><b>Question 3:</b> <I>Is the tone of the review respectful toward the author?</I></big><BR/><BR/><TABLE CELLPADDING=\"5\"><TR><TD valign=\"top\"><B>Score:</B></TD><TD><FONT style=\"BACKGROUND-COLOR:gold\">4</FONT> out of <B>5</B></TD></TR><TR><TD valign=\"top\"><B>Response:</B></TD><TD>--- <BR/>- Velit eos amet sit.<BR/>- Quae fugit sint.<BR/>- Et sunt vero voluptatem est.<BR/></TD></TR></TABLE><BR/><big><b>Question 4:</b> <I>Has the reviewer assigned scores fairly?  If not, please comment briefly.</I></big><BR/><BR/><TABLE CELLPADDING=\"5\"><TR><TD valign=\"top\"><B>Score:</B></TD><TD><FONT style=\"BACKGROUND-COLOR:gold\">3</FONT> out of <B>5</B></TD></TR><TR><TD valign=\"top\"><B>Response:</B></TD><TD>--- <BR/>- Facilis velit doloribus minus consectetur nemo.<BR/>- Laborum aspernatur natus.<BR/>- Alias ratione nulla dignissimos ipsam ut consequatur officia.<BR/></TD></TR></TABLE><BR/><B>Additional Comment:</B><BR/>--- <BR/>&nbsp;&nbsp;&nbsp;- Voluptatum iure eum illum quod.<BR/>&nbsp;&nbsp;&nbsp;- Autem eum omnis nostrum laborum officiis eos.<BR/>&nbsp;&nbsp;&nbsp;- Culpa placeat vel.<BR/>&nbsp;&nbsp;&nbsp;</div>"
  end
end