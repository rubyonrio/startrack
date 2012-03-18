# -*- encoding : utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CommentMailer do
  describe "task_notification" do
    let(:comment) { comments(:one) }
    let(:recipients) { tasks(:room_galaxy).watchers.first.email }

    it "should render successfully" do
      lambda { CommentMailer.comment_notification(comment.id) }.should_not raise_error
    end

    describe "rendered without error" do
      let(:mailer) { CommentMailer.comment_notification(comment.id) }

      it "should set correct subject" do
        mailer.subject.should == "[First Journey] Spok made a new comment on ##{comment.task.id} - Create Enterprise"
      end
      it "should set correct header To" do
        mailer.header['To'].to_s.should == "kirk@example.com"
      end
      it "should not have more than one to address" do
        mailer.to.size.should == 1
      end
      it "should consider CC on recipients address" do
        mailer.cc.should be_nil
      end
      it "should consider CC on recipients address" do
        mailer.bcc.should be_nil
      end
      it "should set correct header From" do
        mailer.header['From'].to_s.should == "startrack@example.com.br"
      end
      it "should not have more than one from address" do
        mailer.from.size.should == 1
      end
      it "should be multipart" do
        mailer.multipart?.should be_false
      end
      it "should set correct charset" do
        mailer.charset.should == "UTF-8"
      end
      it "should set correct body for text html" do
        mailer.body.to_s.should == read_mail("comment_notification")
      end
      it "should set correct content type" do
        mailer.content_type.should == "text/plain; charset=UTF-8"
      end
      it "should deliver successfully" do
        lambda { CommentMailer.comment_notification(comment.id).deliver }.should_not raise_error
      end
      describe "and delivered" do
        it "should be added to the delivery queue" do
          lambda { CommentMailer.comment_notification(comment.id).deliver }.should change(ActionMailer::Base.deliveries,:size).by(1)
        end
      end
    end
  end

  private
  def read_mail(name)
    filename = Rails.root.join('spec','fixtures','comment_mailer',"#{name}")
    File.open(filename, 'w') {|f| f.write(mailer.body) } unless File.exists?(filename)
    File.read(filename)
  end
end
