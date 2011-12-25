# -*- encoding : utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TaskMailer do
  describe "task_notification" do
    let(:task) { tasks(:room_galaxy) }
    let(:watcher) { task.watchers.first }
    before(:each) do
      setup
    end

    it "should render successfully" do
      lambda { TaskMailer.task_notification(watcher.email, task, @changes, @watchers_changes) }.should_not raise_error
    end

    describe "rendered without error" do
      let(:mailer) { TaskMailer.task_notification(watcher.email, task, @changes, @watchers_changes) }

      it "should set correct subject" do
        mailer.subject.should == "[First Journey] The task ##{task.id} - Room the galaxy has been updated"
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
        mailer.body.to_s.should == read_mail("task_notification")
      end
      it "should set correct content type" do
        mailer.content_type.should == "text/plain; charset=UTF-8"
      end
      it "should deliver successfully" do
        lambda { TaskMailer.task_notification(watcher.email, task, @changes, @watchers_changes).deliver }.should_not raise_error
      end
      describe "and delivered" do
        it "should be added to the delivery queue" do
          lambda { TaskMailer.task_notification(watcher.email, task, @changes, @watchers_changes).deliver }.should change(ActionMailer::Base.deliveries,:size).by(1)
        end
      end
    end
    def setup
      @watchers_changes = {}
      @watchers_changes[:added] = [task.watchers.first]
      @watchers_changes[:removed] = [task.watchers.last]
      @changes = {}
      @changes[:name] = [task.name, "Dominate the galaxy"]
      @changes[:description] = [task.description, "Annihilate the enemy"]
      @changes[:responsible_id] = [task.responsible.name, "Spok"]
      @changes[:type_id] = nil
      @changes[:status_id] = [task.status.name, "Scheduled"]
      @changes[:estimate_id] = [task.estimate.name, "Longstanding"]
    end
  end

  private
  def read_mail(name)
    filename = Rails.root.join('spec','fixtures','task_mailer',"#{name}")
    File.open(filename, 'w') {|f| f.write(mailer.body) } unless File.exists?(filename)
    File.read(filename)
  end
end
