FactoryBot.define do
    sequence :email do |n|
        "test_mail#{n}-#{SecureRandom.hex(10)}@factory.com"
    end

    factory :user, aliases: [:responsible] do
        name 'Leonard McCoy'
        email
        password 'password'
    end

    factory :status do
        name 'ToDo'
    end

    factory :type do
        name 'Bug'
    end

    factory :estimate do
        name 'Light'
    end

    factory :project do
        name 'Project 1'
        description 'This is the test project'
        created_at {1.day.ago}
        updated_at {Time.now}
        time_track true
    end

    factory :task do
        name "Task"
        description "Example task"
        user
        project
        status
        type
        estimate
        responsible
        start_time {Time.now}
    end

    factory :comment do
        description "Comment"
        task
        created_at {Time.now}
        updated_at  {Time.now}
        user
    end
end