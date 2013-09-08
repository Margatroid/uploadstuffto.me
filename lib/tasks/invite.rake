namespace :invite do
  desc 'Create a new invite'
  task :create, [:desc, :usage] => [:environment] do |t, args|
    unless args.desc
      puts 'Failed to create invite: Missing description.'
      print_creation_syntax
      next
    end

    create_invite(args.desc, args.usage)
  end

  def create_invite(description, usage = 1)
    i = Invite.create(:description => description, :usage => usage.to_i)
    puts "Invite created. Key: #{ i.key }"
  end

  def print_creation_syntax
    puts  "Usage: rake 'invite:create[Invite description, 5]'\n" \
          "  Number of times invite can be used (5) may be omitted,\n" \
          "  will default to 1."
  end
end