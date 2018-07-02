# -*- encoding : utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'rails_helper'

describe CommentMailer do
  describe "task_notification" do
    let(:project) { create(:project, name: 'First Journey') }
    let(:user) { create(:user, name: 'Spok') }
    let(:task) { create(:task, name:'Create Enterprise', user: user, project: project) }
    let(:comment) { create(:comment, user: user, task: task, description: 'This is the comment per se') }
    let(:recipients) { user.email }

    before(:each) do
      ActionMailer::Base.delivery_method = :test
      ActionMailer::Base.perform_deliveries = true
      ActionMailer::Base.deliveries = []

      CommentMailer.comment_notification(comment.id).deliver_now
    end

    after(:each) do
      ActionMailer::Base.deliveries.clear
    end

    it "should render successfully" do
      expect(lambda { CommentMailer.comment_notification(comment.id) }).not_to raise_error
    end

    describe "rendered without error" do
      let(:mailer) { CommentMailer.comment_notification(comment.id) }

      it "should set correct subject" do
        expect(mailer.subject).to eq("[#{project.name}] #{user.name} made a new comment on ##{comment.task.id} - #{task.name}")
      end
      it "should set correct header To" do
        expect(mailer.header['To'].to_s).to eq(user.email)
      end
      it "should not have more than one to address" do
        expect(mailer.to.size).to eq(1)
      end
      it "should consider CC on recipients address" do
        expect(mailer.cc).to be_nil
      end
      it "should consider CC on recipients address" do
        expect(mailer.bcc).to be_nil
      end
      it "should set correct header From" do
        expect(mailer.header['From'].to_s).to  eq("startrack@example.com.br")
      end
      it "should not have more than one from address" do
        expect(mailer.from.size).to eq(1)
      end
      it "should be multipart" do
        expect(mailer.multipart?).to be false
      end
      it "should set correct charset" do
        expect(mailer.charset).to eq("UTF-8")
      end
      it "should set correct body for text html" do
        expect(mailer.body.to_s).to eq(email_text)
      end
      it "should set correct content type" do
        expect(mailer.content_type).to eq("text/plain; charset=UTF-8")
      end
      it "should deliver successfully" do
        expect(lambda { CommentMailer.comment_notification(comment.id).deliver_now }).not_to raise_error
      end
      describe "and delivered" do
        it "should be added to the delivery queue" do
          expect(lambda { CommentMailer.comment_notification(comment.id).deliver_now }).to change(ActionMailer::Base.deliveries,:size).by(1)
        end
      end
    end
  end

  private
  def email_text
    "The task ##{task.id} - #{task.name} recieved a new comment.\n\n#{user.name} said:\n#{comment.description}\n---\n\nUse the link below to answer this comment:\n#{project_task_url(project.id, task.id)}\n"
  end

end
