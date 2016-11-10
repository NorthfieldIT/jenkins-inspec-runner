# jenkins-inspec-runner
Semi hacky way to get running with chef inspec!

# WHY?
This code was built to see if we could use Jenkins + Jenkins DSL + Chef Inspec to help with compliance reporting. It's a bit hacky but it works pretty well. It helps us solve reporting in relation to compliance as every node will get it's own job to track Inspec runs.

# Can I steal this code?
Yes!

# What does it do?
This code will search your Chef Server for all available nodes. It will then auto generate 1 job per node that will run Chef Inspec against it.

# How do I use it?
* Edit `rakefile.rb` and set the `YOUR_CHEF_SERVER` variable with your Chef Server URL. This will be used to query Chef Server for all your current nodes.
* Edit `base_jobs.groovy` file and change `url("git@github.com:NorthfieldIT/jenkins-inspec-runner.git")` to be the repo containing your version of this code.
* Setup a Jenkins DSL job that will run every 5 minutes containing the following steps:
  * shell step `bundle install` <-- this will install the required gems
  * shell step `rake generate_jobs_file` <-- this will generate a Jenkins DSL file based off `base_jobs.groovy`
  * Process Job DSL step consuming `import_jobs.groovy` <-- this step is consuming the generated file from the previous step.
* Add Inspec tests to the `policies` directory

# Should I have a separate Jenkins for this?
It's probably a good idea since you will have 1 job per node. We currently have 1500+ nodes which means 1500+ jobs in jenkins. Jenkins can consume the DSL within seconds and the amount of jobs doesn't overrun Jenkins.

# Assumptions
This assumes that
* Your node names in Chef Server are the actual FQDN for that specific node.
* Your Chef Credential file is named the same as your username
* Jenkins slave nodes can SSH to all your nodes under `root` and the ssh key on the slave is located at `~/.ssh/inspec_rsa`

