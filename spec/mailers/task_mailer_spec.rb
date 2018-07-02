# -*- encoding : utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'rails_helper'

describe TaskMailer do
  describe "task_notification" do
    let(:project) { create(:project, name: 'First Journey') }
    let(:user) { create(:user, name: 'Spok') }
    let(:status) {create(:status, name: 'Created')}
    let(:estimate) {create(:estimate)}
    let(:task) { create(:task, name:'Create Enterprise', user: user, project: project, status: status, estimate: estimate) }
    let(:watcher) { task.watchers.first }
    let(:kirk) { create(:user, name: 'Kirk')}
  
    before(:each) do
      @watchers_changes = task.get_watchers_changes([kirk.id])
      @changes = {}
      @changes[:name] = [task.name, "Dominate the galaxy"]
      @changes[:description] = [task.description, "Annihilate the enemy"]
      @changes[:responsible_id] = [task.responsible.name, user.name]
      @changes[:type_id] = nil
      @changes[:status_id] = [task.status.name, "Scheduled"]
      @changes[:estimate_id] = [task.estimate.name, "Longstanding"]
    end

    it "should render successfully" do
      expect(lambda { TaskMailer.task_notification(task.id, @changes, @watchers_changes) }).not_to raise_error
    end

    describe "rendered without error" do
      let(:mailer) { TaskMailer.task_notification(task.id, @changes, @watchers_changes) }

      it "should set correct subject" do
        expect(mailer.subject).to eq("[#{project.name}] The task ##{task.id} - #{task.name} has been updated")
      end

      it "should set correct header To" do
        recipients = ""
        task.watchers.map { |watcher| recipients << "#{watcher.email}, " }
        recipients << task.user.email

        expect(mailer.header['To'].to_s).to eq(recipients[0..-3])
      end
      it "should not have more than one to address" do
        expect(mailer.to.size).to eq(task.watchers.length + 1)
      end
      it "should consider CC on recipients address" do
        expect(mailer.cc).to be_nil
      end
      it "should consider CC on recipients address" do
        expect(mailer.bcc).to be_nil
      end
      it "should set correct header From" do
        expect(mailer.header['From'].to_s).to eq("startrack@example.com.br")
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
      it "should set correct content type" do
        expect(mailer.content_type).to eq("text/plain; charset=UTF-8")
      end
      it "should deliver successfully" do
        expect(lambda { TaskMailer.task_notification(task.id, @changes, @watchers_changes).deliver_now }).not_to raise_error
      end
      describe "and delivered" do
        it "should be added to the delivery queue" do
          expect(lambda { TaskMailer.task_notification(task.id, @changes, @watchers_changes).deliver_now }).to change(ActionMailer::Base.deliveries,:size).by(1)
        end
      end
    end
  end

end
