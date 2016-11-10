control 'sshd-21' do
  title 'Set SSH Protocol to 2'
  desc 'SSH Protocol v2 is the only allowed version'
  impact 1.0
  ref 'The docs'

  describe sshd_config do
    its('Protocol') { should cmp 2 }
  end
end
