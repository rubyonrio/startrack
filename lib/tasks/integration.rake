ENV['SCM'] = 'git'
INTEGRATION_TASKS = %w( 
    integration:start
    test
    spec:rcov:verify
    integration:finish
)