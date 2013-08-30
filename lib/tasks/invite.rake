namespace :invite do
  desc 'Create a new invite'
  task :create, [:desc, :reuse] => [:environment] do |t, args|
    unless args.desc
      puts 'Failed to create invite: Missing description.'
      print_creation_syntax
      next
    end

    create_invite(args.desc, args.reuse)
  end

  def create_invite(description, reuse = 0)
    i = Invite.create(:description => description, :reuse_times => reuse.to_i)
    puts "Invite created. Key: #{ i.key }"
  end

  def print_creation_syntax
    puts  "Usage: rake 'invite:create[Invite description, 5]'\n" \
          "  Number of times invite can be reused (5) may be omitted,\n" \
          "  will default to 0."
  end
end